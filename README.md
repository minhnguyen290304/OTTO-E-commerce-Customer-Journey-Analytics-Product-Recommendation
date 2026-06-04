# OTTO E-commerce Customer Journey Analytics & Product Recommendation

## Project Overview

This project analyzes over **41.6 million e-commerce events** from the OTTO Recommendation Challenge dataset to understand customer behavior, identify conversion opportunities, and build a transition-based product recommendation engine.

By combining **SQL**, **Power BI**, and **Python**, the project transforms large-scale clickstream data into actionable customer journey insights, product performance analysis, and recommendation logic.

---

## Dashboard Preview

<p align="center">
  <img src="dashboard%20preview/transition%20analysis.png" width="100%">
</p>

---

## Business Objectives

- Analyze customer browsing and purchasing behavior
- Identify conversion bottlenecks across the customer journey
- Discover high-performing and underperforming products
- Understand product navigation patterns
- Build a recommendation engine based on transition behavior
- Support customer engagement and experience optimization

---

## Dataset Information

**Source:** OTTO Multi-Objective Recommender System Challenge (Kaggle)

### Dataset Scale

| Metric | Value |
|----------|----------|
| Sessions | 1.06M |
| Events | 41.6M |
| Product Views | 15.7M |
| Orders | 899K |
| Product Transitions | 40.5M |
| Unique Product Pairs | 26.1M |

### Event Types

- Clicks
- Add-to-Carts
- Orders

---

## Tools & Technologies

### Data Processing

- Microsoft SQL Server
- Window Functions
- Common Table Expressions (CTEs)
- Aggregations & Data Modeling

### Data Visualization

- Power BI
- DAX
- Funnel Analysis
- Sankey Analysis
- Customer Journey Dashboards

### Recommendation Engine

- Python
- Pandas
- Transition-Based Recommendation Logic

---

## Dashboard Pages

### 1. Executive Overview

Provides a high-level business view:

- Total Sessions
- Total Events
- Product Views
- Orders
- Conversion Funnel
- Event Distribution

### 2. User Behavior Analysis

Analyzes customer engagement patterns:

- Events per Session Distribution
- Session Duration Analysis
- Product Exploration Behavior
- User Segmentation
- Click-to-Order Relationship

### 3. Product Analysis

Evaluates product performance:

- Most Viewed Products
- Most Added-to-Cart Products
- Most Ordered Products
- Highest Conversion Products
- Lowest Conversion Products

### 4. Time Analysis

Examines temporal customer behavior:

- Hourly Activity Trends
- Daily Activity Trends
- Peak Traffic Hours
- Peak Conversion Hours

### 5. Transition Analysis

Investigates customer navigation paths:

- Product-to-Product Navigation
- View-to-Cart Journeys
- Cart-to-Order Journeys
- Repeated vs Cross-Product Actions
- Product Transition Networks

---

## Recommendation Engine

A lightweight recommendation engine was developed using product transition frequencies extracted from customer sessions.

### Methodology

1. Generate product transitions from session events
2. Aggregate transition frequencies
3. Create transition dictionaries
4. Recommend products based on recent session behavior

### Example

If customers frequently navigate:

**Product A → Product B**

then Product B becomes a recommendation candidate whenever Product A appears in a session.

---

## Key Insights

### Customer Journey

- Over 90% of interactions are product views
- Significant drop-off occurs between click and cart stages
- Only a small proportion of viewed products eventually convert into orders

### User Behavior

- Most sessions contain relatively few interactions
- Product exploration follows a long-tail distribution
- Conversion rates vary significantly across different time periods

### Product Performance

- Most viewed products are not always the highest converting products
- Several niche products demonstrate strong conversion performance
- Repeated interactions play an important role before purchase

---

## Project Structure

```text
OTTO-E-commerce-Customer-Journey-Analytics-Product-Recommendation

├── SQL
│   ├── Data Preparation.sql
│   ├── Customer Journey Analysis.sql
│   └── Product Transition Analysis.sql
│
├── Power BI
│   └── OTTO_Customer_Journey_Analytics.pbix
│
├── Python
│   ├── Recommendation Engine.ipynb
│   └── Submission Generation.ipynb
│
├── dashboard preview
│   ├── executive overview.png
│   ├── user behavior analysis.png
│   ├── product analysis.png
│   ├── time analysis.png
│   ├── transition analysis.png
│
└── README.md
```

---

## Skills Demonstrated

- SQL Query Optimization
- Customer Journey Analytics
- Funnel Analysis
- User Behavior Analytics
- Product Analytics
- Recommendation Systems
- Power BI
- Python
- Data Visualization
- Business Intelligence

---

## Author

**Minh Nguyen**

Aspiring Data Analyst focused on Customer Analytics, Business Intelligence, and Data-Driven Decision Making.
