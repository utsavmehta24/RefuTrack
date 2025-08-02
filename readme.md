# RefuTrack 🌍  
*A Data‑Driven Refugee Dashboard Built with MySQL & Power BI*

**RefuTrack** aggregates decades of UN refugee and IDP data (1951–2001), cleans and stores it in MySQL via Python ETL, and visualises it in an interactive Power BI dashboard.

This README now mirrors your current repo file structure. Let me know if anything still doesn’t match; I’m happy to tweak!

---

## Table of Contents
1. [Project Overview](#project-overview)  
2. [Live Dashboard](#live-dashboard)  
3. [Repository Structure](#repository-structure)  
4. [Setup Instructions](#setup-instructions)  
   - [Prerequisites](#prerequisites)  
   - [Step-by-step Guide](#step-by-step-guide)  
5. [Visual Insights](#visual-insights)  
6. [How to Modify or Extend](#how-to-modify-or-extend)  
7. [About & Acknowledgements](#let-me-know-if)

---

## Project Overview

RefuTrack helps explore global forced displacement trends—**who hosts the most refugees**, **where they originate from**, and **how internal displacements evolve**, using a dataset spanning half a century.

- ETL pipeline: **Python** scripts read raw CSV, transform and load data into **MySQL**.
- Dashboard: Visual analytics created using **Microsoft Power BI Desktop (.pbix)**.

You can read the full background and analysis process in the Medium article:  
**“RefuTrack: A Data‑Driven Look into Global Refugee Trends with MySQL & Power BI”** by Utsav Mehta.

---

## Live Dashboard  
![Dashboard Screenshot](/assets/Global%20Displacement%20Overview.png)  


Open **Refugee_Analysis.pbix** in Power BI to view the actual interactive similar interface.

---

## Repository Structure

| Folder / File                  | Description                                                  |
|-------------------------------|--------------------------------------------------------------|
| `assets/`                     | Contains images/screenshots referenced in this README.       |
| `data/`                       | CSV files pulled from UNHCR’s database (e.g. refugees.csv).  |
| `sql/`                        | MySQL schema and data ingestion scripts (`create_tables.sql`, ETL SQL statements). |
| `Refugee_Analysis.pbix`       | Power BI dashboard file ready for interactive analysis.      |
| `readme.md`                   | This file—updated to reflect the above structure.            |
| `.gitignore`                  | Ignores Python caches, secrets, and system files.            |

---

## Setup Instructions

### Prerequisites

- **MySQL Server** (can run locally or via Docker)
- **Python 3.8+** with `pandas`, `mysql-connector-python` (or `mysqlclient`)
- **Power BI Desktop** (Windows) or **Power BI Pro Service** online

### Step-by-step Guide

1. **Clone the repository**
   ```
   git clone https://github.com/utsavmehta24/RefuTrack.git
   cd RefuTrack```

2. **Load raw CSV data into MySQL**

   * Review `sql/create_tables.sql` and apply it to your MySQL instance:

     ```sql
     CREATE DATABASE refutrack;
     USE refutrack;
     -- paste the schema from create_tables.sql
     ```
   * Use a Python script (or your own) similar to:

     ```python
     import pandas as pd
     import mysql.connector

     df = pd.read_csv("data/refugees.csv")
     df = df.replace({"": None}).astype({"Year": int})
     conn = mysql.connector.connect(host="localhost",user="youruser",passwd="yourpass",database="refutrack")
     df.to_sql(name="persons_of_concern", con=conn, if_exists="append", index=False)
     ```

   *If you prefer pure SQL loaders, check inside `sql/`—you may find `.sql` files to load CSVs directly from `data/`.*

3. **Refresh and explore the Power BI dashboard**

   * Open `Refugee_Analysis.pbix` in Power BI Desktop.
   * Use **Get Data → MySQL Database**, point to your `refutrack` schema.
   * Load or DirectQuery the `persons_of_concern` table.
   * Test all tabs: **Asylum Rankings**, **Origins Map**, **Trends**, **IDP Returns**.

---

## Visual Insights & Sample SQL Queries

Here are a few sample queries you can run in MySQL to explore the data before opening Power BI:

```
-- Top 10 countries hosting refugees (cumulative)
SELECT asylum_country, SUM(refugees) AS total_refugees
  FROM persons_of_concern
 GROUP BY asylum_country
 ORDER BY total_refugees DESC
 LIMIT 10;

-- Refugee figures over time (year by year)
SELECT Year, SUM(refugees) AS refugees_by_year
  FROM persons_of_concern
 GROUP BY Year
 ORDER BY Year ASC;

-- IDPs returned to origin country (highlights return progress)
SELECT origin_country, SUM(idps_returned) AS total_returned
  FROM persons_of_concern
 WHERE idps_returned > 0
 GROUP BY origin_country
 ORDER BY total_returned DESC;
```

## Insights you may find (as described in the original write‑up):

* Rapid refugee population growth in post‑1945 decades and during regional conflicts in Asia/Africa.
* Some countries (France, Germany, Pakistan, India, etc.) host large numbers of refugees consistently.
* Data quality issues around “Unknown” or “Various” origin categories.
* Return and reintegration of IDPs tracked via origin-vs-destination tables.

---

## How To Modify or Extend

1. **Update dataset beyond 2001**

   * Pull new `.csv` files from UNHCR or IDC, place in `data/`, and re-run the ETL.

2. **Add new visuals in `assets/` and Power BI**

   * Example: breakdowns by geographic region, overlaying population metrics.

3. **Migrate to Power BI Service or Embedded**

   * Convert `.pbix` for use on the web with Power BI Pro or Embedded APIs.

4. **Enhance schema normalization**

   * Add ISO country codes, separate dimension tables, or add staging and audits.

---

## About & Acknowledgments

* **Author:** Utsav Mehta – \[@utsavmehta24 on GitHub]
* **Original write‑up** and detailed project walkthrough available in the Medium article *“RefuTrack: A Data‑Driven Look into Global Refugee Trends with MySQL & Power BI”*.

---

## visual-insights

### 🧍‍♂️ Refugees vs. General Population

![Refugees VS. Population Distribution](/assets/Refugees%20VS.%20Population%20Distribution.png)

* Certain countries carry disproportionate refugee burdens despite having relatively smaller populations.
* This visual helps emphasize the **intensity** of displacement compared to national population sizes.

---

### 📈 Refugees and Total Population Over Time

![Refugees and Total Population over the years](/assets/Refugees%20and%20Total%20Population%20over%20the%20years.png)

* Refugee populations rose sharply post–1970 due to regional conflicts.
* **A widening gap** between total population and refugees hints at a mix of crises and humanitarian responses across decades.

---

### 🏠 Returned IDPs by Country of Origin

![Returned IDPs by Country of Origin](/assets/Returned%20IDPs%20by%20Country%20of%20Origin.png)

* This matrix reveals countries where **internally displaced people (IDPs)** were able to return home.
* A positive metric suggesting conflict resolution or improved governance in those regions.

---

### 🌐 Top Host Countries by Refugee Population

![Top Host Countries](assets/Top%20Host%20Countries%20by%20Refudee%20Population.png?raw=true)

* Countries like **Pakistan, Germany, and Iran** consistently rank among the top hosts.
* This highlights **ongoing regional obligations** borne by specific host nations.

---

### 🗺️ Refugees by Country of Asylum

![Total Refugees by Asylum Country](/assets/Total%20Refugees%20by%20Country%20of%20Asylum.png?raw=true)

* Geospatial view showing where displaced populations are hosted globally.
* Large concentrations are found across Europe, South Asia, and parts of Africa.

---

### 🌍 Refugees by Country of Origin

![Total Refugees by Country of Origin](https://github.com/utsavmehta24/RefuTrack/blob/main/assets/Total%20Refugees%20by%20Country%20of%20Origin.png?raw=true)

* Major refugee-origin countries include **Afghanistan, Sudan, and Iraq**, reflecting decades of unrest and war.
* Also highlights large portions with "Unknown" origin, suggesting **reporting inconsistencies**.

---

### 📅 Yearly Refugee Totals

![Total Refugees by Year](/assets/Total%20Refugees%20by%20Year.png?raw=true)

* Significant growth in refugee numbers in the **1980s and 1990s**, aligned with historical geopolitical events.
* The trend curve reflects both **new displacements and stagnant return rates**.

---

Let me know if you’d like this section above **"How to Modify or Extend"**, or if you’d prefer it earlier in the README. I can also caption the insights using your Medium text if you drop in exact lines you'd like quoted.


## Let me know if:

* You added or renamed files in another folder (e.g. a Python script in root).
* You want badges, license notice, or CI/CD steps.
* You prefer a branch-based organization or want to use WSL/PowerShell instructions.

Happy to keep iterating—just show me what your repo listing looks like, and I’ll align it exactly!

[1]: https://github.com/utsavmehta24/RefuTrack "GitHub - utsavmehta24/RefuTrack"
