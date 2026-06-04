-- create database

USE otto_db
GO

CREATE TABLE clean_events (
    session_id BIGINT,
    aid BIGINT,
    ts DATETIME,
    event_type VARCHAR(20)
);

-- 1. import dataset

BULK INSERT clean_events
FROM 'C:\Users\minhn\Downloads\project2_otto-recommender-system\clean_events.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

SELECT TOP 10 *
FROM dbo.clean_events




-- **IMPORTANT: DATA VALIDATION

-- Check nulls

SELECT *
FROM clean_events
WHERE
    session_id IS NULL
    OR aid IS NULL
    OR ts IS NULL;



-- Check duplicates

SELECT
    COUNT(*) AS total_rows,

    COUNT(DISTINCT
        CONCAT(
            session_id,
            aid,
            ts,
            event_type
        )
    ) AS unique_rows

FROM clean_events;

-- 

SELECT TOP 20

    session_id,
    aid,
    ts,
    event_type,

    COUNT(*) AS duplicate_count

FROM clean_events

GROUP BY
    session_id,
    aid,
    ts,
    event_type

HAVING COUNT(*) > 1

ORDER BY duplicate_count DESC;


-- DELETE DUPLICATES

WITH duplicates AS (

    SELECT
        *,

        ROW_NUMBER() OVER (

            PARTITION BY
                session_id,
                aid,
                ts,
                event_type

            ORDER BY session_id

        ) AS rn

    FROM clean_events

)

DELETE FROM duplicates
WHERE rn > 1;


-- Check

SELECT
    COUNT(*) AS total_rows,

    COUNT(DISTINCT CONCAT(
        session_id,
        aid,
        ts,
        event_type
    )) AS unique_rows

FROM clean_events;


-- BUILD ...-LEVEL TABLES

--2. Create Index

/*
CREATE INDEX idx_session
ON dbo.clean_events(session_id);

CREATE INDEX idx_aid
ON dbo.clean_events(aid);

CREATE INDEX idx_ts
ON dbo.clean_events(ts)
*/

--3. BUILD SESSION-LEVEL TABLE

DROP TABLE IF EXISTS session_summary;

SELECT
    session_id,

    COUNT(*) AS total_events,

    SUM(
        CASE
            WHEN event_type = 'clicks'
            THEN 1
            ELSE 0
        END
    ) AS total_clicks,

    SUM(
        CASE
            WHEN event_type = 'carts'
            THEN 1
            ELSE 0
        END
    ) AS total_carts,

    SUM(
        CASE
            WHEN event_type = 'orders'
            THEN 1
            ELSE 0
        END
    ) AS total_orders,

    COUNT(DISTINCT aid) AS unique_products,

    MIN(ts) AS session_start,

    MAX(ts) AS session_end,

    DATEDIFF(
        SECOND,
        MIN(ts),
        MAX(ts)
    ) AS session_duration_sec

INTO session_summary

FROM dbo.clean_events

GROUP BY session_id;


ALTER TABLE session_summary
ADD session_type VARCHAR(20);

UPDATE session_summary
SET session_type =
CASE
    WHEN total_orders > 0 THEN 'Buyer'
    WHEN total_carts > 0 THEN 'Cart User'
    ELSE 'Browser'
END;


-- 4. CHECK SESSION TABLE

SELECT TOP 20 *
FROM session_summary;

SELECT COUNT(*)
FROM session_summary;


-- 5. BUILD PRODUCT-LEVEL TABLE

DROP TABLE IF EXISTS product_summary;

SELECT
    aid,

    COUNT(*) AS total_interactions,

    SUM(
        CASE
            WHEN event_type='clicks'
            THEN 1
            ELSE 0
        END
    ) AS clicks,

    SUM(
        CASE
            WHEN event_type='carts'
            THEN 1
            ELSE 0
        END
    ) AS carts,

    SUM(
        CASE
            WHEN event_type='orders'
            THEN 1
            ELSE 0
        END
    ) AS orders

INTO product_summary

FROM dbo.clean_events

GROUP BY aid;





-- Check

SELECT TOP 10 *
FROM product_summary;
SELECT COUNT(*)
FROM product_summary;


-- 6. ADD CONVERSION METRICS

ALTER TABLE product_summary
ADD cart_rate FLOAT,
    order_rate FLOAT;

-- Update values

UPDATE product_summary
SET
    cart_rate =
        CAST(carts AS FLOAT)
        / NULLIF(clicks,0),

    order_rate =
        CAST(orders AS FLOAT)
        / NULLIF(clicks,0);

ALTER TABLE product_summary
ADD cart_to_order_rate FLOAT;

UPDATE product_summary
SET cart_to_order_rate =
    CAST(orders AS FLOAT)
    / NULLIF(carts,0);


-- Check

SELECT TOP 10 *
FROM product_summary;


-- 7. BUILD FUNNEL TABLE

DROP TABLE IF EXISTS funnel_summary;

SELECT
    event_type,

    COUNT(*) AS total_events,

    COUNT(DISTINCT session_id)
        AS total_sessions

INTO funnel_summary

FROM dbo.clean_events

GROUP BY event_type;

-- Check

SELECT *
FROM funnel_summary;


-- 8. BUILD TIME-LEVEL TABLE 

-- by hour

DROP TABLE IF EXISTS hourly_summary;

SELECT
    DATEPART(HOUR, ts) AS event_hour,

    COUNT(*) AS total_events,

    SUM(
        CASE
            WHEN event_type = 'clicks'
            THEN 1
            ELSE 0
        END
    ) AS total_clicks,

    SUM(
        CASE
            WHEN event_type = 'carts'
            THEN 1
            ELSE 0
        END
    ) AS total_carts,

    SUM(
        CASE
            WHEN event_type = 'orders'
            THEN 1
            ELSE 0
        END
    ) AS total_orders

INTO hourly_summary

FROM dbo.clean_events

GROUP BY DATEPART(HOUR, ts);


ALTER TABLE hourly_summary
ADD cart_rate FLOAT,
    order_rate FLOAT,
    cart_to_order_rate FLOAT;

UPDATE hourly_summary
SET
    cart_rate =
        CAST(total_carts AS FLOAT)
        / NULLIF(total_clicks,0),

    order_rate =
        CAST(total_orders AS FLOAT)
        / NULLIF(total_clicks,0),

    cart_to_order_rate =
        CAST(total_orders AS FLOAT)
        / NULLIF(total_carts,0);


-- by date

DROP TABLE IF EXISTS daily_summary;

SELECT
    CAST(ts AS DATE) AS event_date,

    COUNT(*) AS total_events,

    SUM(
        CASE
            WHEN event_type = 'clicks'
            THEN 1
            ELSE 0
        END
    ) AS total_clicks,

    SUM(
        CASE
            WHEN event_type = 'carts'
            THEN 1
            ELSE 0
        END
    ) AS total_carts,

    SUM(
        CASE
            WHEN event_type = 'orders'
            THEN 1
            ELSE 0
        END
    ) AS total_orders

INTO daily_summary

FROM dbo.clean_events

GROUP BY CAST(ts AS DATE);

ALTER TABLE daily_summary
ADD cart_rate FLOAT,
    order_rate FLOAT,
    cart_to_order_rate FLOAT;

UPDATE daily_summary
SET
    cart_rate =
        CAST(total_carts AS FLOAT)
        / NULLIF(total_clicks,0),

    order_rate =
        CAST(total_orders AS FLOAT)
        / NULLIF(total_clicks,0),

    cart_to_order_rate =
        CAST(total_orders AS FLOAT)
        / NULLIF(total_carts,0);


-- Check

SELECT *
FROM hourly_summary;
SELECT *
FROM daily_summary;


-- 9. BUILD TRANSITION TABLE

DROP TABLE IF EXISTS transition_summary_v2;

SELECT

    current_aid,
    current_type,

    next_aid,
    next_type,

    COUNT(*) AS transition_count

INTO transition_summary_v2

FROM (

    SELECT

        session_id,

        aid AS current_aid,

        event_type AS current_type,

        LEAD(aid) OVER (
            PARTITION BY session_id
            ORDER BY ts
        ) AS next_aid,

        LEAD(event_type) OVER (
            PARTITION BY session_id
            ORDER BY ts
        ) AS next_type

    FROM dbo.clean_events

) t

WHERE next_aid IS NOT NULL

GROUP BY

    current_aid,
    current_type,

    next_aid,
    next_type;

ALTER TABLE transition_summary_v2
ADD transition_probability FLOAT;

WITH totals AS (

    SELECT
        current_aid,
        current_type,

        SUM(transition_count)
            AS total_outgoing

    FROM transition_summary_v2

    GROUP BY
        current_aid,
        current_type

)

UPDATE t

SET transition_probability =
    CAST(t.transition_count AS FLOAT)
    / totals.total_outgoing

FROM transition_summary_v2 t

JOIN totals
    ON t.current_aid = totals.current_aid
   AND t.current_type = totals.current_type;

ALTER TABLE transition_summary_v2
DROP COLUMN transition_probability;


-- Check

SELECT TOP 30 *
FROM transition_summary_v2
ORDER BY transition_probability DESC;

