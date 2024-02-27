-- Create the database
CREATE DATABASE GameDatabaseKOM;
GO

-- Use the GameDatabase
USE GameDatabaseKOM;
GO

-- Create the Publishers table
CREATE TABLE Publishers (
    PublisherID VARCHAR(3) PRIMARY KEY,
    PublisherName VARCHAR(100)
);

-- Insert data into the Publishers table
INSERT INTO Publishers (PublisherID, PublisherName)
VALUES 
    ('P01', 'Electronic Arts'),
    ('P02', 'Ubisoft'),
    ('P03', 'Activision'),
    ('P04', 'Blizzard Entertainment'),
    ('P05', 'Rockstar Games');

-- Create the Games table
CREATE TABLE Games (
    GameID VARCHAR(3) PRIMARY KEY,
    PublisherID VARCHAR(3),
    GameName VARCHAR(100),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

-- Insert data into the Games table
INSERT INTO Games (GameID, PublisherID, GameName)
VALUES 
    ('G01', 'P01', 'FIFA 22'),
    ('G02', 'P01', 'Battlefield V'),
    ('G03', 'P01', 'Apex Legends'),
    ('G04', 'P01', 'The Sims 4'),
    ('G05', 'P01', 'Need for Speed Heat'),
    ('G06', 'P01', 'Star Wars Jedi: Fallen Order'),
    ('G07', 'P01', 'Anthem'),
    ('G08', 'P01', 'Battlefield 1'),
    ('G09', 'P01', 'Plants vs. Zombies: Battle for Neighborville'),
    ('G10', 'P01', 'Unravel Two'),
    ('G11', 'P02', 'Assassin''s Creed Valhalla'),
    ('G12', 'P02', 'Watch Dogs: Legion'),
    ('G13', 'P02', 'Far Cry 5'),
    ('G14', 'P02', 'Tom Clancy''s Rainbow Six Siege'),
    ('G15', 'P02', 'Tom Clancy''s Ghost Recon Breakpoint'),
    ('G16', 'P02', 'Just Dance 2021'),
    ('G17', 'P02', 'For Honor'),
    ('G18', 'P02', 'The Crew 2'),
    ('G19', 'P02', 'Assassin''s Creed Odyssey'),
    ('G20', 'P02', 'Watch Dogs 2'),
    ('G21', 'P03', 'Call of Duty: Modern Warfare'),
    ('G22', 'P03', 'Call of Duty: Warzone'),
    ('G23', 'P03', 'Call of Duty: Black Ops Cold War'),
    ('G24', 'P03', 'World of Warcraft: Shadowlands'),
    ('G25', 'P03', 'Overwatch'),
    ('G26', 'P03', 'Diablo III'),
    ('G27', 'P03', 'Hearthstone'),
    ('G28', 'P03', 'Call of Duty: Mobile'),
    ('G29', 'P03', 'Crash Bandicoot 4: It''s About Time'),
    ('G30', 'P03', 'Spyro Reignited Trilogy'),
    ('G31', 'P05', 'Grand Theft Auto V'),
    ('G32', 'P05', 'Red Dead Redemption 2'),
    ('G33', 'P05', 'NBA 2K21'),
    ('G34', 'P05', 'Borderlands 3'),
    ('G35', 'P05', 'WWE 2K Battlegrounds'),
    ('G36', 'P05', 'Mafia: Definitive Edition'),
    ('G37', 'P05', 'Kerbal Space Program'),
    ('G38', 'P05', 'Carnival Games'),
    ('G39', 'P05', 'Sid Meier''s Civilization VI'),
    ('G40', 'P05', 'NBA 2K20'),
    ('G41', 'P05', 'The Legend of Zelda: Breath of the Wild'),
    ('G42', 'P05', 'Animal Crossing: New Horizons'),
    ('G43', 'P05', 'Super Mario Odyssey'),
    ('G44', 'P05', 'Splatoon 2'),
    ('G45', 'P05', 'Mario Kart 8 Deluxe'),
    ('G46', 'P05', 'Super Smash Bros. Ultimate'),
    ('G47', 'P05', 'Pokémon Sword and Shield'),
    ('G48', 'P05', 'Luigi''s Mansion 3'),
    ('G49', 'P05', 'Fire Emblem: Three Houses'),
    ('G50', 'P05', 'Xenoblade Chronicles 2');

-- Create the Platform table
CREATE TABLE Platform (
    PlatformID VARCHAR(4) PRIMARY KEY,
    PlatformName VARCHAR(20)
);

-- Insert data into the Platform table
INSERT INTO Platform (PlatformID, PlatformName)
VALUES 
    ('PL01', 'XBOX'),
    ('PL02', 'PS4'),
    ('PL03', 'PS5'),
    ('PL04', 'PC');

-- Create the RegionSales table
CREATE TABLE RegionSales (
    RegionSalesID INT PRIMARY KEY,
    RegionName VARCHAR(20)
);

-- Insert data into the RegionSales table
INSERT INTO RegionSales (RegionSalesID, RegionName)
VALUES 
    (1, 'Asia'),
    (2, 'Europe'),
    (3, 'America');

-- Create the GameSales table
CREATE TABLE GameSales (
    SaleID VARCHAR(6) PRIMARY KEY,
    GameID VARCHAR(3),
    PlatformID VARCHAR(4),
    Price DECIMAL,
    DateSold DATE,
    RegionSalesID INT,
    Discounts DECIMAL,
    Rating INT,
    FOREIGN KEY (GameID) REFERENCES Games(GameID),
    FOREIGN KEY (PlatformID) REFERENCES Platform(PlatformID),
    FOREIGN KEY (RegionSalesID) REFERENCES RegionSales(RegionSalesID)
);

CREATE TABLE TempGameSales (
    SaleID VARCHAR(6),
    GameID VARCHAR(3),
    PlatformID VARCHAR(4),
    Price DECIMAL,
    DateSold DATE,
    RegionSalesID INT,
    Discounts DECIMAL,
    Rating INT
);

BULK INSERT TempGameSales
FROM '<changes this path>\GameDataset.csv'
WITH (
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',    
    FIRSTROW = 2             
);

INSERT INTO GameSales (SaleID, GameID, PlatformID, Price, DateSold, RegionSalesID, Discounts, Rating)
SELECT SaleID, GameID, PlatformID, Price, DateSold, RegionSalesID, Discounts, Rating
FROM TempGameSales;

DROP TABLE TempGameSales;
