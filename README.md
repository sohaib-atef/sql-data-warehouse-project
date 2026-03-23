# Data Warehouse and Analytics Project

👋 Welcome to the Project

This repository is a practical implementation of a Data Warehouse using the Medallion Architecture. The project structure and technical vision were heavily influenced by Data with Baraa’s 30-hour SQL course, which provided a solid roadmap for understanding how data should be structured and managed in a professional environment.

### The Objective

The goal of this project is to build a reliable Single Source of Truth by transforming fragmented data into an organized analytical system.

Key Focus Areas:

1. **Architecture**: Implementation of Bronze, Silver, and Gold layers.
2. **Integrity**: Ensuring data quality and consistency throughout the ETL process.
3. **Scalability**: Designing a Star Schema that supports efficient business reporting.

## Project Architecture

The project follows the Medallion Architecture to transform fragmented data into a scalable analytical system.

![Data Flow Diagram](./docs/data-architecture.drawio.svg)

1. **Bronze Layer**: Raw data ingestion from CSV files (ERP & CRM) into SQL Server.
2. **Silver Layer**: Data cleansing, standardization, and normalization to ensure integrity.
3. **Gold Layer**: Business-ready data modeled into a Star Schema for reporting and analytics.

## Important Links & Tools

To ensure a lightweight and efficient workflow, this project was developed using:

- **[Datasets](./datasets)**: Access to the project dataset (csv files).
- **[SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)**: Lightweight server for hosting your SQL database.
- **[Visual Studio Code (VS Code)](https://code.visualstudio.com/):** Used as the primary IDE instead of traditional SSMS for a more streamlined development experience.
- **[SQL Server (mssql) Extension](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql):** Integrated into VS Code to simulate the production database environment, allowing for:
  - Writing and executing complex T-SQL queries.
  - Managing database connections and exploring schemas.
  - Mocking real-world SQL Server environments locally for testing ETL logic.
- **[draw.io](https://www.drawio.com/):** For designing and maintaining live, editable data architecture and flow diagrams within the workspace.

## How to Run the Project

Follow these steps to set up the project locally:

1. **Clone the Repository**:

```bash
git clone https://github.com/sohaib-atef/sql-data-warehouse-project.git
```

2. **Database Setup**:
    - Ensure SQL Server Express is installed.
    - Run `scripts/init_database.sql` first to create the database, then execute the scripts in `bronze/`, `silver/`, and `gold/` folders sequentially.
3. **Explore Data**: Check the `datasets/` directory to understand the raw CSV structures from CRM and ERP systems.
4. **Environment**: Open the folder in "VS Code" and ensure the "mssql" extension is active to run queries directly.

## Repository Structure

```bash
sql-data-warehouse-project/
│
│── datasets/                           # Raw datasets used for the project (ERP and CRM data)
│
│── docs/                               # Project documentation and architecture details.
│   │── images/                         # Contains all the images and diagrams used in this project
│   │── naming-conventions.md           # Consistent naming guidelines for tables, columns, and files
│   │── data-catalog.md                 # Catalog of datasets, including field descriptions and metadata
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│   ├── init_database.sql               # Script for inializing the schema
│
│── tests/                              # Test scripts and quality files
│
├── .gitignore                          # Files and directories to be ignored by Git
├── README.md                           # Project overview and instructions
└── LICENSE                             # License information for the repository
```

---

**Quick Navigation**: [Naming Conventions](./docs/naming-conventions.md) | [Data Catalog](./docs/data-catalog.md)
