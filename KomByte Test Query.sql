select distinct g.GameName, gs.Price, p.PlatformName
from Games g, GameSales gs, Platform p
where g.GameID = gs.GameID
AND gs.PlatformID = p.PlatformID
AND g.PublisherID = (select PublisherID from Publishers where PublisherName = 'Electronic Arts');

select distinct g.GameName, gs.Price, gs.Rating, p.PlatformName
from Games g, GameSales gs, Platform p
where g.GameID = gs.GameID
AND gs.PlatformID = p.PlatformID
AND gs.Rating >= 90
ORDER BY gs.Rating DESC;

select avg(gs.Price) as AveragePrice
FROM GameSales gs, Games g
where gs.GameID = g.GameID
AND g.PublisherID NOT IN (select PublisherID from Publishers where PublisherName IN ('Electronic Arts', 'Ubisoft'))
AND gs.Rating >= 80;

select g.GameName, gs.Price, p.PublisherName
from Games g, GameSales gs, Publishers p
where g.GameID = gs.GameID
AND g.PublisherID = p.PublisherID
AND p.PublisherName = 'Ubisoft'
AND gs.Price > (select AVG(Price) from GameSales);

select
	g.GameName,
	gs.Price,
	p.PublisherName,
	COUNT(gs.SaleID) AS TotalSales
from
	GameSales gs
JOIN Games g ON gs.GameID = g.GameID
JOIN Publishers p ON g.PublisherID = p.PublisherID
JOIN Platform pl ON gs.PlatformID = pl.PlatformID
where pl.PlatformName = 'PS5'
group by g.GameID, g.GameName, gs.Price, p.PublisherName
order by TotalSales desc;

CREATE FUNCTION CalculateRegionRevenue 
(
    @RegionName NVARCHAR(100),
    @StartDate DATE,
    @EndDate DATE
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(10, 2)

    -- Calculate total revenue for the specified region during the specific range of date
    SELECT @TotalRevenue = SUM(Price)
    FROM GameSales gs
    INNER JOIN RegionSales rs ON gs.RegionSalesID = rs.RegionSalesID
    WHERE rs.RegionName = @RegionName
    AND gs.DateSold BETWEEN @StartDate AND @EndDate

    RETURN ISNULL(@TotalRevenue, 0)
END;

DECLARE @Revenue1 DECIMAL(10, 2)
SET @Revenue1 = dbo.CalculateRegionRevenue('Asia', '2020-01-01', '2022-03-31')
SELECT @Revenue1 AS TotalRevenue1;


CREATE TRIGGER AddDefaultSaleRecord
ON Games
AFTER INSERT
AS
BEGIN
    DECLARE @LastSaleID VARCHAR(6)

    -- Get the last SaleID from GameSales
    SELECT TOP 1 @LastSaleID = SaleID
    FROM GameSales
    ORDER BY SaleID DESC;

    -- If there are existing SaleIDs, extract the numeric part and increment
    DECLARE @NumericPart INT;
    IF @LastSaleID IS NOT NULL
        SET @NumericPart = CAST(RIGHT(@LastSaleID, 5) AS INT) + 1;
    ELSE
        SET @NumericPart = 1;

    -- Generate the new SaleID with the desired format
    DECLARE @NewSaleID VARCHAR(6) = 'S' + RIGHT('00000' + CAST(@NumericPart AS VARCHAR(5)), 5);

    -- Your existing logic for other fields
    DECLARE @PlatformID VARCHAR(5)
    DECLARE @RegionSalesID INT

    SELECT TOP 1 @PlatformID = PlatformID
    FROM Platform
    ORDER BY NEWID();

    SELECT TOP 1 @RegionSalesID = RegionSalesID
    FROM RegionSales
    ORDER BY NEWID();

    INSERT INTO GameSales (SaleID, GameID, PlatformID, Price, DateSold, RegionSalesID, Discounts, Rating)
    SELECT 
        @NewSaleID,
        i.GameID,
        @PlatformID,
        59.99,
        GETDATE(),
        @RegionSalesID,
        0,
        0
    FROM 
        inserted i;
END;

INSERT INTO Games(GameID, PublisherID, GameName)
VALUES ('G51', 'P04', 'TestGame');

SELECT * FROM GameSales;

CREATE PROCEDURE GetGameSalesData
    @GameName NVARCHAR(100),
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        gs.SaleID,
        gs.DateSold,
        gs.Price
    FROM 
        GameSales gs
    JOIN 
        Games g ON gs.GameID = g.GameID
    WHERE 
        g.GameName = @GameName
        AND gs.DateSold BETWEEN @StartDate AND @EndDate;
END;

EXEC GetGameSalesData 'FIFA 22', '2019-01-01', '2021-12-31';