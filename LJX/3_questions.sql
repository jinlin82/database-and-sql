-- The Warehouse
-- lINK: The_warehouse
--3.1 Select all warehouses.
select * from warehouses;
--3.2 Select all boxes with a value larger than $150.
SELECT * from boxes WHERE value > 150;
--3.3 Select all distinct contents in all the boxes.
SELECT DISTINCT contents from boxes;
--3.4 Select the average value of all the boxes.
SELECT avg(value) FROM boxes;
--3.5 Select the warehouse code and the average value of the boxes in each warehouse.
SELECT b.warehouse,avg(b.value) FROM warehouses a LEFT JOIN boxes b on a.code=b.warehouse GROUP BY b.warehouse;

--3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
SELECT b.warehouse,avg(b.value) FROM warehouses a LEFT JOIN boxes b on a.code=b.warehouse GROUP BY b.warehouse HAVING avg(b.value)>150;
--3.7 Select the code of each box, along with the name of the city the box is
--located in.
SELECT b.warehouse,avg(b.value) FROM warehouses a LEFT JOIN boxes b on a.code=b.warehouse GROUP BY b.warehouse HAVING avg(b.value)>150;
--3.8 Select the warehouse codes, along with the number of boxes in each warehouse.
--     Optionally, take into account that some warehouses are empty (i.e., the
--     box count should show up as zero, instead of omitting the warehouse from
--     the result).
SELECT DISTINCT
        MainTable.warehouse ,
        COALESCE(SubTable.SubNum,0) AS TotalNum
FROM    boxes AS MainTable
LEFT JOIN (
           SELECT   warehouse ,
                    COUNT(1) AS SubNum
           FROM     boxes
           GROUP BY warehouse
          ) AS SubTable ON MainTable.warehouse = SubTable.warehouse;
--3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).SELECT * FROM warehouses;
SELECT c.code FROM warehouses AS c
LEFT JOIN (
SELECT DISTINCT
        MainTable.warehouse ,
        COALESCE(SubTable.SubNum,0) AS TotalNum
FROM    boxes AS MainTable
LEFT JOIN (
           SELECT   warehouse ,
                    COUNT(1) AS SubNum
           FROM     boxes
           GROUP BY warehouse
          ) AS SubTable ON MainTable.warehouse = SubTable.warehouse) AS d ON c.code=d.warehouse WHERE c.capacity<d.totalnum;

--3.10 Select the codes of all the boxes located in Chicago.
SELECT a.code FROM boxes a LEFT JOIN warehouses b ON a.warehouse=b.code WHERE b.location='Chicago';
SELECT * FROM warehouses;
--3.11 Create a new warehouse in New York with a capacity for 3 boxes.
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(6,'New York',3);
--3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('H5RT','Papers',200,2);
--3.13 Reduce the value of all boxes by 15%.
UPDATE boxes SET value=value*0.85;
--3.14 Remove all boxes with a value lower than $100.
DELETE FROM boxes WHERE value<100;
-- 3.15 Remove all boxes from saturated warehouses.
DELETE FROM boxes WHERE warehouse=1;

DELETE FROM boxes WHERE warehouse in (
    SELECT c.code FROM warehouses AS c
LEFT JOIN (
SELECT DISTINCT
        MainTable.warehouse ,
        COALESCE(SubTable.SubNum,0) AS TotalNum
FROM    boxes AS MainTable
LEFT JOIN (
           SELECT   warehouse ,
                    COUNT(1) AS SubNum
           FROM     boxes
           GROUP BY warehouse
          ) AS SubTable ON MainTable.warehouse = SubTable.warehouse) AS d ON c.code=d.warehouse WHERE c.capacity<d.totalnum);
-- 3.16 Add Index for column "Warehouse" in table "boxes"
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
-- 3.17 Print all the existing indexes
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
-- 3.18 Remove (drop) the index you added just
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
