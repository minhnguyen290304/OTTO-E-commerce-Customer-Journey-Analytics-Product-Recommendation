# OTTO E-commerce Customer Journey Analytics & Product Recommendation

<img src="https://spinscale.de/posts/2020-06-22-implementing-a-modern-ecommerce-search/mainsite-otto.png" width="100%">

## Project Overview

Online retailers offer millions of products, giving customers an enormous range of choices. While product variety can improve customer satisfaction, it can also create decision fatigue, making it more difficult for shoppers to discover relevant products and complete purchases.

This project analyzes over **41 million customer interaction events** from the OTTO e-commerce dataset - the largest German online shop with more than 10 million products from over 19,000 brands - to understand customer behavior, identify conversion opportunities, and uncover navigation patterns throughout the shopping journey.

Beyond traditional descriptive analytics, the project also develops a transition-based recommendation framework that leverages customer navigation behavior to generate product recommendations based on observed browsing and purchasing patterns.

The objective is to demonstrate how customer journey analytics can support both business decision-making and recommendation system development.


---

## Business Objectives

The project focuses on four key business questions:

- How do customers interact with products throughout their shopping sessions?
- Where do the largest conversion drop-offs occur within the purchasing funnel?
- Which products contribute most effectively to customer engagement and conversion?
- How can customer navigation patterns be utilized to improve product recommendations?

---

## Dataset Overview

The dataset originates from the <a href="https://www.kaggle.com/competitions/otto-recommender-system/overview">OTTO Recommender Systems Challenge</a> and contains customer interaction data collected from one of Europe's largest online retailers.

Each record represents a customer action within a shopping session and includes:

- Session ID
- Product ID
- Timestamp
- Event Type

Customer actions are categorized into three event types:

| Event Type | Description |
|------------|-------------|
| Click | Product viewed by customer |
| Cart | Product added to shopping cart |
| Order | Product purchased |

The final analytical dataset contains:

| Metric | Value |
|---------|---------|
| Total Sessions | 1.06M |
| Total Events | 41.6M |
| Products Viewed | 1.57M |
| Orders | 899K |
| Overall Conversion Rate | 2.39% |

---

# Project Workflow

```text
Raw Event Data
      ↓
Data Validation & Preparation (SQL Server)
      ↓
Customer Behavior Analysis
      ↓
Customer Journey Analysis
      ↓
Recommendation Model Development (Python)
      ↓
Interactive Dashboard Development (Power BI)
      ↓
Business Insights & Recommendations
```

The project begins by validating and preparing large-scale clickstream data using SQL Server. Customer behavior patterns, conversion trends, and engagement metrics are then analyzed to understand how users interact with products throughout their shopping sessions.

Customer navigation paths are subsequently reconstructed to identify common transitions between viewed, carted, and purchased products. These transition patterns form the foundation of a recommendation framework developed in Python, enabling next-product suggestions based on observed customer behavior.

Finally, insights from both the analytics and recommendation components are consolidated into an interactive Power BI dashboard designed to support business decision-making.

<b>🔧 Tools Used: </b>
<br>

| Tool | Purpose |
|--------|---------|
| <img src="https://img.shields.io/badge/MS_SQL_Server-CC2927?style=flat-square&logo=microsoftsqlserver&logoColor=white"> | Data validation, cleaning, transformation, and analytical queries |
| <img src="https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white">| Recommendation framework development and transition analysis |
| <img src="https://img.shields.io/badge/Power_BI-F2C811?style=flat-square&logo=powerbi&logoColor=black"> | Dashboard development and business intelligence reporting |



---

# Executive Summary

<img src="dashboard preview/executive summary.png" width="100%">

The analysis reveals that customer activity is highly concentrated around product browsing behavior, with more than 90% of all events consisting of product views. Despite strong engagement levels, only 2.39% of customer interactions ultimately result in a completed purchase, highlighting the urgency of having solutions for conversion optimization..

Customer sessions demonstrate clear behavioral patterns, including repeated product interactions, concentrated browsing behavior, and identifiable pathways leading toward conversion. Several products consistently outperform others across engagement and purchasing metrics, suggesting opportunities for targeted merchandising and recommendation strategies.

Transition analysis further reveals strong relationships between products viewed, added to cart, and ultimately purchased. These relationships provide a foundation for recommendation systems that can improve product discovery and customer experience.

Beyond descriptive analytics, customer navigation patterns were utilized to develop a transition-based recommendation framework capable of generating next-product suggestions based on observed user behavior.

---

# 5. Analytical Findings

## 5.1 Customer Behavior Analysis

<img src="dashboard preview/user behavior analysis.png" width="100%">

Customer sessions are highly skewed, with a relatively small proportion of users generating the majority of platform activity. The average session contains approximately 39 events and 23 product interactions, indicating that customers frequently explore multiple products before making purchasing decisions.

More than half of all sessions (56.95%) remain in a browsing stage without progressing toward purchase-oriented behavior. This highlights a significant opportunity to improve product discovery and customer engagement through personalization strategies.

---

## 5.2 Product Performance Analysis

<img src="dashboard preview/product analysis.png" width="100%">

Product performance analysis reveals substantial differences between product popularity and purchasing effectiveness across the catalog.

Product **29735** generated the highest customer attention, while product **485256** recorded the highest number of add-to-cart actions. However, the most purchased product was **80222**, demonstrating that customer interest does not always translate directly into purchases.

The analysis also identified product **454458** as the highest-converting product in the dataset, achieving an exceptional **83.61% conversion rate**. In contrast, several highly viewed products such as **322370**, **1502122**, and **9548** generated substantial traffic but didn't generate any orders, indicating potential friction points within the conversion process.

The scatter analysis further shows that while higher click volumes generally correlate with more orders, several products significantly outperform or underperform relative to their traffic levels. These outliers present opportunities for deeper investigation into pricing, product presentation, inventory availability, or customer demand characteristics.

Key business implications include:

- Prioritizing high-converting products for merchandising and promotional campaigns.
- Investigating products with strong traffic but weak conversion performance.
- Identifying effective recommendation candidates based on purchase success rather than popularity alone.
- Supporting inventory allocation decisions using both engagement and purchasing metrics.

---

## 5.3 Time-Based Analysis

<img src="dashboard preview/time analysis.png" width="100%">

Customer activity exhibits clear temporal patterns across both hourly and daily levels.

Traffic volume peaks during evening hours, while conversion performance reaches its highest levels earlier in the day. This suggests that browsing and purchasing behaviors may follow different temporal patterns.


---

## 5.4 Customer Journey & Transition Analysis

<img src="dashboard preview/transition analysis p1.png" width="100%">

Customer journey reconstruction was performed by sequencing user interactions within each session and analyzing how customers progressed between products and event types throughout the shopping experience.

Across more than **1.06 million sessions**, the analysis identified **40.55 million product-to-product transitions**, generating **26.12 million unique product pairs**. This transition network provides a detailed view of how customers navigate the product catalog before making purchasing decisions.

The most common transition observed was: **485256_clicks → 485256_clicks**

which occurred **3,750 times**, indicating that customers frequently revisit the same product multiple times before progressing further in the buying process. Similar repeated-view patterns were also observed for products **1460571**, **1733943**, and **1603001**. The analysis further reveals that approximately **50.61% of customer actions involve repeated interactions with previously viewed products**, while **49.39% represent cross-product exploration**. This suggests that customers alternate between comparing alternatives and revisiting products of interest before making purchase decisions.

The transition distribution reveals that approximately **84% of all transitions occur between product views**, while only a relatively small proportion progress into cart or order actions. This finding aligns with the overall conversion funnel, where browsing behavior dominates the customer journey and only a subset of sessions move toward purchase completion.

<img src="dashboard preview/transition analysis p2.png" width="100%">

---

## 6. Recommendation Framework

While the primary focus of this project is customer journey analytics, the transition patterns identified throughout the analysis were further leveraged to develop a recommendation framework in Python.

Rather than recommending products based solely on overall popularity, the framework utilizes observed customer navigation behavior to identify products that are most likely to be viewed, added to cart, or purchased next within a session.

The recommendation logic was built using more than **40.5 million customer transitions** and **26.1 million unique product relationships** extracted from historical browsing and purchasing journeys. By analyzing how customers move between products throughout a session, the framework captures behavioral signals that traditional popularity-based recommendations may overlook.

Several transition types were incorporated into the recommendation process, including:

- Product View → Product View
- Product View → Add to Cart
- Add to Cart → Purchase
- Cross-product navigation sequences
- Repeated product interactions

Products with strong transition relationships were ranked as recommendation candidates, allowing the framework to generate next-product suggestions based on actual customer behavior patterns.

This approach demonstrates how customer journey analytics can be translated into practical recommendation strategies, helping customers discover relevant products more efficiently while supporting conversion-oriented business objectives.

The framework was inspired by session-based recommendation methodologies commonly used in large-scale e-commerce environments, where customer actions within the current session are leveraged to predict future interactions. By focusing on behavioral sequences rather than static product popularity, recommendations become more context-aware and better aligned with customer intent.

---

# 7. Key Business Insights

### Insight 1: High Engagement Does Not Necessarily Translate into Purchases

Customers actively browse and interact with products, generating over 41.6 million events across 1.06 million sessions. However, browsing activity overwhelmingly dominates the customer journey, with only 2.39% of interactions resulting in completed orders. This gap highlights a disconnect between customer interest and purchasing behavior.

### Insight 2: Not All Popular Products Convert Equally

Products generating the highest traffic are not necessarily the strongest performers from a conversion perspective. Product evaluation should balance both engagement and purchasing outcomes.

### Insight 3: Customer Navigation Behavior Is Predictable

Many customer journeys follow repeatable navigation patterns, indicating that future interactions can be anticipated and supported through recommendation systems.

### Insight 4: Product Relationships Influence Conversion

Products frequently viewed or purchased together create natural recommendation opportunities that can improve product discovery and customer experience.

---

# 8. Business Recommendations

### Improve Product Discovery

Introduce more personalized product suggestions throughout the customer journey to help users navigate large product catalogs more efficiently.

### Optimize Conversion Funnel Performance

Focus on reducing friction between browsing and purchasing stages through targeted promotions, dynamic recommendations, and improved product presentation.

### Prioritize High-Performing Products

Allocate greater visibility to products demonstrating both strong engagement and strong conversion performance.

### Leverage Customer Journey Intelligence

Utilize customer navigation patterns to identify strategic product pairings and cross-selling opportunities.

### Enhance Recommendation Capabilities

Integrate transition-based recommendation logic into the shopping experience to provide relevant next-product suggestions based on real-time customer behavior.

---

## Author

**Minh Nguyen**

---

## 📫 Connect With Me

- LinkedIn: https://www.linkedin.com/in/minh-nguyen-9016a627a/
- Email: minhnguyen29p304@gmail.com

---

⭐ Nothing is impossible
💫 Learn, learn more, learn forever
