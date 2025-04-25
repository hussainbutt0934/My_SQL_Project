DROP TABLE IF EXISTS Books;

-- Create Tables
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);
-- Import data into Books table.
SELECT * FROM Books;
--Import data into Customers table.
SELECT * FROM Customers;
--Import data into orders table.
SELECT * FROM Orders;


-- Retrieve all the books in the 'FICION ' genre.

SELECT * FROM Books
WHERE genre='Fiction';

-- Find books published books after the year 1950.
SELECT * FROM Books
WHERE published_year>1950;

-- Find all the customers from specific country example 'CANADA'

SELECT * FROM Customers
WHERE Country= 'Canada';

-- Show order placed in November 2023.

SELECT * FROM orders
WHERE order_date BETWEEN '2023-11-1' AND '2023-11-30';

-- Get all orders placed after 1st jan 2024.

SELECT * FROM orders
WHERE order_date>'2024-1-1';

-- Retrieve the total books of stock available.

SELECT SUM(stock) AS available_stock
FROM Books;

-- Find the details of the most expensive books.

SELECT * FROM Books ORDER BY Price DESC LIMIT 1;

-- Show all the customers who order more than 1 quantity of the book

SELECT * FROM orders
WHERE quantity>='1';

-- Retrieve all the orders where the total amount exceeds 20$.

SELECT * FROM orders
WHERE total_amount>'100';

-- List all genre available in the book table.

SELECT DISTINCT genre FROM Books;

-- Show the stock quantity for each Book.

SELECT title, stock FROM Books;

-- Find the book with the lowest stock.

SELECT title,stock FROM Books ORDER BY stock ASC;

-- Advanced Questions

-- Retreive the total numbers of books sold for each genre.

SELECT * FROM orders;

SELECT b.genre,SUM(o. quantity) AS total_book_sold
FROM orders o
JOIN Books b ON b. book_id = o.book_id
GROUP BY b. genre;

-- Which book has the highest sale revnue.

SELECT b.title, SUM(o.total_amount) AS highest_revenue
FROM orders o
join Books b ON o.book_id = b. book_id
GROUP BY b.title
ORDER BY highest_revenue DESC
LIMIT 5;

  SELECT * FROM Customers;
-- Top 3 customers who spent the most

SELECT c.name, SUM(o.total_amount) AS most_spent
FROM customers c
JOIN orders o ON c. customer_id = o. customer_id
GROUP BY name
ORDER BY most_spent DESC
LIMIT 4;

--Find the average price of books in the 'fantacy' genre

SELECT genre, AVG(price) AS AVG_price
FROM Books
 GROUP BY genre;

 --  Calculate year-wise total sales

 SELECT 
     EXTRACT (YEAR FROM order_date) AS year,
	 SUM(total_amount) AS total_sales
	 FROM orders
	 GROUP BY year
	 ORDER BY year;

-- Calculate the stock remaining after fulfilling all orders

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(quantity),0) AS order_quantity,
b.stock- COALESCE (SUM(o.quantity),0) AS Remaining_quantity
FROM Books b
LEFT JOIN orders o ON b.book_id = b. book_id
GROUP BY b.book_id;

 /* Project: Bookstore Sales and Customer Analytics using SQL

Designed and normalized 3 core tables (Books, Customers, Orders)

Wrote 18+ queries for sales, customer behavior, and inventory insights

Included advanced revenue analysis, customer segmentation, and order trend analytics
*/ 


 








