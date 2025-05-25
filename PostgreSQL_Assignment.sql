CREATE DATABASE  conversation_db

-- Create the table
CREATE TABLE rangers (
    ranger_id INT PRIMARY KEY,
    name VARCHAR(100),
    region VARCHAR(100)
);

INSERT INTO rangers (ranger_id, name, region) VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range');
SELECT * FROM rangers;

-- Create the table
CREATE TABLE species (
    species_id INT PRIMARY KEY,
    common_name VARCHAR(100),
    scientific_name VARCHAR(150),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

-- Insert the data
INSERT INTO species (species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

SELECT * FROM species;

-- Create the table
CREATE TABLE sightings (
    sighting_id INT PRIMARY KEY,
    species_id INT,
    ranger_id INT,
    location VARCHAR(100),
    sighting_time TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (species_id) REFERENCES species(species_id),
    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id)
);

-- Insert the data
INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);

SELECT * FROM sightings;

-- Problem 1
INSERT INTO rangers (ranger_id, name, region)
VALUES (4, 'Derek Fox', 'Coastal Plains');

-- Problem 2
SELECT COUNT(DISTINCT species_id) AS species_count FROM sightings;

-- Problem 3
SELECT * FROM sightings WHERE location LIKE '%Pass%';

-- Problem 4
SELECT r.name as name, COUNT(s.sighting_id) AS total_sightings FROM rangers r LEFT JOIN sightings s ON r.ranger_id = s.ranger_id 
GROUP BY r.ranger_id, r.name;

-- Problem 5
SELECT sp.common_name FROM species sp LEFT JOIN sightings s ON sp.species_id = s.species_id WHERE s.sighting_id IS NULL;

-- Problem 6
SELECT sp.common_name, s.sighting_time, r.name FROM sightings s 
JOIN species sp ON s.species_id = sp.species_id
JOIN rangers r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC
LIMIT 2;

-- Problem 7
UPDATE species SET  conservation_status = 'Historic' WHERE discovery_date < '1800-01-01';

-- Problem 8
SELECT  sighting_id, CASE 
 WHEN  EXTRACT( HOURS FROM sighting_time )  < 12 THEN 'Morning'
 WHEN EXTRACT( HOUR FROM sighting_time) BETWEEN  12 AND 17 THEN 'Afternoon'
 ELSE 'Evening' END as  time_of_day
 FROM sightings;

-- Problem 9
DELETE FROM rangers WHERE ranger_id NOT in (SELECT DISTINCT ranger_id FROM sightings );

