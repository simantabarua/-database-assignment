##  Questions and Answers

---
## 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.
- Primary Key হল একটি ইউনিক identifier যা একটি টেবিলে প্রতিটি রেকর্ডকে ইউনিকভাবে শনাক্ত করে থাকে  এবং কখনো NULL হয় না।
- Foreign Key হল অন্য েএকটি টেবিলের Primary Key-এর রেফারেন্স, যা দুটি টেবিলের মধ্যে সম্পর্ক স্থাপন করে থাকে।

**Example:**
```sql
CREATE TABLE departments (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100)
);

CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  department_id INTEGER REFERENCES departments(id)
);
```
এখানে  department_id টি  departments টেবিলের Primary Key হিসেবে আছে। আবার employees টেবিলে  department_id টি Foreign Key হিসেবে ব্যবহৃত হয়ে departments টেবিলের সাথে employees এর মধ্যে সম্পর্ক স্থাপন করেছে। 


---

## 4. What is the difference between the VARCHAR and CHAR data types?
- VARCHAR(n) হল variable length ডেটা টাইপ, যা সর্বোচ্চ `n` সংখ্যক ক্যারেক্টার পর্যন্ত নিতে পারে।


**Example:**
```sql
user_name VARCHAR(100)
```
 এখানে user_name VARCHAR(100)  যা সর্বোচ্চ user_name এর 100 টা পর্যন্ত ক্যারেক্টার  নিতে পারবে। 

- CHAR(n) হল fixed length type, যেখানে প্রতিটি ভ্যালু `n` ক্যারেক্টারে পূর্ণ হয় আর  যদি `n` ক্যারেক্টারে কম হলে সেটি স্পেস দিয়ে পূরণ করে দেয়।

**Example:**
```sql
 user_name CHAR(10),
```
 এখানে user_name CHAR(10)  যা সর্বোচ্চ user_name এর 10 টা পর্যন্ত ক্যারেক্টার  নিতে পারবে কিন্তু যদি 10 ক্যারেক্টারের কম হয় তা empty  স্পেস দিয়ে ‍ পূরণ করে দিবে। 


---

## 6. What are the LIMIT and OFFSET clauses used for?
- LIMIT হল একটি টেবিল থেকে কুয়ারি করার সময় কতটি row  return করবে নির্ধারণ করে থাকে।

**Example:**
```sql
SELECT * FROM products ORDER BY price LIMIT 15;
```
এখানে products টেবিল থেকে 15 টি price row কে return করবে

- OFFSET হল কতটি row  স্কিপ করে তারপর return  করবে তা নির্ধারণ করে থাকে।

**Example:**
```sql
SELECT * FROM products ORDER BY price DESC LIMIT 5 OFFSET 10;
```
এখানে products টেবিল থেকে  price কে  descending order এ সাজিয়ে  ১ম 10টি স্কিপ করবে এরং  পরবর্তী 5টি  row কে return করবে।

---

## 7. How can you modify data using UPDATE statements?
UPDATE স্টেটমেন্ট টি ব্যবহার করে টেবিলের রেকর্ড পরিবর্তন করার জন্য WHERE ব্যবহার করে হয় নির্দিষ্ট রেকর্ড টার্গেট করার জন্য এবং SET দ্বারা রেকর্ড পরিবর্তন করা হয়

**Example:**
```sql
UPDATE employees
SET salary = salary + 1000
WHERE department_id = 2;
```
এখানে employees টেবিলে UPDATE স্টেটমেন্ট ব্যবহার করে যেখানে department_id = 2 সেখানে existing salary এর সাথে 1000 যোগ করে আপডেট করা হয়েছে।

---

## 8. What is the significance of the JOIN operation, and how does it work in PostgreSQL?
JOIN operation দ্বারা একাধিক টেবিল যুক্ত করে তার  থেকে সম্পর্কযুক্ত ডটা return করার জন্য ব্যবহৃত হয়। PostgreSQL এর বিভিন্ন ধরণের JOIN operation আছে
যথা:
- INNER JOIN: উভয় টেবিলে সাথে মিল আছে এমন রেকর্ড return করে।
- LEFT JOIN: বাম টেবিলের সব রেকর্ডের সাথে ও মিল পাওয়া ডান টেবিলের রেকর্ড return করে।  না থাকলে NULL দেখায়
- RIGHT JOIN: ডান টেবিলের সব রেকর্ডের সাথে ও মিল পাওয়া বাম টেবিলের রেকর্ড return করে। না থাকলে NULL দেখায়
- FULL JOIN: উভয় টেবিলের সব মিল এবং অমিল রেকর্ড return করে।

### 1. INNER JOIN  
```sql
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;
```

| employee_name | department_name |
| -------------- | ---------------- |
| Sagor          | HR               |
| Nodi           | Engineering      |

---

### 1. LEFT JOIN  
```sql
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;
```

| employee_name | department_name |
| -------------- | ---------------- |
| Sagor          | HR               |
| Nodi           | Engineering      |
| Akash          | NULL             |
| Batas          | NULL             |

---

### 3. Right JOIN  
```sql
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;
```

| employee_name | department_name |
| -------------- | ---------------- |
| Sagor          | HR               |
| Nodi           | Engineering      |
| NULL           | Marketing        |
---

### 4. Full JOIN  
```sql
SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
FULL JOIN departments d ON e.department_id = d.id;
```
| employee_name | department_name |
| -------------- | ---------------- |
| Sagor          | HR               |
| Nodi           | Engineering      |
| Akash          | NULL             |
| Batas          | NULL             |
| NULL           | Marketing        |

---

## 10. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?
PostgreSQL-এ aggregate function ব্যবহার করে নির্দিষ্ট কলামের উপর ভিত্তি করে avarage , summation , count করে েএকটি  single value retrun করে ।
**Example:**
```sql
SELECT COUNT(*) FROM orders;
SELECT SUM(total_amount) FROM orders;
SELECT AVG(total_amount) FROM orders;
```
