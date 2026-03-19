# **Naming Conventions**
This document outlines the naming conventions used for schemas, tables, views, columns, and other objects in the data warehouse.


## **Table of Contents**
1. [General Principles](#)
2. [Table Naming Conventions](#)
    - [Bronze Rules](#)
    - [Silver Rules](#)
    - [Gold Rules](#)
3. [Column Naming Conventions](#)
    - [Surrogate Keys](#)
    - [Technical Columns](#)
4. [Stored Procedure](#)
---

## **General Priciples**
- **Naming Conventions**: use `snake_case` with lower case letters and uncerscore "`_`" to separate words.
- **Language**: use English for all names.
- **Reserved Words**: avoid using SQL reserved words as object names.


## **Table Naming Conventions**
### **Bronze Rules**
- All names must start with the source system name, and table names must match their original names without renaming.
- **`<sourcesystem>_<entity>`**
    - `<sourcesystem>`: Name of the source system (e.g., `crm`, `erp`)
    - `<entity>`: Exact table name from the source system.
    - Example: `crm_customer_info` => Customer information from the CRM system.