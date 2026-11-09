# Soal 3 - Dashboard Visualization

---

## Background

PT Sinar Niaga Nusantara (a fictional company) is a distributor of IT devices and office supplies. It sells through two channels, **Online** (website and marketplaces) and **Offline** (stores and field sales), across six regions in Indonesia.

Today, management reviews performance using static spreadsheets sent by email. Each team uses its own numbers, and meetings often turn into debates about whose figures are correct. The company wants **one dashboard** that everyone can rely on to monitor sales performance every month.

The dashboard will be used by two groups:

- **Board of Directors:** needs a quick overview of overall company health in less than five minutes.
- **Regional Sales Managers:** need to see how their own region performs and where it needs attention.

During requirement gathering, the stakeholders said:

- **Head of Sales:** "Put revenue at the top in big numbers. That is the number my team is measured on."
- **Regional Sales Manager:** "I want to compare my region with the other regions and with last year."
- **Board of Directors:** "Keep it simple. If I need a manual to read it, it is not useful."

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

- If you completed **Soal 1**, use your cleaned dataset from Soal 1 as the source for your dashboard.
- If you did **not** choose Soal 1, you are still responsible for making sure the data is fit for use. List the main issues you found and the assumptions you made in your design notes.
- A dashboard is only trusted if its numbers are correct. A well-designed dashboard with wrong numbers will be evaluated as such.

---

## Tasks

Tools are free to choose: Power BI, Tableau, Looker Studio, Metabase, Excel, or Python (e.g. Streamlit, Plotly Dash). We value clear design and correct numbers over advanced features.

### Task 1 - Define the KPIs

- Decide which metrics the dashboard should show for each user group, and explain why.

### Task 2 - Build the Dashboard

- Build an **overview page** for the Board of Directors and a **detail page** for Regional Sales Managers, with filters that fit their needs.

### Task 3 - Design for Clarity

- Choose chart types, layout, and colours that make the dashboard easy to read for non-technical users.

### Task 4 - Highlight Key Insights

- Show **three to five** insights that a user can see directly from your dashboard.

---

## Deliverables

Place all your work inside the `Soal 3 - Dashboard Visualization/` folder:

| Deliverable | Description |
|---|---|
| **Dashboard** | The source file (e.g. `.pbix`, `.twbx`, `.xlsx`, `.py`) **or** a public link written in `DESIGN_NOTES.md`. If you use a link, make sure it is accessible without login. |
| **Screenshots** | A PDF or PNG export of **every page** of the dashboard, so reviewers can see it without installing any software. |
| **`DESIGN_NOTES.md`** | Maximum **one page**: who the users are, which KPIs you chose and why, key design decisions, data preparation assumptions, and your three to five insights. |

---

## Evaluation Criteria

### What makes a strong submission

- A user can answer "How are we doing, and where should we look?" within a few minutes.
- Every chart has a clear purpose; nothing is there just to fill space.
- Comparisons have context (e.g. against last year or against other regions), not just a single number.
- Numbers on the dashboard match the numbers in the design notes.

### What weakens a submission

- Too many charts on one page, or charts that need explanation to be understood.
- Wrong or inconsistent numbers, or totals that do not match between pages.
- Charts that look impressive but do not answer a business question (e.g. 3D charts, pie charts with many slices).

---

Good luck! We look forward to seeing how you design.
