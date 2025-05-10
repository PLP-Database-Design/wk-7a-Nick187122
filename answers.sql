-- QUESTION 1
-- Create the normalized table structure
CREATE TABLE NormalizedOrders (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert data in 1NF by splitting multi-value products
INSERT INTO NormalizedOrders (OrderID, CustomerName, Product)
VALUES 
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');



-- QUESTION 2
-- Step 1: Create Orders table (removes partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create OrderItems table (fully dependent on composite key)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Insert data into normalized tables
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;
