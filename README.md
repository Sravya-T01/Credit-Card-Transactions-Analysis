# Credit-Card-Transactions-Analysis
This project involves cleaning and analyzing a credit card transaction dataset using SQL and Python (pandas). It includes data preprocessing, such as handling missing values and duplicates, followed by SQL queries to uncover insights on spending patterns, card types, and expense categories across different cities.

## Project Overview
The project aims to analyze credit card transactions data to derive insights regarding spending patterns, card usage trends, and more. The analysis is done by performing several SQL queries to explore relationships in the data, such as:

- City-wise spending and their percentage contributions.
- Highest spent months for each card type.
- Cumulative spending across transactions.
- Expenditure breakdown by gender and expense type.
- This project uses SQL to query the data and Python (Pandas) to preprocess and clean the data.

## Dataset
The dataset used for this project is the Credit Card Transactions - India dataset. It contains the following columns:

- transaction_id: Unique identifier for each transaction.
- card_type: Type of the card used (e.g., Gold, Silver, etc.).
- amount: Amount spent during the transaction.
- exp_type: Type of expense (e.g., bills, groceries, etc.).
- city: City where the transaction took place.
- gender: Gender of the cardholder (M/F).
- date: Date of the transaction.

## Data Cleaning and Preprocessing

The dataset was cleaned and preprocessed using Python (pandas) to ensure that the data is ready for analysis. The following steps were performed:

- Standardized column names: Converted column names to lowercase and replaced spaces with underscores.
- Data type conversion: Ensured that the 'amount' column is in float format, and 'date' is converted to datetime.
- City name cleaning: Removed the "India" suffix from the city names.
- Resetting index: Added a new column transaction_id for unique transaction identification.
- Duplicate removal: Dropped any duplicate rows from the dataset.
- Missing value checks: Identified and handled missing data where necessary.
- Exporting cleaned data: The cleaned dataset was saved into a new CSV file for further analysis.

## SQL Queries and Analysis

The following SQL queries were used to analyze the data and answer various business questions:

1. Top 5 Cities with Highest Spends and their Percentage Contribution
   - Identifies the cities with the highest spending and their percentage contribution to total spending.

2. Highest Spent Month and Amount for Each Card Type
  - Finds the month with the highest spending for each card type and the total amount spent.

3. Transaction Details for Cumulative Spend of 1 Million for Each Card Type

  - Retrieves transaction details for each card type when cumulative spending reaches 1 million.

4. City with Lowest Percentage Spend for Gold Card Type

  - Finds the city with the lowest percentage of spending for gold cardholders.

5. Highest and Lowest Expense Types in Each City

  - Analyzes the highest and lowest expense types in each city.

6. Percentage Contribution of Spends by Females for Each Expense Type

  - Calculates the percentage of total spending by females for each expense type.

7. Highest Month-over-Month Growth in Spending (Jan 2014 vs Dec 2013)

  - Identifies the card and expense type combination with the highest month-over-month growth in January 2014 compared to December 2013.

8. City with Highest Spend-to-Transaction Ratio During Weekends

  - Finds the city with the highest ratio of total spend to total transactions on weekends.

9. City with the Least Number of Days to Reach 500th Transaction

  - Identifies which city took the least number of days to reach its 500th transaction after the first transaction.

## Technologies Used

- **Python**: For data cleaning and preprocessing (pandas library).
- **MSSQL**: For querying the database and performing various analyses.
- **Jupyter Notebook** : For data exploration and running Python code interactively.









