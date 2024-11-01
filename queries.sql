--Creating table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    manager_id INT NULL, 
    department_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);



-- Inserting
INSERT INTO employees (employee_id, first_name, last_name, manager_id, department_name, email, phone) 
VALUES (1, 'Alice', 'Sharma', NULL, 'HR', 'alice@mail.com', '1231231230');

INSERT INTO employees (employee_id, first_name, last_name, manager_id, department_name, email, phone) 
VALUES (2, 'Bob', 'Jha', NULL, 'IT', 'bob@mail.com', '1234567890');

INSERT INTO employees (employee_id, first_name, last_name, manager_id, department_name, email, phone) 
VALUES (3, 'John', 'Gada', 1, 'HR', 'john@mail.com', '1234567890');

INSERT INTO employees (employee_id, first_name, last_name, manager_id, department_name, email, phone) 
VALUES (4, 'Yuvraj', 'Singh', 1, 'HR', 'yuvraj@mail.com', '1234567890');

INSERT INTO employees (employee_id, first_name, last_name, manager_id, department_name, email, phone) 
VALUES (5, 'Manav', 'Gupta', 2, 'IT', 'manav@mail.com', '1234567890');

INSERT INTO employees (employee_id, first_name, last_name, manager_id, department_name, email, phone) 
VALUES (6, 'Ashu', 'Dogra', 2, 'IT', 'ashu@mail.com', '0987654321');

INSERT INTO employees (employee_id, first_name, last_name, manager_id, department_name, email, phone) 
VALUES (7, 'Ajay', 'Verma', NULL, 'Sales', 'ajay@mail.com', '0985432345');  


SELECt * from employees


-- Query 1: Get all employees under manager
SELECT 
    e.employee_id AS employee_id,
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    m.first_name AS manager_first_name,
    m.last_name AS manager_last_name
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id;


-- Query 2: Get the count of employees under each manager 
SELECT 
    m.first_name AS manager_first_name,
    m.last_name AS manager_last_name,
    COUNT(e.employee_id) AS employee_count
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
GROUP BY m.first_name, m.last_name;


-- Query 3: Get all manager details
SELECT DISTINCT 
    m.employee_id,
    m.first_name,
    m.last_name,
    m.department_name,
    m.email,
    m.phone
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id;


--Query 4: Find employees who have no manager
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.department_name,
    e.email,
    e.phone
FROM employees e
LEFT JOIN employees m ON e.employee_id = m.manager_id
WHERE e.manager_id IS NULL AND m.employee_id IS NULL;


--Query 5: Create a function to get the full name of an employee
DELIMITER $$

CREATE FUNCTION get_full_names(emp_id INT) 
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE full_name VARCHAR(100);
    
    SELECT CONCAT(first_name, ' ', last_name) INTO full_name
    FROM employees
    WHERE employee_id = emp_id
    LIMIT 1; 
    
    RETURN full_name;
END$$

DELIMITER ;


SELECT get_full_names(2) AS full_name;



 
