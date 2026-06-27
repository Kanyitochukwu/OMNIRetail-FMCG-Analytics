# OMNIRetail-FMCG-Analytics
End-to-end SQL and Power BI sales and supply chain analytics for an Indian FMCG retail


Have you ever wondered why your favorite item is suddenly out of stock at the grocery store? Usually, we assume it's because the product is highly popular, but data often tells a different story.
I built this project to bridge the gap between front-end retail sales and back-end supply chain logistics using the Indian Fast-Moving Consumer Goods (FMCG) Sales dataset for 2024. My goal was to move beyond basic reporting and create an interactive, app-style analytical tool that directly answers the most critical questions a leadership team faces.

# Executive Strategy (The "So What?")
Writing SQL queries and building charts is only half the job; the real value lies in solving business problems. Here is exactly how this data answers management's top questions:

# Why are sales declining?
Sales drops here are not a demand issue; they are a supply chain failure. My correlation analysis proved that when vendor lead times stretch past 7 days, it causes severe out-of-stock events (1,624 total deficit occurrences). Customers cannot buy what is not on the shelf.
# Which products are most profitable?
The products moving the most units are frequently not the most profitable. By calculating total revenue alongside average margin percentages, this dashboard directs management to prioritize shelf space for high-margin brands rather than just high-volume ones.
# How can we improve customer satisfaction?
The fastest way to lose a customer is an empty shelf. Fixing the vendor lead-time bottleneck guarantees product availability. Furthermore, the data shows that converting shoppers into loyalty members increases unit volume, meaning management should create targeted rewards specifically for the highest-value age demographics identified in the dataset.
# How can we reduce operating costs?
The data uncovered a massive operational waste: a hardcoded 50-unit reorder threshold applied to all categories regardless of their actual sales velocity. Moving to dynamic reorder points reduces inventory bloat, warehousing space, and holding costs.
# Should the company expand into a new market?
The data recommends a cautious approach. By evaluating revenue and profit margins across different cities and store formats, the analysis suggests testing new markets via Online/Omnichannel rollouts first. This secures high margins without the heavy physical overhead of brick-and-mortar stores.

# The Tools I Used
 SQL: Used for the foundational data modeling. I wrote extensive queries (DDL, aggregations, conditional logic) to clean the data, extract descriptive statistics, and map out baseline trends before visualizing anything.
 Power BI: Used for advanced DAX, custom report tooltips, dynamic KPI risk cards, and continuous statistical charting.
 UI/UX Design: Designed with a "Modern Web App" aesthetic, featuring vertical navigation for an intuitive stakeholder experience.

# The Dashboard Experience
This dashboard operates like a premium software application, divided into three focused operational pages:

 Executive Overview: A high-level look at overall market performance, revenue distribution, and customer demographic breakdowns.

 Product Intelligence: A granular brand analysis page featuring Custom Hover Tooltips. Hovering over a high-level category triggers a hidden mini-dashboard revealing the brands driving that category.

 Inventory & Operational Risk: The diagnostic center. This page features dynamic risk cards for Total Deficit Occurrences and a continuous scatter plot with a built-in statistical trendline mapping the exact relationship between vendor delays and out-of-stock risks.

