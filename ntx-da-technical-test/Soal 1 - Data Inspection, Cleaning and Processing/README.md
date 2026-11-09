# Soal 1 - Data Inspection, Cleaning and Processing

---

## Background

**PT Sinar Niaga Nusantara** is a fictional Indonesian retailer selling electronics and office supplies (laptops, smartphones, accessories, networking gear, printers, and office equipment) through two channels: **offline stores** handled by sales representatives, and an **online** channel handled by the system.

Ahead of the upcoming management sales review, the Sales Operations team exported the raw order-line transactions from the transaction system into a single CSV file. The export has not been reviewed by anyone. You have just joined the analytics team, and you are asked to make this data **trustworthy and analysis-ready** before the analysis team uses it for revenue, margin, and performance reporting.

You are not expected to know how the data was produced. Inspect it, decide what is wrong, decide how to treat it, and **explain your reasoning** as you would to a colleague who inherits your work.

### Objective

This challenge assesses your ability to:

- **Inspect** an unfamiliar dataset and find quality problems systematically
- **Clean** the data with justified, reproducible decisions
- **Process** the data into a form that is ready for analysis
- **Communicate** assumptions, trade-offs, and open questions

---

## Dataset

The dataset is located in this folder:

```
sales_transactions_raw.csv
```

### Data Dictionary

| Column          | Description                                                                    |
| --------------- | ------------------------------------------------------------------------------ |
| `order_id`      | Order identifier                                                               |
| `order_date`    | Date the order was placed                                                      |
| `region`        | Region of the sale                                                             |
| `channel`       | Sales channel (Online / Offline)                                               |
| `customer_id`   | Customer identifier                                                            |
| `customer_type` | Customer segment (Retail, UMKM, Korporat)                                      |
| `sales_rep`     | Sales representative code                                                      |
| `category`      | Product category                                                               |
| `product`       | Product name                                                                   |
| `qty`           | Quantity ordered                                                               |
| `discount`      | Discount applied to the line, as a fraction between 0 and 1 (e.g. `0.05` = 5%) |
| `status`        | Order status: `Completed`, `Cancelled`, `Returned`                             |
| `unit_price`    | List price per unit (IDR)                                                      |
| `revenue`       | Line revenue after discount (IDR)                                              |
| `cost`          | Cost of goods sold for the line (IDR)                                          |

---

## Tasks

Complete all tasks in a single Python notebook.

1. **Inspect** the dataset. Find out whether it can be trusted, and support what you find with evidence.
2. **Clean** it. Decide what to do about what you found, and be ready to defend those decisions.
3. **Process** it so the analysis team can use it for the sales review:
   - Create analysis-ready fields, such as:
     - Date parts (year, month, quarter, year-month)
     - Net revenue and gross profit that correctly handle returns
     - Gross margin (%)
   - Produce the following summary tables from the cleaned data:
     - Monthly net revenue, gross profit, and margin %
     - Net revenue and margin by `region` × `category`
     - Top 10 customers by net revenue

---

## Deliverables

Place all your work inside the `Soal 1 - Data Inspection, Cleaning and Processing/` folder. Present your work in a **Jupyter Notebook** (or an equivalent environment) that includes:

| Deliverable                      | Description                                                                                    |
| -------------------------------- | ---------------------------------------------------------------------------------------------- |
| **Documentation**                | Explain your thought process and assumptions.                                                  |
| **Data processing and analysis** | Show how you got from the raw data to the final data. Surface anything unusual and discuss it. |
| **Insights and recommendations** | Summarize what the data tells you and what the client should do about it.                      |

---

## Evaluation Criteria

| Criteria      | What we look for                                   |
| ------------- | -------------------------------------------------- |
| Inspection    | Depth and rigour, with findings backed by evidence |
| Cleaning      | Sound, justified decisions                         |
| Processing    | Correct and useful metrics and summaries           |
| Code quality  | Readable and reproducible                          |
| Communication | Clear narrative and honesty about uncertainty      |

### What makes a strong submission

- Goes beyond the obvious and backs its claims with evidence.
- Makes clear decisions and explains the reasoning and assumptions behind them.
- Runs top to bottom from the raw file.
- Ends with insights and recommendations grounded in the data.
