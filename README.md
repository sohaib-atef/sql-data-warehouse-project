# Data Warehouse and Analytics Project

Building a modern data warehouse with SQL Server, including ETL processes, data modeling, and analytics.

This project demonstrates a comprehensive data warehousing and analytics solution, from building a data warehouse to generating actionable insights. Designed as a portfolio project highlights industry best practices in data engineering and analytics.

![Data Flow Diagram](./docs/data-architecture.drawio.svg)

## Project Overview

This project involves:

1. Data Architecture: Designing a modern data warehouse using Medallion architecture **Bronze**, **Silver** and **Gold** layers.
2. ETL Pipeline: Extracting, transforming, and loading data from source systems into the warehouse.
3. Data Modeling: Developing fact and dimention tables optimized for analytical queries.
4. Analytics & Reporting: Creating SQL-based reports and dashboards for actionable insights.

## Important Links & Tools

- [Datasets](..\datasets): Access to the project dataset (csv files).
- [SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads): Lightweight server for hosting your SQL database.
- [DrawIO](..\docs\warehouse-architecture.drawio.html): Design data architecture, models, flows and diagrams.

## Repository Structure

```...
sql-data-warehouse-project/
|
|-- datasets/                          # Raw datasets used for the project (ERP and CRM data).
|
|-- docs/                              # Project documentation and architectrue details.
|   |-- naming-conventions.md          # Consistent naming guidelines for tables, columns, and files.
|   |-- data-catalog.md                # Catalog of datasets, including field descriptions and metadata.
|
|-- tests/                             # Test scripts and quality files.
|
├── README.md                          # Project overview and instructions.
├── LICENSE                            # License information for the repository.
└── .gitignore                         # Files and directories to be ignored by Git.
```

