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

```sql
-- Retrieve GameName and Price of all games published by 'Electronic Arts'
SELECT GameName, Price
FROM Games
WHERE PublisherID = 'P01';

-- Retrieve GameName, Price, and Rating of games with a rating greater than or equal to 90, sorted by descending rating
SELECT GameName, Price, Rating
FROM Games
WHERE Rating >= 90
ORDER BY Rating DESC;

-- Calculate the average price of all games
SELECT AVG(Price) AS AveragePrice
FROM Games;

-- Retrieve GameName, Price, and PublisherName of all games published by 'Ubisoft' with a price greater than the average price of all games
SELECT GameName, Price, PublisherName
FROM Games
WHERE PublisherID = 'P02'
  AND Price > (SELECT AVG(Price) FROM Games);

-- Retrieve GameName, Price, PublisherName, and Customer information for all games purchased by customers who bought the PS5 platform
SELECT g.GameName, g.Price, p.PublisherName, c.CustomerName, c.EmailAddress
FROM Games g
JOIN GameSales gs ON g.GameID = gs.GameID
JOIN Publishers p ON g.PublisherID = p.PublisherID
JOIN Customers c ON gs.CustomerID = c.CustomerID
WHERE gs.PlatformID = 'PL03';

-- User-defined function to calculate total revenue generated for a specific region during the current quarter
CREATE FUNCTION CalculateRegionRevenue (@RegionSalesID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    -- Function logic to calculate total revenue for the specified region during the current quarter
    DECLARE @Revenue DECIMAL(10,2)
    -- Your calculation logic here
    RETURN @Revenue
END;

-- Trigger to automatically insert a default sale record when a new game is added to the Games table
CREATE TRIGGER AddDefaultSaleRecord
ON Games
AFTER INSERT
AS
BEGIN
    INSERT INTO GameSales (SaleID, GameID, PlatformID, Price, DateSold, RegionSalesID, Discounts, Rating)
    SELECT NEWID(), inserted.GameID, 'DefaultPlatform', 59.99, GETDATE(), 'DefaultRegion', 0, 0
    FROM inserted;
END;

-- Stored procedure to retrieve detailed sales data for a specific game title within a specified date range
CREATE PROCEDURE GetGameSalesData
    @GameName NVARCHAR(100),
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    -- Procedure logic to retrieve sales data for the specified game title within the specified date range
    SELECT gs.SaleID, gs.DateSold, gs.Price, c.CustomerName, c.EmailAddress
    FROM GameSales gs
    JOIN Games g ON gs.GameID = g.GameID
    JOIN Customers c ON gs.CustomerID = c.CustomerID
    WHERE g.GameName = @GameName
      AND gs.DateSold BETWEEN @StartDate AND @EndDate;
END;

