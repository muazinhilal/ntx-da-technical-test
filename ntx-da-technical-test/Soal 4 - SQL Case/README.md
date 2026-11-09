# Soal 4 - SQL Case

---

## Background

This assessment is designed for the Data Analyst position. It uses the **AdventureWorks** dataset, which represents a company that manufactures and sells bicycles, components, clothing, and accessories. The company serves two types of customers: **stores** (resellers, B2B) and **individuals** (B2C, primarily online).

In this scenario, stakeholders from Finance, Merchandising, Sales, and the CEO's office have each submitted a business question. Your task is to answer them using SQL against the company's sales data.

|                 |                                                                  |
| --------------- | ---------------------------------------------------------------- |
| **Dataset**     | AdventureWorks sales data (orders from 2011-05-31 to 2014-06-30) |
| **Database**    | Any SQL engine of your choice                                    |
| **Test cases**  | 4 (aggregation, join, window functions, business analysis)       |
| **Duration**    | Approximately 60–75 minutes                                      |
| **Total score** | 100 points                                                       |

---

## Dataset

All CSV files are located in the `datasets/` folder inside this folder.

**Setup:**

- **Database:** Choose any SQL database engine you are comfortable with. Optionally, you can run it in a Docker container.
- **Data loading:** Ingest all CSV files from the `datasets/` folder into your database.

---

## Tasks

Complete the test cases below in order.

**Ground rules:**

- Write your queries in the SQL dialect of your chosen engine.
- Correctness matters, but so does your reasoning. State your assumptions in comments (for example, how you handle ties, `NULL` values, or partial periods).
- For each test case, summarize the key insight that you draw from your query results.

### Test Case 1 - Aggregation & Basic Analysis (20 pts)

**Scenario:** The Finance team would like an overview of how sales performed in 2013.

Build a monthly sales summary for **2013** with the following columns:

| Column             | Definition                     |
| ------------------ | ------------------------------ |
| `order_month`      | First day of the month         |
| `total_orders`     | Number of orders               |
| `unique_customers` | Distinct customers who ordered |
| `total_revenue`    | Sum of `SubTotal`              |
| `avg_order_value`  | Average `SubTotal` per order   |
| `online_order_pct` | Percentage of online orders    |

Sort the results by month and round monetary values to two decimal places.

### Test Case 2 - Join (25 pts)

**Scenario:** The Merchandising team is reviewing the performance of the product catalog.

Using all recorded sales, show the revenue by **category and subcategory** with the following columns:

`category`, `subcategory`, `products_sold` (distinct), `units_sold`, `total_revenue` (based on `LineTotal`), and `pct_of_category_revenue`.

Sort by category, then by revenue in descending order.

### Test Case 3 - Analytical Thinking & Window Functions (30 pts)

**Scenario:** Sales leadership wants to understand how each territory is trending over time.

For each territory and each month of **2013**, return `revenue`, `prev_month_revenue`, `mom_growth_pct` (month-over-month growth in %), and the **running total** of revenue.

- January 2013 must be compared with December 2012 rather than returning `NULL` growth.
- State whether your running total is all-time or year-to-date, and explain your reasoning.

### Test Case 4 - Business Analysis (25 pts)

**Scenario:** The CEO asks: _"Are we retaining customers, and where does our revenue really come from?"_

Group customers by the **year of their first order** (cohort) and by `customer_type`, where a customer is a `Store` if it is linked to a store (`StoreID` is present) and an `Individual` otherwise. For each group, return `customers`, `repeat_customers` (customers with 2 or more orders), `repeat_rate_pct`, `avg_orders_per_customer`, and `avg_lifetime_revenue`.

---

## Deliverables

Place all your work inside the `Soal 4 - SQL Case/` folder:

| Deliverable | Description |
|---|---|
| **`answer.sql`** | A single file containing all of your queries. |

Rules for `answer.sql`:

- Label each answer with a comment, for example `-- Test Case 1`.
- Provide one query (or one CTE chain) per test case. The entire file must run from top to bottom without errors on your database.
- Document your assumptions as comments next to the relevant query.
- Below each query, add a short comment block with the business insight you derived from the results.

---

## Evaluation Criteria

| Area                    | What a strong answer demonstrates                                                                             |
| ----------------------- | ------------------------------------------------------------------------------------------------------------- |
| **Correctness**         | Correct grain (order vs. line vs. customer), no double counting when joining header and detail, valid filters |
| **SQL fluency**         | Appropriate joins, effective use of window functions, readable CTEs, no unnecessary subqueries                |
| **Edge cases**          | Handling of ties, `NULL` and empty values, division by zero, and partial periods                              |
| **Analytical thinking** | Clearly stated assumptions, sanity-checked results, and awareness of whether numbers are comparable           |
| **Communication**       | Clear aliases, helpful comments, and a concise business insight                                               |
