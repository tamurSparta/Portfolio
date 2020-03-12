-- Write a query that lists all Customers in either Paris or London. Include Customer ID, Company Name and all
-- address fields.
SELECT  CustomerID,
        CompanyName,
        Address + ', ' + City + ', ' + PostalCode + ', ' +  Country AS 'Address', -- concatanating address columns into one 
        Region
FROM Customers
        WHERE City = 'Paris' OR City = 'London' -- only returning details from London or Paris 



-- List all products stored in bottles.
SELECT 
        QuantityPerUnit   
FROM Products
        WHERE QuantityPerUnit LIKE '%bottle%' -- % wildcard here finds any characters before or after the word bottle 




--Repeat question above but add in the Supplier Name and Country.
SELECT  p.QuantityPerUnit,
        s.CompanyName,
        s.Country
FROM Products p
        JOIN Suppliers s -- using inner join to join Suppliers table with products using the supplierID column to pull supplier name and country info 
        ON p.SupplierID = s.SupplierID
        WHERE p.QuantityPerUnit LIKE '%bottle%' --% wildcard here finds any characters before or after the word bottle 
 



--Write an SQL Statement that shows how many products there are in each category. Include Category Name in
--result set and list the highest number first.
SELECT  DISTINCT C.CategoryName, -- only returning unique Category names 
        COUNT(ProductName) OVER (PARTITION BY c.CategoryName) AS 'TOTAL' --counting the product names in each catgeory and partitioning by category name. 
FROM                                                                     --Splits the category results into partitions(categories) and calculates the amount of products within siad category
        Categories c
JOIN Products P 
        ON c.CategoryID = p.CategoryID
ORDER BY TOTAL DESC --ordering by descending order to show category with highest total first




--List all UK employees using concatenation to join their title of courtesy, first name and last name together. Also
--include their city of residence.
SELECT TitleOfCourtesy + ' ' + FirstName + ' ' + LastName AS 'Full Name', -- concatenating employee name and title  as Full Name 
       City as 'City of Residence' -- aliasing city column name to a more informative name 
 FROM Employees
 WHERE Country = 'UK' -- only returning employees within the UK 






-- List Sales Totals for all Sales Regions with a Sales Total greater than
-- 1,000,000. Use rounding or FORMAT to present the numbers. 
SELECT r.RegionDescription AS 'Region', FORMAT(SUM(od.Quantity * od.UnitPrice),'#,###,###') AS 'Total Sales' -- formatting the result to a clear number format 
FROM Territories t -- aliasing table name for easier use 
JOIN Region r ON t.RegionID = r.RegionID --joining Region to territories via regionID 
JOIN [EmployeeTerritories] et ON t.TerritoryID = et.TerritoryID --joining ET to territories via territoryID 
JOIN Orders o ON et.EmployeeID = o.EmployeeID --joining Orders to ET via the EmployeeID
JOIN [Order Details] od ON o.OrderID = od.OrderID -- joining order details to orders via orderID 
GROUP BY r.RegionDescription -- grouping by region name 
HAVING SUM(od.Quantity * od.UnitPrice) > 1000000 -- getting the sum of the gross and returning only regions where its greater than 100000




--Count how many Orders have a Freight amount greater than 100.00 and either USA or UK as Ship Country
SELECT count(OrderID) AS 'Freight Amount Greater than 100.00' -- giving new column that gets returned a name 
FROM [Orders] 
WHERE Freight > 100.00 AND (ShipCountry = 'UK' OR ShipCountry = 'USA') -- only returning freight amount greater than 100 and country where its UK or USA 




-- Write an SQL Statement to identify the Order Number of the Order with the highest amount of discount applied
-- to that order.
SELECT TOP 1 -- returning only the first row 
    OrderID, 
    COUNT(*) OVER (ORDER BY OrderID) AS 'Order Number', --counting  and returning number of orders in OrderID including nulls and dupilcates. 
                                                        --over clause to count the number of order ids in each parition of the result set
    FORMAT(SUM(Quantity * UnitPrice * Discount),'####.##') AS 'Total Discount Amount'  -- getting the sum of gross total and formating in clearer number format 
FROM [Order Details]
GROUP BY OrderID
ORDER BY SUM(Quantity * UnitPrice * Discount) DESC -- ordering by descending order  to show highest value first 

select * from [Order Details]
where OrderID = 11030



-- For only the 2nd order placed by each customer, show product names along with the total quantity of units
-- ordered. 
SELECT ProductName, Quantity
FROM [Order Details] od -- alaising shorter table name 
JOIN( --joining using a subqueary 
    SELECT
        OrderID,
        RANK() OVER (PARTITION BY CustomerID ORDER BY OrderID) AS 'OrderNo' -- returning the rank of each row inside the partition of the result set, 
                                                                            -- calcualted by 1 plus the number of ranks that come before it (rank function is applied last).
                                                                            -- The partition clause seperates the rows in the result set into partitions(groups).
                                                                            -- Then the order by clause sorts the rows inside each partition.
                                                                            -- Finally the rank function operates on the rows within each and starts again when it moves 
                                                                            -- to the next partition
    FROM Orders o
) AS sq1 -- aliasing subquery 
        ON od.OrderID = sq1.OrderID --joining subquery orders table with order details table  via OrderID 
JOIN Products p --joining products 
    ON od.ProductID = p.ProductID --joining products to order details via productID 
WHERE OrderNo = 2 -- returning only the 2nd order placed by customers 



