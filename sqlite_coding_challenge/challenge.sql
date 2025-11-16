-- TASK 1: Top 5 customers by total spend
SELECT 
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_spend
FROM customers c
INNER JOIN orders o ON c.id = o.customer_id
INNER JOIN order_items oi ON o.id = oi.order_id
GROUP BY c.id, c.first_name, c.last_name
ORDER BY total_spend DESC
LIMIT 5;

-- TASK 2: Revenue by product category
SELECT 
    p.category,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- TASK 3: Employees above department average salary
SELECT 
    e.first_name,
    e.last_name,
    d.name AS department_name,
    e.salary,
    dept_avg.avg_salary AS department_average
FROM employees e
INNER JOIN departments d ON e.department_id = d.id
INNER JOIN (
    SELECT 
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) dept_avg ON e.department_id = dept_avg.department_id
WHERE e.salary > dept_avg.avg_salary
ORDER BY d.name, e.salary DESC;

-- TASK 4: Most loyal cities (Gold customers)
SELECT 
    city,
    COUNT(*) AS gold_customer_count
FROM customers
WHERE loyalty_level = 'Gold'
GROUP BY city
ORDER BY gold_customer_count DESC, city;