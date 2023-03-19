-- Data Management Systems assignment Part B, Manash Bhele

CREATE TABLE Department(
	deptId VARCHAR(30) NOT NULL PRIMARY KEY,
	name VARCHAR(60));
    

CREATE TABLE SalaryGrade (
	salaryCode VARCHAR(30) NOT NULL PRIMARY KEY, 
	startSalary INT, 
	finishSalary INT);

CREATE TABLE PensionScheme (
	schemeId VARCHAR(30) NOT NULL PRIMARY KEY,
	name VARCHAR(60),
	rate FLOAT);
    
CREATE TABLE Employee (
	empId VARCHAR(30)  NOT NULL PRIMARY KEY, 
	name VARCHAR(60), 
	address VARCHAR(60), 
	DOB DATE, 
	job VARCHAR(60), 
	salaryCode VARCHAR(30), 
    FOREIGN KEY (salaryCode) REFERENCES SalaryGrade(salaryCode),
	deptId VARCHAR(30) NOT NULL,
	FOREIGN KEY (deptId) REFERENCES DEPARTMENT(deptId),
	manager VARCHAR(30), 
	schemeId VARCHAR(30) NOT NULL,
	FOREIGN KEY (schemeId) REFERENCES PensionScheme(schemeId));
    
INSERT ALL
    INTO Department (deptId, name) VALUES ('D10',	'Administration')
	INTO Department (deptId, name) VALUES ('D20', 'Finance')
	INTO Department (deptId, name) VALUES ('D30', 'Sales')
	INTO Department (deptId, name) VALUES ('D40', 'Maintenance')
	INTO Department (deptId, name) VALUES ('D50', 'IT Support')
SELECT 1 FROM dual;

SELECT * FROM department;

INSERT ALL
    INTO SalaryGrade (salaryCode, startSalary, finishSalary) VALUES ('S1',	15000,	18000)
	INTO SalaryGrade (salaryCode, startSalary, finishSalary) VALUES ('S2',	18001,	22000)
	INTO SalaryGrade (salaryCode, startSalary, finishSalary) VALUES ('S3',	22001,	25000)
    INTO SalaryGrade (salaryCode, startSalary, finishSalary) VALUES	('S4',	25001,	29000)
	INTO SalaryGrade (salaryCode, startSalary, finishSalary) VALUES ('S5',	29001,	38000)
SELECT 1 FROM dual;

INSERT ALL
    INTO PensionScheme (SchemeID, Name, rate) VALUES ('S110', 'AXA', 0.5)
	INTO PensionScheme (SchemeID, Name, rate) VALUES ('S121', 'Premier', 0.6)
	INTO PensionScheme (SchemeID, Name, rate) VALUES ('S124', 'Stakeholder', 0.4)
	INTO PensionScheme (SchemeID, Name, rate) VALUES ('S116', 'Standard', 0.4)
SELECT 1 FROM dual;

INSERT ALL
    INTO employee (EmpID, Name, Address, DOB, Job, SalaryCode, DeptID, Manager, SchemeID) 
    VALUES ('E101', 'Young, S.', '199 London Road', 
            to_date('05/03/76', 'dd-mm-rr'), 'Clerk', 'S1', 'D10', 'E110', 'S116')
    INTO employee (EmpID, Name, Address, DOB, Job, SalaryCode, DeptID, Manager, SchemeID) 
    VALUES('E301', 'April, H.', '20 Glade close', 
            to_date('10/03/79', 'dd-mm-rr'), 'Sales Person', 'S2', 'D30', 'E310', 'S124')
    INTO employee (EmpID, Name, Address, DOB, Job, SalaryCode, DeptID, Manager, SchemeID) 
    VALUES('E310', 'Newgate, E.', '10 Heap Street', 
            to_date('28/11/80', 'dd-mm-rr'), 'Manager', 'S5', 'D30', NULL, 'S121')
    INTO employee (EmpID, Name, Address, DOB, Job, SalaryCode, DeptID, Manager, SchemeID) 
    VALUES('E501', 'Teach, E.', '22 railway road', 
            to_date('12/02/72', 'dd-mm-rr'), 'Analyst', 'S5', 'D50', NULL, 'S121')
    INTO employee (EmpID, Name, Address, DOB, Job, SalaryCode, DeptID, Manager, SchemeID) 
    VALUES('E102', 'Hawkins, M.', '3 High Street', 
            to_date('13/07/74', 'dd-mm-rr'), 'Clerk', 'S1', 'D10', 'E110', 'S116')
    INTO employee (EmpID, Name, Address, DOB, Job, SalaryCode, DeptID, Manager, SchemeID) 
    VALUES('E110', 'Watkins, J.', '11 crescent road', 
            to_date('25/06/69', 'dd-mm-rr'), 'Manager', 'S5', 'D10', NULL, 'S121')
SELECT 1 FROM dual;

SELECT * FROM employee;
SELECT * FROM salarygrade;

--The name (in ascending order), the starting salary and department id of each employee within a descending order of department ids. 

SELECT name, sg.startsalary, deptid
FROM employee e JOIN salarygrade sg ON e.salarycode = sg.salarycode
ORDER BY deptid DESC, name ASC;

-- b)	Give the number of employees for each of the pension schemes offered by the company. 
-- Result listing should include the name of each scheme and its corresponding number of employees who join the scheme. (5%)
--SELECT * FROM employee e RIGHT JOIN pensionscheme pc ON e.schemeid = pc.schemeid;

SELECT ps.name, COUNT(e.schemeid) as no_of_employees
FROM employee e RIGHT JOIN pensionscheme ps ON e.schemeid = ps.schemeid
GROUP BY ps.name;

-- c)Give the total number of employees who are not managers but currently receive an annual salary of over £35,000. (5%)
SELECT * FROM salarygrade;
SELECT * FROM employee;
SELECT * from department;
SELECT * FROM pensionscheme;

SELECT empid, NVL(manager, 'no manager') FROM employee;

SELECT COUNT(e.empid) "Number of Employees"
FROM employee e JOIN SalaryGrade sg on e.salarycode = sg.salarycode
WHERE e.job != 'Manager' AND sg.finishsalary > 35000;


-- d)	List the id and name of each employee along with his/her manager’s name. 
SELECT e1.empid, e1.name, e2.name as manager_name
FROM employee e1 LEFT JOIN employee e2 ON e1.manager = e2.empid;



-- getting rid of (null) in output
SELECT e1.empid, e1.name, NVL(e2.name, 'No Manager') as manager_name
FROM employee e1 LEFT JOIN employee e2 ON e1.manager = e2.empid;








