-- The Warehouse
-- lINK: The_warehouse
--3.1 Select all warehouses.
SELECT code from warehouses;
--3.2 Select all boxes with a value larger than $150.
SELECT *
from boxes
WHERE value>=150;
--3.3 Select all distinct contents in all the boxes.
SELECT DISTINCT contents from boxes;
--3.4 Select the average value of all the boxes.
SELECT avg(value) from boxes;
--3.5 Select the warehouse code and the average value of the boxes in each
--warehouse.
SELECT code,avg(value)
from boxes
GROUP by code;
--3.6 Same as previous exercise, but select only those warehouses where the
--average value of the boxes is greater than 150.
SELECT code,avg(value)
from boxes
GROUP by code
HAVING avg(value)>=150;
--3.7 Select the code of each box, along with the name of the city the box is
--located in.
SELECT boxes.code,warehouses.location
from boxes,warehouses
WHERE boxes.warehouse=warehouses.code;
--3.8 Select the warehouse codes, along with the number of boxes in each
--warehouse. 

--     Optionally, take into account that some warehouses are empty (i.e., the
SELECT * from boxes;
SELECT * from warehouses;
--     box count should show up as zero, instead of omitting the warehouse from
--     the result).
SELECT warehouses.code,boxes.value
from boxes,warehouses
WHERE boxes.warehouse=warehouses.code;
--3.9 Select the codes of all warehouses that are saturated (a warehouse is
--saturated if the number of boxes in it is larger than the warehouse's
--capacity).
SELECT code
from(
SELECT code,capacity
FROM warehouses) as new1,
(SELECT warehouse,count(warehouse)
from boxes
group by warehouse)as new2
WHERE code=warehouse
AND count>capacity;

--3.10 Select the codes of all the boxes located in Chicago.
SELECT boxes.code
from boxes,warehouses
WHERE boxes.warehouse=warehouses.code
and warehouses.location='Chicago';
--3.11 Create a new warehouse in New York with a capacity for 3 boxes.
INSERT INTO warehouses(code,location,capacity)
VALUES(999,'New York',1);


--3.12 Create a new box, with code "H5RT", containing "Papers" with a value of
--$200, and located in warehouse 2.
INSERT INTO boxes(code,contents,value,warehouse)
VALUES('H5RT','Papers',200,2);
--3.13 Reduce the value of all boxes by 15%.
UPDATE boxes
set value=.85*value;
--3.14 Remove all boxes with a value lower than $100.
DELETE from boxes
WHERE value<=100;
-- 3.15 Remove all boxes from saturated warehouses.

DELETE from boxes
WHERE boxes.warehouse in(
SELECT code
from(
SELECT code,capacity
FROM warehouses) as new1,
(SELECT warehouse,count(warehouse)
from boxes
group by warehouse)as new2
WHERE code=warehouse
AND count>capacity);
-- 3.16 Add Index for column "Warehouse" in table "boxes"
    -- !!!NOTE!!!: index should NOT be used on small tables in practice

CREATE index perindex on boxes(warehouse);
-- 3.17 Print all the existing indexes
    -- !!!NOTE!!!: index should NOT be used on small tables in practice

SHOW index from boxes;
-- 3.18 Remove (drop) the index you added just
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
DROP index perindex on boxes(warehouse);