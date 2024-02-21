# KombyteCompetition
Welcome to the Game Sales Database Competition! This README provides syntax documentation to assist participants in completing the competition questions.

## SQL Syntax Documentation

### Basic SQL Query

Participants in this qualification level would be tasked with executing fundamental SQL queries on the dataset. This could include:

1. **Data Retrieval Tasks**: SELECT statement
2. **Data Filtering and Sorting**: WHERE clause, ORDER BY clause
3. **Aggregate Functions**: SUM(), AVG(), COUNT(), etc.
4. **Subqueries and Derived Tables**: Subqueries, Common Table Expressions (CTEs)

### Advanced SQL Query

Participants in this qualification level would be required to execute more complex SQL queries involving joins, advanced functions, triggers, and stored procedures. Tasks could include:

1. **Data Manipulation and Join Operations**: JOIN operations (INNER JOIN, LEFT JOIN, etc.)
2. **User Defined Functions**: CREATE FUNCTION statement
3. **Trigger**: CREATE TRIGGER statement
4. **Stored Procedure**: CREATE PROCEDURE statement

## Example Queries

### Basic SQL Query Examples

#### Data Retrieval Task

```sql
-- Retrieve GameName and Price of all games published by 'Electronic Arts'
SELECT GameName, Price
FROM Games
WHERE PublisherID = 'P01';
