CREATE DATABASE MyJoinsDBI;

USE MyJoinsDBI;

CREATE TABLE employee(
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(20) NOT NULL,
phone VARCHAR(15) NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE employee_position(
employee_id INT NOT NULL,
employee_post VARCHAR(30) NOT NULL,
salary DOUBLE NOT NULL,
PRIMARY KEY(employee_id),
FOREIGN KEY (employee_id) REFERENCES employee(id) 
);

CREATE TABLE personal_data(
employee_id INT NOT NULL,
marital_status VARCHAR(20) NOT NULL,
birthday DATE NOT NULL,
adress VARCHAR(30) NOT NULL,
PRIMARY KEY(employee_id),
FOREIGN KEY (employee_id) REFERENCES employee(id) 
);
---------------------------------------------------------
INSERT INTO employee
(name, phone)
VALUES
('Bob','+380985456325'),
('Alan','+380965789652'),
('Mary','+380991111111');

INSERT INTO employee_position
(employee_id, employee_post, salary)
VALUES
(1, 'Director', 100000),
(2, 'Manager', 50000),
(3, 'Worker', 25000);

INSERT INTO personal_data
(employee_id, marital_status, birthday, adress)
VALUES
(1, 'married', '1993-10-08','Kyiv, Sacsaganskogo 9'),
(2, 'not married', '1992-09-09','Kyiv, Korolova 20'),
(3, 'married', '1991-12-10','Kyiv, Korolova 25');

---------------------------------------------------------
-- Homework6

/* Rationale for creating indexes: created to improve data search performance
of data search.
Acceleration of work using indexes is achieved primarily due to the fact that
the index has a search-optimized structure, such as a balanced tree. */

CREATE INDEX phone
ON employee(phone);

CREATE INDEX employee_post 
ON employee_position(employee_post);

CREATE INDEX birthday
ON personal_data(birthday);

SELECT * FROM employee
WHERE employee.phone = '+380991111111';

SELECT * FROM employee_position
WHERE employee_position.employee_post = 'Worker';

SELECT * FROM personal_data
WHERE personal_data.birthday = '1991-12-10';

---------------------------------------------------------

CREATE VIEW info_phone_address
AS SELECT employee.name, employee.phone, personal_data.adress
FROM employee
JOIN personal_data
ON employee.id = personal_data.employee_id;

CREATE VIEW info_not_married
AS SELECT employee.name, personal_data.birthday, employee.phone
FROM employee
JOIN personal_data
ON employee.id = personal_data.employee_id
WHERE personal_data.marital_status = 'not married';

CREATE VIEW info_managers
AS SELECT employee.name, personal_data.birthday, employee.phone
FROM employee
JOIN personal_data
ON employee.id = personal_data.employee_id
JOIN employee_position
ON employee.id = employee_position.employee_id
WHERE employee_position.employee_post = 'Manager';

SELECT * FROM info_phone_address;
SELECT * FROM info_not_married;
SELECT * FROM info_managers;