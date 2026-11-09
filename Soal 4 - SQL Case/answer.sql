/* =====================================================================
   Soal 4 - SQL Case (AdventureWorks)
  
   Global assumptions:
   - Grain: header = 1 row per order, detail = 1 row per order line.
   - Header.SubTotal = SUM(detail.LineTotal): verified, zero difference for all
     31,465 orders (both total 109,846,381). Order / customer / territory
     revenue uses header.SubTotal (excl. tax & freight) -> no header x detail
     fan-out. Product-level revenue uses detail.LineTotal.
   - OrderDate is text 'YYYY-MM-DD hh:mm:ss.000'; months via strftime.
   - OnlineOrderFlag may load as 1/0 or 'True'/'False' depending on the import
     method, so both forms are handled.
   ===================================================================== */


-- =====================================================================
-- Test Case 1 - Monthly sales summary 2013
-- Assumptions:
--  * All orders in 2013 are counted (no Status filter); 2013 has 12 full months,
--    so there is no partial period.
--  * unique_customers is distinct per month -> NOT additive across months.
--  * online_order_pct = share of orders with OnlineOrderFlag = true.
-- =====================================================================
SELECT
    strftime('%Y-%m-01', OrderDate)                                   AS order_month,
    COUNT(*)                                                          AS total_orders,
    COUNT(DISTINCT CustomerID)                                        AS unique_customers,
    ROUND(SUM(SubTotal), 2)                                           AS total_revenue,
    ROUND(SUM(SubTotal) * 1.0 / COUNT(*), 2)                          AS avg_order_value,
    ROUND(100.0 * SUM(CASE WHEN OnlineOrderFlag IN (1, '1', 'True', 'true')
                           THEN 1 ELSE 0 END) / COUNT(*), 2)          AS online_order_pct
FROM Sales_SalesOrderHeader
WHERE OrderDate >= '2013-01-01' AND OrderDate < '2014-01-01'
GROUP BY strftime('%Y-%m-01', OrderDate)
ORDER BY order_month;

/* INSIGHT TC1
   2013 revenue is about 43.6M. Order volume jumps ~2.4x in June -> July
   (719 -> 1,740 orders) and stays near 1,800-2,100 afterwards, but revenue does
   NOT follow: average order value collapses from ~5-8K (Jan-Jun) to ~1.6-2.8K
   (Jul-Dec), and online share rises from ~70-77% to ~90-95%.
   The business shifted from a few large reseller (store) orders to many small
   online consumer orders. Growth in order count therefore overstates revenue
   growth; revenue is still lumpy because it depends on big B2B orders
   (e.g. Jun 5.1M vs Nov 3.3M despite 3x more orders in Nov).
*/


-- =====================================================================
-- Test Case 2 - Revenue by category & subcategory (all recorded sales)
-- Assumptions:
--  * Grain = order line; revenue = SUM(LineTotal) (already net of discount).
--  * products_sold = distinct ProductID sold; units_sold = SUM(OrderQty).
--  * LEFT JOIN + COALESCE so products without a subcategory are not silently
--    dropped (they would appear as 'Uncategorized'; none are sold in this data,
--    and the grand total equals SUM(LineTotal) of the detail table).
--  * pct_of_category_revenue = subcategory revenue / category revenue (window SUM).
-- =====================================================================
WITH line_items AS (
    SELECT
        COALESCE(pc.Name, 'Uncategorized')  AS category,
        COALESCE(ps.Name, 'Uncategorized')  AS subcategory,
        d.ProductID,
        d.OrderQty,
        d.LineTotal
    FROM Sales_SalesOrderDetail d
    JOIN Production_Product p                  ON p.ProductID = d.ProductID
    LEFT JOIN Production_ProductSubcategory ps ON ps.ProductSubcategoryID = p.ProductSubcategoryID
    LEFT JOIN Production_ProductCategory pc    ON pc.ProductCategoryID = ps.ProductCategoryID
),
by_subcat AS (
    SELECT
        category,
        subcategory,
        COUNT(DISTINCT ProductID)  AS products_sold,
        SUM(OrderQty)              AS units_sold,
        SUM(LineTotal)             AS total_revenue
    FROM line_items
    GROUP BY category, subcategory
)
SELECT
    category,
    subcategory,
    products_sold,
    units_sold,
    ROUND(total_revenue, 2)                                              AS total_revenue,
    ROUND(100.0 * total_revenue
          / SUM(total_revenue) OVER (PARTITION BY category), 2)          AS pct_of_category_revenue
FROM by_subcat
ORDER BY category, total_revenue DESC;

/* INSIGHT TC2
   Bikes generate ~94.7M of ~109.8M total revenue (~86%); Components ~11.8M,
   Clothing ~2.1M, Accessories ~1.3M. Within Bikes, Road (46%) and Mountain (39%)
   dominate; Touring is 15%. Within every category the top 1-2 subcategories carry
   most of the revenue (Mountain + Road Frames = 73% of Components; Helmets = 38% of
   Accessories; Jerseys = 35% of Clothing).
   Accessories and Clothing sell high unit volumes at low prices (e.g. Helmets
   19.5K units for 0.48M) - useful for attach-rate/cross-sell, but not revenue drivers.
   Long-tail subcategories (Pumps, Locks, Chains, Cleaners, <1.5% of category with
   1 product each) are candidates for range rationalisation.
*/


-- =====================================================================
-- Test Case 3 - Territory trend 2013 (MoM growth + running total)
-- Assumptions:
--  * revenue = SUM(header.SubTotal) per TerritoryID per month.
--  * An explicit territory x month calendar starting Dec 2012 is built, so LAG always
--    compares with the previous CALENDAR month (not just the previous row) and a
--    month with no sales shows revenue = 0 instead of being skipped.
--  * January 2013 is compared with December 2012 (computed in the CTEs, the 2012 row
--    is removed only in the final SELECT).
--  * mom_growth_pct is NULL when prev_month_revenue = 0 (division by zero guard).
--  * RUNNING TOTAL = YEAR-TO-DATE 2013 (resets in January 2013), not all-time.
--    Reason: the question is scoped to 2013; an all-time total would mix in
--    2011-2012 revenue and make the 2013 trend and cross-territory comparison
--    harder to read. (For all-time, remove the 2013 filter from the final SELECT
--    and compute the SUM window in `calc`.)
-- =====================================================================
WITH months AS (
    SELECT '2012-12-01' AS m UNION ALL SELECT '2013-01-01' UNION ALL SELECT '2013-02-01'
    UNION ALL SELECT '2013-03-01' UNION ALL SELECT '2013-04-01' UNION ALL SELECT '2013-05-01'
    UNION ALL SELECT '2013-06-01' UNION ALL SELECT '2013-07-01' UNION ALL SELECT '2013-08-01'
    UNION ALL SELECT '2013-09-01' UNION ALL SELECT '2013-10-01' UNION ALL SELECT '2013-11-01'
    UNION ALL SELECT '2013-12-01'
),
monthly AS (
    SELECT
        TerritoryID,
        strftime('%Y-%m-01', OrderDate) AS m,
        SUM(SubTotal)                   AS revenue
    FROM Sales_SalesOrderHeader
    WHERE OrderDate >= '2012-12-01' AND OrderDate < '2014-01-01'
    GROUP BY TerritoryID, strftime('%Y-%m-01', OrderDate)
),
spine AS (
    SELECT t.TerritoryID, t.Name AS territory, mo.m
    FROM Sales_SalesTerritory t
    CROSS JOIN months mo
),
filled AS (
    SELECT s.TerritoryID, s.territory, s.m, COALESCE(mt.revenue, 0) AS revenue
    FROM spine s
    LEFT JOIN monthly mt ON mt.TerritoryID = s.TerritoryID AND mt.m = s.m
),
calc AS (
    SELECT
        territory,
        m,
        revenue,
        LAG(revenue) OVER (PARTITION BY territory ORDER BY m) AS prev_month_revenue
    FROM filled
)
SELECT
    territory,
    m                                                            AS order_month,
    ROUND(revenue, 2)                                            AS revenue,
    ROUND(prev_month_revenue, 2)                                 AS prev_month_revenue,
    ROUND(100.0 * (revenue - prev_month_revenue)
          / NULLIF(prev_month_revenue, 0), 2)                    AS mom_growth_pct,
    -- window runs after WHERE (Dec 2012 already removed) -> YTD 2013 starting in January
    ROUND(SUM(revenue) OVER (PARTITION BY territory
                             ORDER BY m
                             ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS running_total_ytd
FROM calc
WHERE m >= '2013-01-01'
ORDER BY territory, m;

/* INSIGHT TC3
   2013 YTD revenue by territory: Southwest 9.1M (largest, ~21%), Canada 6.2M,
   Northwest 6.0M, Australia 4.2M, France 3.8M, UK 3.6M, Central 3.0M, Northeast 2.6M,
   Germany 2.6M, Southeast 2.4M. Most territories dip in Jan vs Dec 2012
   (Northwest -74%, Northeast -45%, France -40%) and peak in Jun/Jul-Oct.
   MoM growth is extremely volatile in the smaller / reseller-driven territories
   (France +429% in Jun then -65% in Jul; Germany +347% in May; Central +123% in Dec),
   because a few large store orders swing the month. Only Southwest, Canada and
   Australia are comparatively stable. MoM % should be read together with absolute
   revenue and ideally a 3-month average, not as a standalone signal.
*/


-- =====================================================================
-- Test Case 4 - Retention by first-order cohort & customer type
-- Assumptions:
--  * Cohort = year of the customer's first order (MIN(OrderDate)).
--  * customer_type = 'Store' if Customer.StoreID is present, else 'Individual'.
--  * Only customers with at least one order are included (INNER JOIN from header).
--  * Orders are counted at header level (no line-level double counting).
--  * lifetime_revenue = SUM(SubTotal) over all of a customer's orders up to 2014-06-30.
--  * repeat customer = 2 or more orders, regardless of the time gap.
--  * Observation windows differ per cohort (2014 has only ~6 months, and June 2014
--    looks incomplete), so repeat rates across cohorts are not fully comparable
--    (right-censoring).
-- =====================================================================
WITH customer_stats AS (
    SELECT
        h.CustomerID,
        CASE WHEN c.StoreID IS NOT NULL AND c.StoreID <> '' THEN 'Store' ELSE 'Individual' END AS customer_type,
        CAST(strftime('%Y', MIN(h.OrderDate)) AS INTEGER)  AS cohort_year,
        COUNT(*)                                           AS orders,
        SUM(h.SubTotal)                                    AS lifetime_revenue
    FROM Sales_SalesOrderHeader h
    JOIN Sales_Customer c ON c.CustomerID = h.CustomerID
    GROUP BY h.CustomerID, customer_type
)
SELECT
    cohort_year,
    customer_type,
    COUNT(*)                                                    AS customers,
    SUM(CASE WHEN orders >= 2 THEN 1 ELSE 0 END)                AS repeat_customers,
    ROUND(100.0 * SUM(CASE WHEN orders >= 2 THEN 1 ELSE 0 END)
          / COUNT(*), 2)                                        AS repeat_rate_pct,
    ROUND(AVG(orders * 1.0), 2)                                 AS avg_orders_per_customer,
    ROUND(AVG(lifetime_revenue), 2)                             AS avg_lifetime_revenue
FROM customer_stats
GROUP BY cohort_year, customer_type
ORDER BY cohort_year, customer_type;

/* INSIGHT TC4
   Answer to the CEO: Stores are retained very well, individuals much less so, and
   revenue really comes from stores.
   - Store customers: 93-98% repeat rate, 4-8 orders and ~72K-178K lifetime revenue
     per customer. Stores are only 635 of 19,119 ordering customers (~3%) but ~73% of all
     revenue (80.5M of 109.8M; 75% in 2013).
   - Individuals: 2011-2012 cohorts repeat at 83-94% (~2 orders, ~4-5K), but the 2013
     cohort only 34% and 2014 only 7%, with ~1K and ~0.5K lifetime revenue. Part of
     this is censoring (less time to reorder), but the 2013-14 cohorts are also much
     larger (8.5K and 6.0K customers) and far lower value: the mass-market online
     push brings volume, not retention or revenue.
   - Store acquisition has stalled: only 4 new store customers in 2014 versus
     ~205-218 per year in 2011-2013, so the main revenue engine is not being replenished.
*/
