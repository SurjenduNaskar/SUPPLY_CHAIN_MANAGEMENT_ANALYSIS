# 1 Product type wise sales
SELECT 
    PT.PRODUCTTYPE AS PRODUCTS, 
    CONCAT(FORMAT(SUM(SL.SALESAMOUNT / 1000000), 2), "M") AS TOTAL_SALES 
FROM d_product PT 
INNER JOIN f_point_of_sale SL ON PT.ProductKey = SL.ProductKey 
GROUP BY PT.PRODUCTTYPE;



# 2 PRODUCT WISE SALES
SELECT 
    PT.PRODUCTNAME AS PRODUCT, 
    CONCAT(FORMAT(SUM(SL.SALESAMOUNT / 1000), 2), "K") AS TOTAL_SALES 
FROM d_product PT 
INNER JOIN f_point_of_sale SL ON PT.ProductKey = SL.ProductKey 
GROUP BY PT.PRODUCTNAME;

# 3 YEAR WISE SALES GROWTH

SELECT 
    YEAR(`Date`) AS "YEAR",
    CONCAT(FORMAT(SUM(Quantity * Price / 1000000), 2), "M") AS TOTALSALES
FROM PLUG_ELECTRONICS
GROUP BY YEAR(`Date`)
ORDER BY YEAR(`Date`);

# 4 DAILY SALES (MONTLY)

SELECT  
    YEAR(SALESDate) AS "YEAR",  
    DATE_FORMAT(SALESDate, '%M') AS "MONTHNAME",  
    CONCAT(FORMAT(SUM(Quantity * Price / 1000000), 2), "M") AS TOTALSALES  
FROM PLUG_ELECTRONICS  
GROUP BY YEAR(SALESDate), DATE_FORMAT(SALESDate, '%M')  
ORDER BY YEAR(SALESDate), MIN(SALESDate);

# 5 STORE STATE WISE SALES

SELECT 
    STORE_STATE, 
    CONCAT(FORMAT(SUM(Quantity * Price / 1000000), 2), "M") AS TOTAL_SALES 
FROM PLUG_ELECTRONICS
GROUP BY STORE_STATE
ORDER BY SUM(Quantity * Price) DESC;

# 6 TOP 5 STORE WISE SALES

SELECT STORE_NAME,CONCAT(FORMAT(SUM(PRICE*QUANTITY/1000000),2),"M")
 AS TOTAL_SALES FROM plug_electronics 
 GROUP BY STORE_NAME 
 ORDER BY TOTAL_SALES DESC LIMIT 5;

# 7 STORE REGION WISE SALES
SELECT STORE_REGION,CONCAT(FORMAT(SUM(QUANTITY*PRICE/1000000),2),"M") AS
 TOTAL_SALES FROM plug_electronics
 GROUP BY STORE_REGION;
 
 
 # 8 YTD,QTD,MTD SALES GROWTH
 SELECT  
   CONCAT(FORMAT(SUM(
             CASE  
                 WHEN DATE_FORMAT(SALESDATE, '%Y-%m') = '2022-04'  
                 THEN QUANTITY * PRICE  
                 ELSE 0  
             END) / 1000000, 2), "M") AS MTD_Sales,  
   CONCAT(FORMAT(SUM(
             CASE  
                 WHEN QUARTER(SALESDATE) = QUARTER('2022-04-06')  
                      AND YEAR(SALESDATE) = YEAR('2022-04-06')  
                 THEN QUANTITY * PRICE  
                 ELSE 0  
             END) / 1000000, 2), "M") AS QTD_Sales,  
   CONCAT(FORMAT(SUM(
             CASE  
                 WHEN YEAR(SALESDATE) = YEAR('2022-04-06')  
                 THEN QUANTITY * PRICE  
                 ELSE 0  
             END) / 1000000, 2), "M") AS YTD_Sales  

FROM plug_electronics;

# 9 TOTAL INVENTORY

SELECT CONCAT(FORMAT(SUM(Quantity_on_HandS/1000),2),"k")
 AS Total_Inventory 
 FROM F_INVENTORY_ADJUSTED;

# 10 PRODUCT TYPE WISE INVENTORY VALUE
 SELECT PRODUCT_TYPE,
 CONCAT(FORMAT(SUM(Quantity_on_HandS * Cost_Amount/1000),0),"k")
 AS Total_Inventory_Value FROM F_INVENTORY_ADJUSTED GROUP BY PRODUCT_TYPE;


# 11 TOTAL INVENTORY VALUE

SELECT CONCAT(FORMAT(SUM(Quantity_on_HandS * Price) / 1000000, 2), "M") AS
Total_Inventory_Value
FROM F_INVENTORY_ADJUSTED;


# 12 Inventory Status

SELECT 
    Product_Key,
    Product_Name,
    Quantity_on_Hands,
    CASE 
        WHEN Quantity_on_Hands = 0 THEN 'Out of Stock'
        WHEN Quantity_on_Hands IN (1, 2) THEN 'In Stock'
        ELSE 'Over Stock'
    END AS Inventory_Status
FROM F_INVENTORY_ADJUSTED;


SELECT 
    CASE 
        WHEN Quantity_on_Hands = 0 THEN 'Out of Stock'
        WHEN Quantity_on_Hands IN (1, 2) THEN 'In Stock'
        ELSE 'Over Stock'
    END AS Inventory_Status,
    COUNT(*) AS Total_Products
FROM F_INVENTORY_ADJUSTED
GROUP BY Inventory_Status;
