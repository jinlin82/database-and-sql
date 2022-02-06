-- Used SQLite3 for this example

-- table PEOPLE: containing unique ID and corresponding names.
CREATE TABLE PEOPLE (id INTEGER, name CHAR);

INSERT INTO PEOPLE (id,name)
VALUES(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D');

-- ADDRESS: containing the history of address information of each ID.
DROP TABLE IF EXISTS ADDRESS;
CREATE TABLE ADDRESS (id INTEGER, address CHAR(11) , updatedate date);

INSERT INTO ADDRESS (id,address,updatedate)
VALUES(1, 'address-1-1', '2016-01-01'),
(1, 'address-1-2', '2016-09-02'),
(2, 'address-2-1', '2015-11-01'),
(3, 'address-3-1', '2016-12-01'),
(3, 'address-3-2', '2014-09-11'),
(3, 'address-3-3', '2015-01-01'),
(4, 'address-4-1', '2010-05-21'),
(4, 'address-4-2', '2012-02-11'),
(4, 'address-4-3', '2015-04-27'),
(4, 'address-4-4', '2014-01-01');
