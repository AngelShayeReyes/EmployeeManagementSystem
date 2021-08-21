-- Delete tables
DROP TABLE Employee;
DROP TABLE SalesEmployee;
DROP TABLE EmployeeLogin;
DROP TABLE EmployeeProject;
DROP TABLE Project;
DROP TABLE TechnicalEmployee;

-- Create tables
CREATE TABLE Employee (
    employee_id smallint PRIMARY KEY AUTO_INCREMENT,
    employee_name varchar(100) NOT NULL,
    ni_number varchar(13) NOT NULL,
    employee_address varchar(400) NOT NULL,
    employee_postcode varchar(10) NOT NULL,
    salary decimal(12,2) NOT NULL,
    account_num varchar(8) NOT NULL,
    sort_code varchar(8) NOT NULL,
    is_manager boolean NOT NULL DEFAULT 0,
    active boolean NOT NULL DEFAULT 0,
    employee_type enum('HR', 'Sales', 'Finance', 'BU', 'Technical') not null
);

CREATE TABLE SalesEmployee (
    employee_id smallint NOT NULL,
    commission_rate decimal(3,2) NOT NULL default 0.00, CHECK(commission_rate <= 100),
    total_sales mediumint NOT NULL default 0,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE TechnicalEmployee (
    employee_id smallint NOT NULL,
    photo varchar(100),
    cv varchar(100),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE EmployeeLogin (
    employee_id smallint NOT NULL,
    username varchar(100),
    password varchar(100),
    FOREIGN KEY(employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Project (
    project_id smallint PRIMARY KEY AUTO_INCREMENT,
    active boolean DEFAULT 0,
    project_name varchar(100) NOT NULL
);

CREATE TABLE EmployeeProject (
    assignment_id smallint PRIMARY KEY AUTO_INCREMENT,
    employee_id smallint NOT NULL,
    project_id smallint NOT NULL,
    starting_date datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ending_date datetime DEFAULT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (project_id) REFERENCES Project(project_id)
);


-- Employee Table Population
INSERT INTO Employee (employee_name, ni_number, employee_address, employee_postcode, salary, account_num, sort_code, is_manager, active, employee_type)
    VALUES('Sameer Maekawa', 'JO 23 62 63 A', '36 Don Jackson Lane', 'SY7 8EB', 53000.00, '01234167', '13-62-78', true, true, 'HR');
INSERT INTO Employee (employee_name, ni_number, employee_address, employee_postcode, salary, account_num, sort_code, is_manager, active, employee_type)
    VALUES('Daniel Elliot', 'BA 46 45 21 G', '49 Duck Creek Road', 'IV32 7HJ', 53000.00, '13534623', '24-53-48', 1, 1, 'Sales');
INSERT INTO Employee (employee_name, ni_number, employee_address, employee_postcode, salary, account_num, sort_code, is_manager, active, employee_type)
    VALUES('Alya Saab', 'AC 23 45 89 E', '268 Golden Street', 'TD4 6AF', 33000.00, '43753462', '67-24-94', 0, 1, 'Sales');
INSERT INTO Employee (employee_name, ni_number, employee_address, employee_postcode, salary, account_num, sort_code, is_manager, active, employee_type)
    VALUES('Nejla Wilkins', 'SE 23 45 32 H', '74 Yellow Lane', 'BN2 4BU', 26000.00, '67888432', '23-80-23', 0, 1, 'Sales');
INSERT INTO Employee (employee_name, ni_number, employee_address, employee_postcode, salary, account_num, sort_code, is_manager, active, employee_type)
    VALUES('Arnaldo Senft', 'EA 79 45 21 W', '76 Edgewood Avenue', 'HD7 6AZ', 57000.00, '57883213', '73-32-44', 1, 1, 'Technical');
INSERT INTO Employee (employee_name, ni_number, employee_address, employee_postcode, salary, account_num, sort_code, is_manager, active, employee_type)
    VALUES('Reagan Snijders', 'TL 23 72 73 U', '98 Layman Avenue', 'CH31 9GB', 39000.00, '5783478', '93-63-66', 0, 1, 'Finance');
INSERT INTO Employee (employee_name, ni_number, employee_address, employee_postcode, salary, account_num, sort_code, is_manager, active, employee_type)
    VALUES('Annie Tan', 'PO 23 45 82 E', '116 Randall Drive', 'A3 5DE', 62000.00, '12378312', '26-46-78', 1, 1, 'Finance');
INSERT INTO Employee (employee_name, ni_number, employee_address, employee_postcode, salary, account_num, sort_code, is_manager, active, employee_type)
    VALUES('Athene Boyanov', 'KE 58 57 83 B', '26 Daffodil Lane', 'SA32 7JQ', 29000.00, '90733467', '83-72-24', 0, 1, 'Technical');
INSERT INTO Employee (employee_name, ni_number, employee_address, employee_postcode, salary, account_num, sort_code, is_manager, active, employee_type)
    VALUES('Kristian Messner', 'RE 21 34 80 W', '10 Calico Drive', 'SR1 3QD', 55000.00, '68321157', '48-64-67', 1, 1, 'BU');
INSERT INTO Employee (employee_name, ni_number, employee_address, employee_postcode, salary, account_num, sort_code, is_manager, active, employee_type)
    VALUES('Kora Lim', 'QA 31 63 79 T', '37 Pine Street', 'YO12 6RH', 23000.00, '36883368', '93-67-42', 0, 0, 'HR');

UPDATE Employee SET is_manager = '0' where employee_id = 15;
UPDATE Employee SET is_manager = '0' where employee_id = 11;


UPDATE Employee SET sort_code = '13-62-78' where employee_id = 1;

SELECT employee_name AS Name,
        ni_number AS 'NI Number',
        employee_address AS Address,
        salary AS Salary,
        concat(account_num,', ',sort_code) AS 'Bank Details'
        is_manager AS Manager,
        active AS Active,
        employee_type AS Department
    FROM Employee;


-- Employee Login Table Population
INSERT INTO EmployeeLogin (employee_id, username, password) VALUES (1, 'Sameer', 'TempPassword**');
INSERT INTO EmployeeLogin (employee_id, username, password) VALUES (2, 'Daniel', 'TempPassword**');
INSERT INTO EmployeeLogin (employee_id, username, password) VALUES (3, 'Alya', 'TempPassword**');
INSERT INTO EmployeeLogin (employee_id, username, password) VALUES (4, 'Nejla', 'TempPassword**');
INSERT INTO EmployeeLogin (employee_id, username, password) VALUES (5, 'Arnaldo', 'TempPassword**');
INSERT INTO EmployeeLogin (employee_id, username, password) VALUES (6, 'Reagan', 'TempPassword**');
INSERT INTO EmployeeLogin (employee_id, username, password) VALUES (7, 'Annie', 'TempPassword**');
INSERT INTO EmployeeLogin (employee_id, username, password) VALUES (8, 'Athene', 'TempPassword**');
INSERT INTO EmployeeLogin (employee_id, username, password) VALUES (9, 'Kristian', 'TempPassword**');
INSERT INTO EmployeeLogin (employee_id, username, password) VALUES (10, 'Kora', 'TempPassword**');

SELECT Employee.employee_name AS Name,
        username AS Username,
        password AS Password
       FROM EmployeeLogin JOIN Employee
       USING(employee_id);


-- Technical Employee Table Population
INSERT INTO TechnicalEmployee (employee_id, photo, cv) VALUES (1, 'link', 'link');
INSERT INTO TechnicalEmployee (employee_id, photo, cv) VALUES (2, 'link', 'link');
INSERT INTO TechnicalEmployee (employee_id, photo, cv) VALUES (3, 'link', 'link');
INSERT INTO TechnicalEmployee (employee_id, photo, cv) VALUES (4, 'link', 'link');
INSERT INTO TechnicalEmployee (employee_id, photo, cv) VALUES (5, 'link', 'link');
INSERT INTO TechnicalEmployee (employee_id, photo, cv) VALUES (6, 'link', 'link');
INSERT INTO TechnicalEmployee (employee_id, photo, cv) VALUES (7, 'link', 'link');
INSERT INTO TechnicalEmployee (employee_id, photo, cv) VALUES (8, 'link', 'link');
INSERT INTO TechnicalEmployee (employee_id, photo, cv) VALUES (9, 'link', 'link');
INSERT INTO TechnicalEmployee (employee_id, photo, cv) VALUES (10, 'link', 'link');

SELECT Employee.employee_name AS Name,
        photo AS Photo,
        cv AS CV
       FROM TechnicalEmployee JOIN Employee
       USING(employee_id);


-- Sales Employee Table Population
INSERT INTO SalesEmployee (employee_id, commission_rate, total_sales) VALUES (2, 2.3, 2500);
INSERT INTO SalesEmployee (employee_id, commission_rate, total_sales) VALUES (3, 1.2, 3000);
INSERT INTO SalesEmployee (employee_id, commission_rate, total_sales) VALUES (4, 1.2, 2000);

SELECT * FROM Employee where employee_type="Sales";

SELECT Employee.employee_name AS Name,
        commission_rate AS 'Commission Rate',
        total_sales AS 'Total Sales'
       FROM SalesEmployee JOIN Employee
       USING(employee_id);


-- Project Table Population
INSERT INTO Project (active, project_name) VALUES (true, 'Alpha');
INSERT INTO Project (active, project_name) VALUES (true, 'Beta');

UPDATE Project SET active = 0 where project_id = 2;

SELECT project_name AS 'Project Name',
        active AS Active
    FROM Project;


-- Employee-Project Table Population
INSERT INTO EmployeeProject (employee_id, project_id) VALUES (5, 1);
INSERT INTO EmployeeProject (employee_id, project_id) VALUES (8, 1);

SELECT Employee.employee_name AS "Employee Name" ,
        Project.project_name AS "Project Name"
    FROM Employee
    INNER JOIN EmployeeProject ON EmployeeProject.employee_id = Employee.employee_id
    INNER JOIN Project ON EmployeeProject.project_id = Project.project_id;
UPDATE EmployeeProject SET project_id = '' where employee_id = 1; !UNSURE!


-- View all tables
SELECT employee_name AS Name, ni_number AS 'NI Number', employee_address AS Address, salary AS Salary, concat(account_num,', ',sort_code) AS 'Bank Details', is_manager AS Manager, active AS Active, employee_type AS Department FROM Employee;
SELECT Employee.employee_name AS Name, username AS Username,password AS Password FROM EmployeeLogin JOIN Employee USING(employee_id);
SELECT Employee.employee_name AS Name,photo AS Photo,cv AS CV FROM TechnicalEmployee JOIN Employee USING(employee_id);
SELECT Employee.employee_name AS Name,commission_rate AS 'Commission Rate',total_sales AS 'Total Sales' FROM SalesEmployee JOIN Employee USING(employee_id);
SELECT project_name AS 'Project Name', active AS Active FROM Project;
SELECT Employee.employee_name AS "Employee Name", Project.project_name AS "Project Name" FROM Employee INNER JOIN EmployeeProject ON EmployeeProject.employee_id = Employee.employee_id INNER JOIN Project ON EmployeeProject.project_id = Project.project_id;


-- Table Manipulation
SELECT * FROM Employee ORDER BY employee_type;
SELECT * FROM Employee WHERE (active=false and employee_type='Technical');
SELECT Employee.employee_name AS Name, MAX(total_sales) AS 'Highest Sales' FROM SalesEmployee JOIN Employee USING(employee_id);