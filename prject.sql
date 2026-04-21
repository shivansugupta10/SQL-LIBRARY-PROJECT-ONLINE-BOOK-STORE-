create table BOOKS1(
	Book_ID serial primary key,
	Title text ,
	Author varchar(100),
	Genre varchar(50),
	Published_Year int,
	Price numeric(10,2),
	Stock int
);
select * from  BOOKS1 ;
copy BOOKS1
from 'D:\sql\30 Day - SQL Practice Files- SD50\30 Day - SQL Practice Files\Books.csv'
delimiter ','
CSV HEADER ;

 CREATE TABLE CUSTOMER1( 
 	Customer_ID SERIAL PRIMARY KEY,
	 Name VARCHAR(100),
	 Email VARCHAR(100) UNIQUE,
	 Phone BIGINT,
	 City VARCHAR(100),
	 Country VARCHAR(100)
	 );

	 SELECT * FROM CUSTOMER1 ;

	 COPY CUSTOMER1 
	 FROM 'D:\sql\30 Day - SQL Practice Files- SD50\30 Day - SQL Practice Files\Customers.csv'
	 DELIMITER ','
	 CSV HEADER ;



	 CREATE TABLE ORDER1(
	Order_ID INT NOT NULL,
	Customer_ID INT references CUSTOMER1(Customer_ID) , 
	Book_ID INT references BOOKS1(Book_ID) ,
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)
	 );

	 COPY ORDER1
	 FROM 'D:\sql\30 Day - SQL Practice Files- SD50\30 Day - SQL Practice Files\Orders.csv'
	 DELIMITER ','
	 CSV HEADER ;

	 SELECT * from  ORDER1 ;

     



	 --- basic sql question

	 -- 1) Retrieve all books in the "Fiction" genre:

	 select * from BOOKS1
	 where genre='Fiction';

	 -- 2) Find books published after the year 1950:

	 select * from BOOKS1
	 where Published_Year> 1950 ;

	-- 3) List all customers from the Canada:

		 select * from CUSTOMER1
		 where country='Canada';

	-- 4) Show orders placed in November 2023: 

		 select * from ORDER1
		 where order_date between '2023-11-01' and '2023-11-30';


    -- 5) Retrieve the total stock of books available:
        

         select sum(stock) as total_stock
         from BOOKS1 ;


    -- 6) Find the details of the most expensive book:
           
         select * from BOOKS1
         order by price desc ;

    -- 7) Show all customers who ordered more than 1 quantity of a book:
 
        	 select * from order1
		 where quantity>1;

     -- 8) Retrieve all orders where the total amount exceeds $20:

               
        	 select * from order1
              where total_amount>20;
     
    -- 9) List all genres available in the Books table:
        
        select distinct genre from books1 ;
    
    
    -- 10) Find the book with the lowest stock:
        
     SELECT
	*
FROM
	BOOKS1
ORDER BY
	STOCK
LIMIT
	1;
    
    -- 11) Calculate the total revenue generated from all orders:

      select sum(total_amount) as revenue from order1  ;

	  

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:

SELECT * FROM ORDERS;

SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;


-- 2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';


-- 3) List customers who have placed at least 2 orders:
SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;




-- 4) Find the most frequently ordered book:
SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;



-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;


-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;





-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount > 30;


-- 8) Find the customer who spent the most on orders:
SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_spent Desc LIMIT 1;


--9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;


       


        







        
        


		
	
	 

	 