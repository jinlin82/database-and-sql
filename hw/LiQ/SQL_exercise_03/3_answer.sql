--3.1 Select all warehouses.
SELECT *
FROM warehouses;

--3.2 Select all boxes with a value larger than $150.
SELECT *
FROM boxes
WHERE value > 150;

--3.3 Select all distinct contents in all the boxes.
SELECT DISTINCT contents
FROM boxes;

--3.4 Select the average value of all the boxes.
SELECT avg(value)
FROM boxes;

--3.5 Select the warehouse code and the average value of the boxes in each warehouse.
SELECT warehouse,avg(value)
FROM boxes
GROUP BY warehouse;

--3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
SELECT warehouse,avg(value)
FROM boxes
GROUP BY warehouse
HAVING avg(value)>150;

--3.7 Select the code of each box, along with the name of the city the box is located in.
SELECT b.code,w.location
FROM boxes b
JOIN warehouses w ON b.warehouse = w.code;

--3.8 SELECT the warehouse codes, along WITH the number of boxes IN each warehouse.
    -- Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
SELECT warehouse,count(*)
FROM boxes
GROUP BY warehouse;

--3.9 SELECT the codes of ALL warehouses that are saturated (a warehouse IS saturated if the number of boxes IN it IS larger than the warehouse's capacity).
SELECT code
FROM warehouses
WHERE capacity <(SELECT COUNT(*)
                FROM boxes
                WHERE warehouse = warehouses.code);

--3.10 Select the codes of all the boxes located in Chicago.
SELECT b.code
FROM boxes b
JOIN warehouses w ON b.warehouse = w.code
WHERE w.location = 'Chicago';

--3.11 Create a new warehouse in New York with a capacity for 3 boxes.
INSERT INTO warehouses
VALUES (6,'New York',3);

--3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
INSERT INTO boxes
VALUES ('H5RT','Papers',200,2);

--3.13 Reduce the value of all boxes by 15%.
UPDATE boxes
SET value = value*0.85;

--3.14 Remove all boxes with a value lower than $100.
DELETE FROM boxes
WHERE value < 100;

-- 3.15 Remove all boxes from saturated warehouses.
DELETE FROM boxes
WHERE warehouse IN (SELECT code
                    FROM warehouses
                    WHERE capacity <(SELECT COUNT(*)
                                     FROM boxes
                                    WHERE warehouse = warehouses.code));

-- 3.16 Add Index for column "Warehouse" in table "boxes"
    -- !!!NOTE!!!: index should NOT be used on small tables in practice

CREATE INDEX INDEX_WAREHOUSE 
ON Boxes(warehouse);

-- 3.17 Print all the existing indexes
    -- !!!NOTE!!!: index should NOT be used on small tables in practice

SHOW INDEX FROM Boxes FROM db1;

-- 3.18 Remove (drop) the index you added just
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
DROP INDEX INDEX_WAREHOUSE;