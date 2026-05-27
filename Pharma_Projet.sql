-- Pharma Inventory Management System
CREATE DATABASE pharma_inventory;
USE pharma_inventory;
CREATE TABLE medicines (
    medicine_id INT PRIMARY KEY,
    medicine_name VARCHAR(50),
    category VARCHAR(30),
    price DECIMAL(10,2),
    manufacturer VARCHAR(50)
);
INSERT INTO medicines VALUES
(101, 'Paracetamol', 'Tablet', 25.50, 'Mankind Pharma'),
(102, 'Amoxicillin', 'Capsule', 80.00, 'Sun Pharma'),
(103, 'Cetirizine', 'Tablet', 15.00, 'Cipla'),
(104, 'Cough Syrup', 'Syrup', 60.00, 'Dr Reddys'),
(105, 'Vitamin C', 'Tablet', 40.00, 'Mankind Pharma');
SELECT * FROM medicines;
CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    medicine_id INT,
    stock_quantity INT,
    expiry_date DATE,
    batch_no VARCHAR(20),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);
INSERT INTO inventory VALUES
(1, 101, 500, '2027-01-15', 'B101'),
(2, 102, 200, '2026-11-20', 'B102'),
(3, 103, 350, '2026-09-10', 'B103'),
(4, 104, 150, '2026-08-25', 'B104'),
(5, 105, 400, '2027-03-18', 'B105');
SELECT * FROM inventory;
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    medicine_id INT,
    quantity_sold INT,
    sale_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);
INSERT INTO sales VALUES
(1, 101, 50, '2026-05-01', 1275.00),
(2, 102, 20, '2026-05-03', 1600.00),
(3, 103, 35, '2026-05-05', 525.00),
(4, 104, 15, '2026-05-08', 900.00),
(5, 105, 40, '2026-05-10', 1600.00);
SELECT * FROM sales;

-- 1,VIEW SALES TABLE
SELECT * FROM sales;

-- 2,VIEW ALL MEDICINES
SELECT * FROM medicines;

-- 3,VIEW MEDICINE NAME AND PRICE
SELECT medicine_name, price
FROM medicines;

-- LOW STOCK ANALYSIS
-- 4, Medicines having stock less than 300
SELECT *
FROM inventory
WHERE stock_quantity < 300;


-- 5,VIEW MEDICINES EXPIRING SOON
SELECT *
FROM inventory
WHERE expiry_date < '2026-12-31';

-- 6,TOTAL STOCK AVAILABLE
SELECT SUM(stock_quantity) AS total_stock
FROM inventory;

-- 7,TOTAL SALES AMOUNT
SELECT SUM(total_amount) AS total_sales
FROM sales;

-- 8,MOST EXPENSIVE MEDICINE
SELECT *
FROM medicines
WHERE price = (
    SELECT MAX(price)
    FROM medicines
);

-- 9,MEDICINE SALES REPORT USING JOIN
SELECT 
    medicines.medicine_name,
    sales.quantity_sold,
    sales.total_amount
FROM medicines
JOIN sales
ON medicines.medicine_id = sales.medicine_id;

-- 10,INVENTORY REPORT USING JOIN
SELECT 
    medicines.medicine_name,
    inventory.stock_quantity,
    inventory.expiry_date
FROM medicines
JOIN inventory
ON medicines.medicine_id = inventory.medicine_id;

-- 11,TOTAL SALES BY EACH MEDICINE
SELECT 
    medicines.medicine_name,
    SUM(sales.quantity_sold) AS total_quantity_sold
FROM medicines
JOIN sales
ON medicines.medicine_id = sales.medicine_id
GROUP BY medicines.medicine_name;

-- 12,MEDICINES MANUFACTURED BY MANKIND PHARMA
SELECT *
FROM medicines
WHERE manufacturer = 'Mankind Pharma';

-- 14,SORT MEDICINES BY PRICE
SELECT *
FROM medicines
ORDER BY price DESC;

-- 15,COUNT TOTAL MEDICINES
SELECT COUNT(*) AS total_medicines
FROM medicines;