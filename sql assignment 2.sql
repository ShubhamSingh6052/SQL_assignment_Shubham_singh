Create Schema employees_2;
Use employees_2;
CREATE TABLE Departments (
  Code INTEGER PRIMARY KEY,
  Name varchar(255) NOT NULL ,
  Budget decimal NOT NULL 
);
DROP TABLE Departments;
CREATE TABLE Employees (
  SSN INTEGER PRIMARY KEY,
  Name varchar(255) NOT NULL ,
  LastName varchar(255) NOT NULL ,
  Department INTEGER NOT NULL , 
  foreign key (department) references Departments(Code) 
);


INSERT INTO Departments(Code,Name,Budget) VALUES(14,'IT',65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,'Accounting',15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,'Human Resources',240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,'Research',55000);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('332569843','George','ODonnell',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('546523478','John','Doe',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('631231482','David','Smith',77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES('845657246','Kumar','Swamy',14);


-- 2.1 Select the last name of all employees.
Select LastName from Employees;

-- 2.2 Select the last name of all employees, without duplicates.
Select Distinct LastName from Employees;

-- 2.3 Select all the data of employees whose last name is "Smith".
Select * from Employees where LastName = "Smith";

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
Select * from Employees where LastName in ("Smith","Doe");

-- 2.5 Select all the data of employees that work in department 14.
Select * from Employees where Department = 14;

-- 2.6 Select all the data of employees that work in department 37 or department 77.
Select * from Employees where Department in (37,77);

-- 2.7 Select all the data of employees whose last name begins with an "S".
Select * from Employees where LastName like "S%";

-- 2.8 Select the sum of all the departments' budgets.
Select sum(budget) as Total_Budget from departments;

-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
Select Department as Department_Code, Count(*) as Number_of_Employees from Employees 
Group by department;

-- 2.10 Select all the data of employees, including each employee's department's data.
Select * from employees join departments on 
Employees.Department = Departments.Code;

-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
Select Employees.Name,employees.lastname,departments.name,departments.Budget from 
Employees join Departments on
Employees.Department = Departments.Code;

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
Select Employees.Name, Employees.LastName,departments.budget from Employees 
join Departments on Employees.Department = Departments.Code
and Budget > 60000; 

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
Select name, Budget from Departments where Budget > (select avg(Budget) from Departments);

-- 2.14 Select the names of departments with more than two employees.
Select Departments.Name as Department_Name from departments join Employees on 
Employees.Department = Departments.Code
Group by Departments.Name
Having count(Employees.Department) > 2;

-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.
 Select * from Employees where Department = (Select Departments.Code from (Select * from departments order by Budget limit 2) Departments order by Budget Desc Limit 1);

-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
Insert into Departments (Code,Name,Budget) Values (11,'Quality Assurance',40000);
Insert into Employees(SSN, Name, LastName, Department) Values(847219811,'Marry','More',11);

-- 2.17 Reduce the budget of all departments by 10%.
Select Code, Name, Budget, (Budget - (budget*0.1)) from Departments;

-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
Update Employees Set Department = 14 where Department = 77;

-- 2.19 Delete from the table all employees in the IT department (code 14).
Delete from Employees where department = 14;

-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
Delete from Employees where Department in (Select code from departments where budget >= 60000);

-- 2.21 Delete from the table all employees.
Delete from Employees;