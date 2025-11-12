-- Rename columns
ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;
ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;

-- Add NOT NULL constraints
ALTER TABLE properties
ALTER COLUMN melting_point_celsius SET NOT NULL,
ALTER COLUMN boiling_point_celsius SET NOT NULL;

-- Add UNIQUE and NOT NULL constraints to elements
ALTER TABLE elements
ALTER COLUMN symbol SET NOT NULL,
ALTER COLUMN name SET NOT NULL;

ALTER TABLE elements
ADD CONSTRAINT elements_symbol_unique UNIQUE(symbol),
ADD CONSTRAINT elements_name_unique UNIQUE(name);

-- Remove trailing zeros and adjust atomic_mass to DECIMAL
ALTER TABLE properties
ALTER COLUMN atomic_mass TYPE DECIMAL;

-- Capitalize first letter of symbol values
UPDATE elements
SET symbol = initcap(symbol);

-- Add atomic_number as FK in properties
ALTER TABLE properties
ADD CONSTRAINT fk_atomic_number
FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number);

-- Create types table
CREATE TABLE types(
    type_id SERIAL PRIMARY KEY,
    type VARCHAR NOT NULL
);

-- Insert types
INSERT INTO types(type) VALUES
('metal'),
('nonmetal'),
('metalloid');

-- Add type_id column to properties
ALTER TABLE properties
ADD COLUMN type_id INT NOT NULL,
ADD CONSTRAINT fk_type
FOREIGN KEY(type_id) REFERENCES types(type_id);

-- Map existing elements to type_id (example mapping)
-- Assuming metals=1, nonmetals=2, metalloids=3
UPDATE properties SET type_id = 2 WHERE type = 'nonmetal';
UPDATE properties SET type_id = 1 WHERE type = 'metal';
UPDATE properties SET type_id = 3 WHERE type = 'metalloid';

-- Remove old type column
ALTER TABLE properties DROP COLUMN type;

-- Delete invalid element (atomic_number=1000)
DELETE FROM properties WHERE atomic_number=1000;
DELETE FROM elements WHERE atomic_number=1000;

-- Add Fluorine (9)
INSERT INTO elements(atomic_number, name, symbol) VALUES (9, 'Fluorine', 'F');
INSERT INTO properties(atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id)
VALUES (9, 18.998, -220, -188.1, 2);

-- Add Neon (10)
INSERT INTO elements(atomic_number, name, symbol) VALUES (10, 'Neon', 'Ne');
INSERT INTO properties(atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id)
VALUES (10, 20.18, -248.6, -246.1, 2);
