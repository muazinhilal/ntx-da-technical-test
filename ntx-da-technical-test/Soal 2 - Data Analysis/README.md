# Soal 2 - Data Analysis

---

## Background

PT Sinar Niaga Nusantara (a fictional company) is a distributor of IT devices and office supplies. It sells through two channels, **Online** (website and marketplaces) and **Offline** (stores and field sales), across six regions in Indonesia.

At the latest management review, several people shared their views:

- **Head of Sales:** "Revenue in FY2026 grew by **15%** compared to FY2025. The team did a great job."
- **Finance:** "But gross profit went down over the same period."
- **Head of Sales:** "Profit fell because supplier costs for laptops went up this year. That is outside our control."
- **Marketing:** "Our promotions drove the growth, so we should increase them next year."

The Board of Directors has asked you, as a Data Analyst, to answer one question:

> **"Revenue is growing, but profit is falling. What is happening, what will happen next, and what should we do about it?"**

Your audience is **non-technical management**. They care about clear findings backed by evidence, not about the complexity of your methods.

---

## Dataset

Soal 1, 2, and 3 all use the **same dataset**, located in the Soal 1 folder:

```
../Soal 1 - Data Inspection, Cleaning and Processing/sales_transactions_raw.csv
```

- **Period:** September 2024 to September 2026
- **Grain:** one row = one transaction (one product per order)
- **Column definitions:** see the data dictionary in the Soal 1 folder

**Key definitions used in this assessment:**

| Term | Definition |
|---|---|
| Fiscal year (FY) | 1 September to 31 August. Example: FY2026 = 1 Sep 2025 to 31 Aug 2026 |
| Revenue | `qty × unit_price × (1 − discount)` |
| Gross profit | `revenue − cost` |
| Gross margin | `gross profit ÷ revenue` |

**About data preparation:**

- If you completed **Soal 1**, use your cleaned dataset from Soal 1 as the input for this analysis.
- If you did **not** choose Soal 1, you are still responsible for making sure the data is fit for analysis. Keep it brief: list the main issues you found and the assumptions you made in a short section at the start of your notebook.
- Either way, your conclusions are only as good as the data behind them. Findings built on unchecked data will be evaluated as such.

---

## Tasks

Treat the tasks below as one connected story, not separate exercises. Tools are free to choose (Excel, Google Sheets, SQL, Python, R, or a BI tool). We value clear reasoning over advanced techniques.

### Task 1 - Descriptive Analysis: *What happened?*

- Describe sales and profit performance in FY2025 and FY2026, including how it changes over time.

### Task 2 - Diagnostic Analysis: *Why did it happen?*

- Explain why revenue grew while gross profit fell, supported by evidence from the data.

### Task 3 - Predictive Analysis: *What is likely to happen next?*

- Estimate revenue for the next three months and explain your assumptions. Machine learning is not required.

### Task 4 - Prescriptive Analysis: *What should we do?*

- Recommend two or three actions to management, with their expected impact.

### Task 5 - Executive Summary

- Summarise your key findings and recommendations for the Board of Directors.

---

## Deliverables

Place all your work inside the `Soal 2 - Data Analysis/` folder:

| Deliverable | Description |
|---|---|
| **Analysis file** | Notebook (`.ipynb`), SQL scripts, or spreadsheet (`.xlsx`) containing your working, findings, and explanations. Another analyst should be able to follow your steps and get the same numbers. |
| **Executive summary** | Maximum **one page**, as a Markdown or PDF file, written for non-technical management. |

---

## Evaluation Criteria

### What makes a strong submission

- Every conclusion is backed by numbers from the data, not by general statements.
- The story is connected: what happened → why → what next → what to do.
- Assumptions and limitations are stated openly.
- Numbers in the executive summary match the numbers in the analysis file.

### What weakens a submission

- Describing charts without explaining what they mean for the business.
- Generic recommendations such as "increase marketing" without evidence or estimated impact.
- Reporting numbers without checking whether the underlying data supports them.

---

Good luck! We look forward to seeing how you think.
