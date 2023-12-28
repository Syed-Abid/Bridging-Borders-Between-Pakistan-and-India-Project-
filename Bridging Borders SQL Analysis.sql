-- Table to store countries
CREATE TABLE Country (
    CountryID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

-- Table to store cultural exchange events
CREATE TABLE CulturalExchangeEvent (
    EventID INT PRIMARY KEY,
    EventName VARCHAR(255) NOT NULL,
    EventDate DATE,
    Description TEXT,
    Country1ID INT,
    Country2ID INT,
    FOREIGN KEY (Country1ID) REFERENCES Country(CountryID),
    FOREIGN KEY (Country2ID) REFERENCES Country(CountryID)
);

-- Table to store cultural aspects
CREATE TABLE CulturalAspect (
    AspectID INT PRIMARY KEY,
    AspectName VARCHAR(255) NOT NULL
);

-- Table to store similarities and differences between cultures
CREATE TABLE CulturalComparison (
    ComparisonID INT PRIMARY KEY,
    AspectID INT,
    CountryID INT,
    Similarity TEXT,
    FOREIGN KEY (AspectID) REFERENCES CulturalAspect(AspectID),
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

-- Inserting values into the Country table
INSERT INTO Country (CountryID, Name) VALUES
    (1, 'India'),
    (2, 'Pakistan');

-- Inserting values into the CulturalAspect table
INSERT INTO CulturalAspect (AspectID, AspectName) VALUES
    (1, 'Language'),
    (2, 'Cuisine'),
    (3, 'Traditional Clothing');

-- Inserting values into the CulturalExchangeEvent table
INSERT INTO CulturalExchangeEvent (EventID, EventName, EventDate, Description, Country1ID, Country2ID) VALUES
    (1, 'Unity Day Celebration', '2023-02-15', 'An event to promote unity and cultural diversity', 1, 2),
    (2, 'Heritage Expo 2023', '2023-04-20', 'Showcasing the rich heritage of both nations', 2, 1),
    (3, 'Bollywood-Pakistan Fusion Night', '2023-06-10', 'A cultural extravaganza featuring music and dance', 1, 2),
    (4, 'Traditional Food Festival', '2023-08-05', 'Exploring the culinary delights of India and Pakistan', 2, 1),
    (5, 'Sufi Music Concert', '2023-09-25', 'A mesmerizing evening of Sufi music from both countries', 1, 2),
    (6, 'Art and Craft Fair', '2023-11-12', 'Celebrating traditional art and crafts', 2, 1),
    (7, 'Literary Symposium', '2024-01-30', 'Exploring the shared literary heritage of India and Pakistan', 1, 2),
    (8, 'Fashion Fusion Show', '2024-03-18', 'A showcase of fashion trends blending Indian and Pakistani styles', 2, 1),
    (9, 'Cultural Exchange Youth Camp', '2024-05-22', 'Fostering cultural understanding among the youth', 1, 2),
    (10, 'Folk Dance Festival', '2024-07-15', 'Dazzling performances of traditional folk dances', 2, 1);

-- Inserting values into the CulturalComparison table
INSERT INTO CulturalComparison (ComparisonID, AspectID, CountryID, Similarity) VALUES
    (1, 1, 1, 'Hindi and Urdu are widely spoken in both India and Pakistan'),
    (2, 2, 1, 'Both countries have rich and diverse cuisines'),
    (3, 3, 2, 'Similar traditional clothing styles like salwar kameez and kurta'),
    (4, 1, 2, 'Urdu is spoken in Pakistan, and Hindi is spoken in India'),
    (5, 2, 2, 'Both countries share a love for spicy food'),
    (6, 3, 1, 'Distinct traditional clothing styles: saree in India, shalwar kameez in Pakistan'),
    (7, 1, 1, 'India and Pakistan have a shared history of classical music'),
    (8, 2, 2, 'Tea is a popular beverage in both countries'),
    (9, 3, 1, 'Similarities in architectural styles in historical monuments'),
    (10, 1, 2, 'Both countries have a strong emphasis on family values');


SELECT * FROM dbo.Country
SELECT * FROM dbo.CulturalAspect
SELECT * FROM dbo.CulturalComparison
SELECT * FROM dbo.CulturalExchangeEvent

--1. Retrieve all countries in the database ?
   
   SELECT * FROM Country

--2. Find all cultural exchange events with their descriptions?
   
   SELECT EventName,Description
   FROM CulturalExchangeEvent

--3. List cultural aspects and their names?
   
   SELECT AspectName
   FROM CulturalAspect

--4. Get similarities between cultures for a specific aspect (e.g., Language)?
   
   SELECT CulturalComparison.Similarity
   FROM CulturalComparison
   INNER JOIN CulturalAspect ON CulturalComparison.AspectID = CulturalAspect.AspectID
   Where CulturalAspect.AspectName = 'Language';

--5. Retrieve events with their participating countries and dates?
   
   SELECT
    CE.EventName,
    CE.EventDate,
    C1.Name AS Country1,
    C2.Name AS Country2
   FROM
    CulturalExchangeEvent CE
    INNER JOIN Country C1 ON CE.Country1ID = C1.CountryID
    INNER JOIN Country C2 ON CE.Country2ID = C2.CountryID;


--6. Find events happening after a specific date:'2023-06-01'?
   
   SELECT EventName
   FROM CulturalExchangeEvent
   WHERE EventDate > '2023-06-01';

--7. List cultural aspects and their comparisons for a specific country (e.g., India)?
   
   SELECT CulturalAspect.AspectName, Country.Name, CulturalComparison.Similarity
   FROM CulturalComparison
   INNER JOIN CulturalAspect ON CulturalComparison.AspectID = CulturalAspect.AspectID
   INNER JOIN Country ON Country.CountryID = CulturalComparison.CountryID
   WHERE Country.Name = 'Pakistan';

--8. Count the number of cultural aspects compared for each country?
   
   SELECT COUNT(AspectID) AS AspectsCompared
   FROM CulturalComparison
   GROUP BY AspectID

--9. Find events that involve a specific country (e.g., Pakistan)?
   
  SELECT
    CE.EventName,
    CE.EventDate,
    C1.Name AS Country1,
    C2.Name AS Country2
FROM
    CulturalExchangeEvent CE
    INNER JOIN Country C1 ON CE.Country1ID = C1.CountryID
    INNER JOIN Country C2 ON CE.Country2ID = C2.CountryID
WHERE
    C1.Name = 'India' OR C2.Name = 'India';


--10. Retrieve events and their descriptions for a given date range '2023-05-01' AND '2023-08-31'?
  
  SELECT EventName, Description
  FROM CulturalExchangeEvent
  WHERE EventDate BETWEEN '2023-05-01' AND '2023-08-31'; 
