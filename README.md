## KombyteCompetition
Welcome to the Kombyte Competition! This README provides syntax documentation to assist participants in completing the competition questions.

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

### Overall Competition Structure

1. Participants would be given a fixed amount of time to complete each qualification level.
2. Each qualification level could consist of multiple tasks, and participants would earn points based on the correctness and efficiency of their queries.
3. The competition could be conducted online, with participants submitting their SQL queries through a platform that evaluates and scores their submissions automatically.
4. The participant with the highest total score across both qualification levels would be declared the winner of the competition

## SQL Syntax Documentation

### Data Retrieval Tasks

To retrieve data from a table, use the SELECT statement:

```sql
SELECT column1, column2, ...
FROM table_name;
```

### Data Filtering and Sorting

To filter and sort data, use the WHERE and ORDER BY clauses:

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition
ORDER BY column_name;
```

### Aggregate Functions

To perform aggregate functions such as SUM, AVG, COUNT, MAX, and MIN, use the respective functions:

```sql
SELECT SUM(column_name) AS sum_column
FROM table_name;
```

### Subqueries and Derived Tables

To use subqueries or derived tables, embed a SELECT statement within another SELECT statement:

```sql
SELECT column1, column2, ...
FROM (SELECT column1, column2 FROM table_name) AS derived_table;
```

### Data Manipulation and Join Operations

To manipulate data and perform join operations, use UPDATE, INSERT INTO, DELETE, and JOIN statements:

```sql
UPDATE table_name
SET column1 = value1
WHERE condition;

INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);

DELETE FROM table_name
WHERE condition;

SELECT t1.column1, t2.column2
FROM table1 t1
JOIN table2 t2 ON t1.common_column = t2.common_column;
```

### User Defined Functions

To create user-defined functions, use the CREATE FUNCTION statement:

```sql
CREATE FUNCTION function_name (parameters)
RETURNS return_datatype
AS
BEGIN
    -- Function logic here
END;
```

### Trigger

To create triggers, use the CREATE TRIGGER statement:

```sql
CREATE TRIGGER trigger_name
AFTER INSERT ON table_name
FOR EACH ROW
BEGIN
    -- Trigger logic here
END;
```

### Stored Procedure
To create stored procedures, use the CREATE PROCEDURE statement:

```sql
CREATE PROCEDURE procedure_name (parameters)
AS
BEGIN
    -- Procedure logic here
END;
```
