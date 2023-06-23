-- IS5102 Assignment 2

----------------------------------------
-- TASK 2
----------------------------------------
/*
I used D Beaver but also tested the code out in the terminal 

.mode column
.headers on
.width 18 18 18 18
*/ 
-- enforce foreign keys check
PRAGMA foreign_keys = TRUE;


/*
DROP TABLE supplies;
DROP TABLE supplier_phone;
DROP TABLE supplier;
DROP TABLE containsAn;
DROP TABLE edition;
DROP TABLE book_genre;
DROP TABLE reviews;
DROP TABLE book;
DROP TABLE customer_phone;
DROP TABLE Orderbook;
DROP TABLE customer;
*/
----------------------------------------
-- DECLARATIONS 
----------------------------------------
CREATE TABLE customer (
	customer_id	CHAR(5) NOT NULL,
	email		VARCHAR(50) NOT NULL UNIQUE,
	street		VARCHAR(20) NOT NULL,
	city		VARCHAR(20) NOT NULL,
	postcode	VARCHAR(15) NOT NULL,
	country		VARCHAR(20) NOT NULL,
	PRIMARY KEY (customer_id)
);

CREATE TABLE orderBook (
	order_id 	CHAR(6) NOT NULL,
	customer_id CHAR(5) NOT NULL,
	street		VARCHAR(20) NOT NULL,
	city 		VARCHAR(20) NOT NULL,
	postcode	VARCHAR(15) NOT NULL,
	country 	VARCHAR(20) NOT NULL,
	date_ordered 	DATE NOT NULL,
	date_delivered 	DATE,
	PRIMARY KEY (order_id),
	FOREIGN KEY (customer_id) REFERENCES customer);

CREATE TABLE customer_phone (
    customer_id  CHAR(5) NOT NULL,
	phone_type	 VARCHAR(5),
	phone_number VARCHAR(20) UNIQUE,
	PRIMARY KEY (customer_id, phone_type, phone_number),
	FOREIGN KEY (customer_id) REFERENCES customer);
	
CREATE TABLE book (
	book_id   CHAR(5) NOT NULL,
	title 	  VARCHAR(50) NOT NULL,
	author 	  VARCHAR(50),
	publisher VARCHAR (20),
	PRIMARY KEY (book_id)
);

CREATE TABLE reviews (
	customer_id	CHAR(5) NOT NULL,
	book_id 	CHAR(5) NOT NULL,
	rating 		INTEGER(5),
	PRIMARY KEY (customer_id, book_id),
	FOREIGN KEY (customer_id) REFERENCES customer,
	FOREIGN KEY (book_id) REFERENCES book);

CREATE TABLE book_genre (
	book_id CHAR(5) NOT NULL,
	genre 	VARCHAR(20) NOT NULL,
	PRIMARY KEY (book_id, genre),
	FOREIGN KEY (book_id) REFERENCES book);
   
   CREATE TABLE edition (
	book_id			CHAR(5) NOT NULL,
	book_edition 	INTEGER,
	book_type		VARCHAR(30),
	price 			NUMERIC(8,2) NOT NULL,
	quantity_in_stock	INTEGER DEFAULT 0,
	CONSTRAINT chk_book_type CHECK (book_type IN ('paperback', 'hardcover', 'audiobook')),
	CONSTRAINT PK_edBookType PRIMARY KEY (book_id, book_edition, book_type), 
	FOREIGN KEY (book_id) REFERENCES book(book_id)
   	ON DELETE CASCADE
    ON UPDATE CASCADE);
    
    --- CONSTRAINT PK_edBookType PRIMARY KEY (book_id, book_edition, book_type), REFERENCE: https://www.w3schools.com/sql/sql_primarykey.ASP
   
   CREATE TABLE containsAn (
	order_id 		CHAR(6) NOT NULL,
	book_id			CHAR(5) NOT NULL,
	book_edition 	INTEGER,
	book_type		VARCHAR(10) NOT NULL,
	amount 			INTEGER,
	CONSTRAINT chk_book_type CHECK (book_type IN ('paperback', 'hardcover', 'audiobook')),
	PRIMARY KEY (order_id, book_id, book_edition, book_type),
	FOREIGN KEY (order_id) REFERENCES orderBook,
	FOREIGN KEY (book_id, book_edition, book_type) REFERENCES edition(book_id, book_edition, book_type)); 

CREATE TABLE supplier (
	supplier_id CHAR(5) NOT NULL,
	name 		VARCHAR(20) NOT NULL,
	account_no	CHAR(10) NOT NULL UNIQUE,
	PRIMARY KEY (supplier_id)
	);

CREATE TABLE supplier_phone (
	supplier_id CHAR(5) NOT NULL,
	phone		VARCHAR(20),
	PRIMARY KEY (supplier_id, phone),
	FOREIGN KEY (supplier_id) REFERENCES supplier);


CREATE TABLE supplies (
	book_id 	 CHAR(5) NOT NULL,
	book_edition INTEGER,
	book_type 	 VARCHAR(30) NOT NULL,	
	supplier_id  CHAR(5),
	supply_price NUMERIC(8,2) NOT NULL,
	PRIMARY KEY (book_id, book_edition, book_type, supplier_id),
	FOREIGN KEY (book_id, book_edition, book_type) REFERENCES edition(book_id, book_edition, book_type),
	FOREIGN KEY (supplier_id) REFERENCES supplier);

----------------------------------------
-- TEST DATA 
----------------------------------------

INSERT INTO customer 
VALUES ('C1000', 'bongi@gmail.com', 'Daisy street', 'London', 'LO 3187', 'England'),
	   ('C2000', 'siya@gmail.com', 'Rose street', 'Durban', 'DU 3272', 'South Africa'),
	   ('C3000', 'eben@gmail.com', 'Pettal street', 'Edinburgh', 'ED 8631', 'Scotland'),
	   ('C4000', 'peiter@gmail.com', 'Sunflower street', 'Harare', 'HA 7776', 'Zimbabwe'),
	   ('C5000', 'jasper@gmail,com', 'Tulip street', 'Edinburgh', 'ED 4989', 'Scotland'),
	   ('C6000', 'hendrikse@gmail.com', 'Lavander street', 'Berlin', 'BE 8643', 'Germany'),
	   ('C7000', 'handre@gmail.com', 'Waterlilly street', 'Edinburgh', 'ED 1768', 'Scotland'),
	   ('C8000', 'lokhanyo@gmail.com', 'Tigerlilly street', 'Newcaslte', 'NE 2224', 'England'),
	   ('C9000', 'makazole@gmail.com', 'Daffodil street', 'Manchester', 'MA 3094', 'England'),
	   ('C1010', 'cheslin@gmail.com', 'Poppy street', 'Paris', 'PA 4323', 'France');

INSERT INTO orderBook 
VALUES ('OR1000', 'C1000', 'Daisy street', 'London', 'LO 3187', 'England', '2021-04-16', '2021-04-18'),
	   ('OR2000', 'C1000', 'Daisy street', 'London', 'LO 3187', 'England', '2022-03-12', '2022-03-14'),
	   ('OR3000', 'C2000', 'Rose street', 'Durban', 'DU 3272', 'South Africa', '2022-03-20', '2022-03-22'),
	   ('OR4000', 'C3000', 'Pettal street', 'Edinburgh', 'ED 8631', 'Scotland', '2021-06-13', '2021-06-15'),
	   ('OR5000', 'C4000', 'Sunflower street', 'Harare', 'HA 7776', 'Zimbabwe', '2021-05-26', '2021-05-28'),
	   ('OR6000', 'C5000', 'Tulip street', 'Edinburgh', 'ED 4989', 'Scotland', '2022-01-01', '2021-01-03'),
	   ('OR7000', 'C6000', 'Lavander street', 'Berlin', 'BE 8643', 'Germany', '2020-04-26', '2020-04-28'),
	   ('OR8000', 'C6000', 'Lavander street', 'Berlin', 'BE 8643', 'Germany', '2021-11-26', '2021-11-28'),
	   ('OR9000', 'C7000', 'Waterlilly street', 'Edinburgh', 'ED 1768', 'Scotland', '2019-11-02', '2019-11-08'),
	   ('OR1010', 'C8000', 'Tigerlilly street', 'Newcaslte', 'NE 2224', 'England', '2022-05-20', '2022-05-23'),
	   ('OR1011', 'C9000', 'Daffodil street', 'Manchester', 'MA 3094', 'England', '2018-12-03', '2018-12-11'),
	   ('OR1012', 'C1010', 'Poppy street', 'Paris', 'PA 4323', 'France', '2022-02-19', '2022-02-24'),
	   ('OR1013', 'C1010', 'Poppy street', 'Paris', 'PA 4323', 'France', '2022-02-25', '2022-02-29');

INSERT INTO customer_phone  
VALUES ('C1000', '+44', '714921236'),
	   ('C2000', '+27', '824676549'),
	   ('C3000', '+44', '634854758'),
	   ('C4000', '+263', '982365983'),
	   ('C5000', '+44', '937489723'),
	   ('C6000', '+49', '123539452'), 
	   ('C7000', '+44', '756723947'),
	   ('C8000', '+44', '234084724'),
	   ('C9000', '+44', '200457782'),
	   ('C1010', '+33', '774829576');

	  
INSERT INTO book	  
VALUES ('B0001', 'A Hitchhikers Guide to the Galaxy', 'Douglas Adams', 'Ultimate Books'),
       ('B0002', 'Cry, the Belovered Country', 'Alan Paton', 'Scribners'),
	   ('B0003', 'A Brief History of Time', 'Stephan Hawking', 'Bantam Dell Publishing Group'),
	   ('B0004', 'Red Notice', 'Bill Browder', 'Penguin'),
	   ('B0005', 'Dune', 'Frank Herbert', 'Ultimate Books'),
	   ('B0006', 'Kane and Abel', 'Jeffery Archer', 'Hodder'),
	   ('B0007', 'Mans Search for Meaning', 'Viktor Frankl', 'Penguin'),
	   ('B0008', 'The Structure of Scientific Revolutions', 'Thomas S. Kuhn', 'Ultimate Books'),
	   ('B0009', 'Sapians: A Brief History of Humankind', 'Yuval Noah Harari', 'Dvir House Ltd.'),
	   ('B0010', 'RISE', 'Siya Kolisi', 'HarperCollins');
	  	   
INSERT INTO reviews	
VALUES ('C1000', 'B0001', 5),
	   ('C1000', 'B0002', 3),
	   ('C6000', 'B0003', 5),
	   ('C1010', 'B0003', 3),
	   ('C3000', 'B0004', 1),
	   ('C7000', 'B0004', 4),
	   ('C2000', 'B0005', 4),
	   ('C4000', 'B0006', 3),
	   ('C5000', 'B0006', 4),
	   ('C9000', 'B0006', 4),
	   ('C1010', 'B0007', 2),
	   ('C1000', 'B0008', 5),
	   ('C4000', 'B0009', 3),
	   ('C6000', 'B0010', 4),
	   ('C8000', 'B0010', 5);	  
	  
INSERT INTO book_genre 
VALUES ('B0001', 'Science Fiction'),
	   ('B0002', 'Political Fiction'),
	   ('B0003', 'Science and Technology'),
	   ('B0004', 'Autobiography'),
       ('B0005', 'Science Fiction'),
       ('B0006', 'Fiction'),
       ('B0007', 'Autobiography'),
       ('B0008', 'Science and Technology'),
       ('B0009', 'Science and Technology'),
       ('B0010', 'Autobiography');	  
      
                    
INSERT INTO edition  
VALUES ('B0001', 1, 'paperback', 40.00, 2),
	   ('B0001', 2, 'audiobook', 50.00, 3),
	   ('B0002', 1, 'hardcover', 80.00, 4),
	   ('B0003', 1, 'paperback', 50.00, 3),
	   ('B0003', 2, 'paperback', 60.00, 3),
	   ('B0003', 3, 'hardcover', 80.00, 2),
	   ('B0004', 1, 'audiobook', 35.00, 6),
       ('B0005', 1, 'hardcover', 110.00, 1),
       ('B0005', 6, 'paperback', 72.00, 9),
       ('B0006', 1, 'paperback', 45.00, 7),
       ('B0007', 1, 'hardcover', 86.00, 2),
       ('B0008', 1, 'paperback', 35.00, 4),
       ('B0008', 3, 'paperback', 45.00, 2),
       ('B0008', 3, 'audiobook', 45.00, 7),
       ('B0009', 1, 'audiobook', 42.00, 5),
       ('B0010', 1, 'hardcover', 92.00, 1);

   
 INSERT INTO containsAn 
 VALUES ('OR1000','B0001', 2, 'audiobook', 1), 
        ('OR2000','B0002', 1, 'hardcover', 2),
        ('OR2000','B0008', 3, 'audiobook', 5),
        ('OR3000','B0005', 6, 'paperback', 1),
        ('OR4000','B0004', 1, 'audiobook', 3),
        ('OR5000','B0006', 1, 'paperback', 2),
        ('OR5000','B0009', 1, 'audiobook', 1),
        ('OR6000','B0006', 1, 'paperback', 1),
        ('OR7000','B0010', 1, 'hardcover', 2),
        ('OR8000','B0003', 1, 'paperback', 2),
        ('OR9000','B0004', 1, 'audiobook', 3),
        ('OR1010','B0010', 1, 'hardcover', 1),
        ('OR1011','B0006', 1, 'paperback', 1),
        ('OR1012','B0003', 3, 'hardcover', 2),
        ('OR1013','B0007', 1, 'hardcover', 1);
 
INSERT INTO supplier 
VALUES ('S1', 'Exclusive Books', 'S1001'), 
	   ('S2', 'Macro Books', 'S1002'),
	   ('S3', 'AudioRus', 'S1003');
     
INSERT INTO supplier_phone 
VALUES ('S1', '+44 674920485'),
	   ('S2', '+44 572048633'),
	   ('S3', '+44 112349684');       
             
INSERT INTO supplies
VALUES ('B0001', 1, 'paperback', 'S1', 35.00),
	   ('B0001', 1, 'paperback', 'S2', 25.00),
	   ('B0001', 2, 'audiobook', 'S1', 45.00),
	   ('B0002', 1, 'hardcover', 'S1', 75.00),
	   ('B0003', 1, 'paperback', 'S2', 40.00),
	   ('B0003', 3, 'hardcover', 'S2', 65.00),
	   ('B0003', 1, 'paperback', 'S1', 45.00),
	   ('B0003', 2, 'paperback', 'S3', 48.00),
	   ('B0004', 1, 'audiobook', 'S3', 32.00),
       ('B0005', 1, 'hardcover', 'S1', 100.00),
       ('B0005', 6, 'paperback', 'S2', 62.00),
       ('B0006', 1, 'paperback', 'S2', 35.00),
       ('B0007', 1, 'hardcover', 'S2', 76.00),
       ('B0008', 1, 'paperback', 'S1', 25.00),
       ('B0008', 3, 'paperback', 'S1', 30.00),
       ('B0008', 3, 'audiobook', 'S3', 30.00),
       ('B0009', 1, 'audiobook', 'S3', 37.00),
       ('B0010', 1, 'hardcover', 'S2', 82.00),
       ('B0010', 1, 'hardcover', 'S1', 88.00);
        
  
----------------------------------------------------------------------
-- VISUAL DATA CONTROL
----------------------------------------------------------------------

SELECT * FROM orderBook; 	  

SELECT * FROM customer;

SELECT * FROM customer_phone;

SELECT * FROM reviews;

SELECT * FROM book;

SELECT * FROM book_genre;

SELECT * FROM edition; 

SELECT * FROM containsAn; 

SELECT * FROM supplies; 

SELECT * FROM supplier;

SELECT * FROM supplier_phone; 

----------------------------------------------------------------------
-- TASK 2.2 Testing Integrity Constraints 
----------------------------------------------------------------------
/*
-- 1. orderBook  
-- order_id	NOT NULL  
INSERT INTO orderbook 
VALUES (NULL, 'C7530', 'Daisy street', 'London', 'LO 3187', 'England', '2018-04-16', '2021-06-28');

-- order_id PK
INSERT INTO orderBook 
VALUES ('OR1000', 'C1000', 'Daisy street', 'London', 'LO 3187', 'England', '2021-04-16', '2021-04-18');

-- customer_id
INSERT INTO orderbook 
VALUES ('OR2345', NULL, 'Daisy street', 'London', 'LO 3187', 'England', '2018-04-16', '2021-06-28');

-- street
INSERT INTO orderbook 
VALUES ('OR2345','C7530', NULL, 'London', 'LO 3187', 'England', '2018-04-16', '2021-06-28');

-- city 
INSERT INTO orderbook 
VALUES ('OR2345','C7530', 'Daisy street', NULL, 'LO 3187', 'England', '2018-04-16', '2021-06-28');

-- postcode
INSERT INTO orderbook 
VALUES ('OR2345','C7530', 'Dasiy Street', 'London', NULL, 'England', '2018-04-16', '2021-06-28');

-- country
INSERT INTO orderBook 
VALUES ('OR1000', 'C1000', 'Daisy street', 'London', 'LO 3187', NULL, '2021-04-16', '2021-04-18');

-- date_ordered
INSERT INTO orderBook 
VALUES ('OR1000', 'C1000', 'Daisy street', 'London', 'LO 3187', 'England', NULL, '2021-04-18');

-- 2. Customer
--cusotmer_id PK and email UNIQUE
INSERT INTO customer 
VALUES ('C1000', 'bongi@gmail.com', 'Daisy street', 'London', 'LO 3187', 'England');

-- email 
INSERT INTO customer 
VALUES ('C1000', NULL, 'Daisy street', 'London', 'LO 3187', 'England');

-- 3. customer_phone
-- phone_number
INSERT INTO customer_phone  
VALUES ('C7530', '+44', '714921236');

-- 4. reviews
-- book_id
INSERT INTO reviews	
VALUES ('C1000', NULL, 5); 

-- 5. book
-- title
INSERT INTO book	  
VALUES ('B0001', NULL, 'Douglas Adams', 'Ultimate Books');

-- 7. book_genre
-- genre
INSERT INTO book_genre 
VALUES ('B0001', NULL);

-- 8. editon 
-- quantity_in_stock
INSERT INTO edition  
VALUES ('B0001', 1, 'ebook', 40.00, 2);

-- 10. supplies
-- supply_price 
INSERT INTO supplies
VALUES ('B0001', 1, 'paperback', 'S1', NULL);

-- 11. supplier
-- name 
INSERT INTO supplier 
VALUES ('S1', NULL, 'S1001');

-- account_no NOT NULL
INSERT INTO supplier 
VALUES ('S1', 'Exclusive Books', NULL);

-- account_no UNIQUE
INSERT INTO supplier 
VALUES ('S1', 'Exclusive Books', 'S1001');
*/
--------------------------------------------------
-- TASK 3: SQL Data Manipulation
--------------------------------------------------

-- 1. List all books published by “Ultimate Books” which are in the “Science Fiction” genre;

SELECT book_id, title, author 
FROM book NATURAL JOIN
	 (SELECT book_id 
	  FROM book_genre
	  WHERE genre = 'Science Fiction')
WHERE publisher = 'Ultimate Books';


-- 2. List titles and ratings of all books in the “Science and Technology” genre, 
-- ordered first by rating (top rated first), and then by the title;

SELECT book_id, title, AVG(rating)
FROM book NATURAL JOIN reviews
NATURAL JOIN (
	 SELECT book_id
	 FROM book_genre
	 WHERE genre = 'Science and Technology')
GROUP BY book_id ORDER BY AVG(rating) DESC, title;
	
-- 3. List all orders placed by customers with customer address in the city of Edinburgh, 
-- since 2020, in chronological order, latest first;	
	
SELECT order_id, customer_id, date_ordered 
FROM orderBook NATURAL JOIN (
	 SELECT customer_id 
	 FROM customer 
	 WHERE city = 'Edinburgh')
WHERE date_ordered >= '2020-01-01'
ORDER BY date_ordered DESC;

-- 4. List all book editions which have less than 5 items in stock, together with the name, 
-- account number and supply price of the minimum priced supplier for that edition.

SELECT book_id, book_edition, name, account_no, MIN(supply_price) AS "Min Pr. Supplier"
FROM edition NATURAL JOIN supplies NATURAL JOIN book NATURAL JOIN supplier
WHERE quantity_in_stock < 5
GROUP BY book_id, book_edition; 

-- 5. Calculate the total value of all audiobook sales since 2020 for each publisher

-- First I wanted to check the values manaully, Incase one publisher has sold different audio books
SELECT publisher,  book_id, order_id, price, amount, price*amount AS "Total Sales"
FROM book NATURAL JOIN edition NATURAL JOIN containsAn NATURAL JOIN orderBook
WHERE book_type ='audiobook' AND date_delivered >= '2020-01-01';

-- Then I implemented the final code
 
SELECT publisher, SUM(price*amount) AS "Total Sales"
FROM book NATURAL JOIN edition NATURAL JOIN containsAn NATURAL JOIN orderBook
WHERE book_type ='audiobook' AND date_delivered >= '2020-01-01'
GROUP BY publisher;

--------------------------------------------------
-- TASK 3.1: NEW QUERIES 
--------------------------------------------------

-- 1. List title, editon, type, author, price, and quantity in stock of book/s with a 5 star rating. 
	  
SELECT title, book_edition AS "Edition", book_type, price, quantity_in_stock AS "Quantity"
FROM book NATURAL JOIN edition
NATURAL JOIN (
	SELECT book_id
	FROM reviews
	WHERE rating = 5);

-- 2. List the average price charged by each supplier for each book type

SELECT supplier_id, name, book_type, round(AVG(supply_price), 2) AS "Avg. Supply Price"
FROM supplies NATURAL JOIN supplier NATURAL JOIN book
GROUP BY supplier_id, book_type;

-- 3. List all customer ID's and their emails of customers who purchased more than one hardcover book

SELECT order_id, customer_id, email
FROM containsAn NATURAL JOIN orderBook NATURAL JOIN customer
WHERE book_type = 'hardcover' AND amount > 1;


--------------------------------------------------
-- TASK 3.2: VIEWS
--------------------------------------------------

-- Create a view of profit margin made (mark-up) on each book 
--DROP VIEW mark_up	  
CREATE VIEW mark_up AS	  
SELECT book_id, price, supply_price, price - supply_price AS "Profit Margin"
FROM edition NATURAL JOIN supplies;

SELECT * FROM mark_up;

-- Create a view of orders wihtout customer adress 
-- DROP VIEW order_overview 
CREATE VIEW order_overview AS
SELECT order_id, customer_id, date_ordered, date_delivered
FROM orderBook;

SELECT * FROM order_overview;

	  