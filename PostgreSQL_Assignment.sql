rangers, species, sightings



-- | Field Name  | Description               |
-- | ----------- | ------------------------- |
-- | `ranger_id` | Unique ID for each ranger |
-- | `name`      | Full name of the ranger   |
-- | `region`    | Area they patrol          |

CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL
);

INSERT INTO rangers (name, region) VALUES 
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

-- | Field Name            | Description                            |
-- | --------------------- | -------------------------------------- |
-- | `species_id`          | Unique ID for each species             |
-- | `common_name`         | Common name (e.g., "Shadow Leopard")   |
-- | `scientific_name`     | Scientific name                        |
-- | `discovery_date`      | When the species was first recorded    |
-- | `conservation_status` | Status like "Endangered", "Vulnerable" |

CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100),
    discovery_date DATE,
    conservation_status VARCHAR(25)
);

INSERT INTO species(common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

-- | Field Name      | Description                                |
-- | --------------- | ------------------------------------------ |
-- | `sighting_id`   | Unique ID for each sighting                |
-- | `ranger_id`     | Who made the sighting (links to `rangers`) |
-- | `species_id`    | Which animal was seen (links to `species`) |
-- | `sighting_time` | Date and time of the sighting              |
-- | `location`      | Where it was seen                          |
-- | `notes`         | Additional observations (optional)         |

CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT ,
    species_id INT, 
    sighting_time TIMESTAMP ,
    location VARCHAR(100),
    notes VARCHAR(100),
    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id),
    FOREIGN KEY (species_id) REFERENCES species(species_id)
);

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);



-- 1️⃣ Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO rangers(name,region) VALUES
('Derek Fox', 'Coastal Plains');
-- 2️⃣ Count unique species ever sighted.
SELECT COUNT(*) AS unique_species_count 
FROM
(
SELECT species_id FROM sightings GROUP BY species_id
);

-- 3️⃣ Find all sightings where the location includes "Pass".
SELECT * FROM sightings
     WHERE location LIKE '%Pass';



SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;

-- 4️⃣ List each ranger's name and their total number of sightings.
SELECT r.name,COUNT(s.sighting_id) 
FROM sightings s
JOIN rangers r ON r.ranger_id = s.ranger_id 
GROUP BY r.ranger_id ;

-- 5️⃣ List species that have never been sighted.
SELECT s.common_name
FROM species s
LEFT JOIN sightings si ON s.species_id = si.species_id
WHERE si.sighting_id IS NULL;

-- 6️⃣ Show the most recent 2 sightings.
SELECT  s.common_name, sighting_time, r.name  FROM sightings si
JOIN rangers r ON r.ranger_id = si.ranger_id
JOIN species s ON s.species_id = si.species_id
 ORDER BY sighting_time DESC LIMIT 2;

--  7️⃣ Update all species discovered before year 1800 to have status 'Historic'
-- SELECT * FROM species WHERE discovery_date < '1800-01-01';
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

-- 8️⃣ Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT sighting_id, sighting_time as  time_of_day FROM sightings;






-- 9️⃣ Delete rangers who have never sighted any species
SELECT * FROM rangers r
LEFT JOIN sightings s ON r.ranger_id = s.ranger_id;

