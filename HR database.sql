#Welcome to my project, data and idea is based on Youtube tutorial from channel Her Data Project. 

CREATE DATABASE projects;
#Now I loaded my data from .csv file
USE project;


START TRANSACTION;

#Disable safe udpates to modify database
SET sql_safe_updates = 0;


#change column name to writable one
ALTER TABLE hr1
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

#Cleanup data format in birthdate column and convert it to date 
UPDATE hr1
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

#our cleanup generated trouble with dates, some birthdates beeing in future precisely
SELECT birthdate FROM hr1
ORDER BY birthdate desc;

#choose dates that are bigger than 2024, our database did not have dates before ~1960 so it guarantees, that I had chosen only proper ones, and then substracted 100 years from them
UPDATE hr1
SET birthdate = CASE
	WHEN YEAR(birthdate) > 2024 THEN DATE_SUB(birthdate, INTERVAL 100 YEAR)
    ELSE birthdate
END;

#Change data type to Date 
ALTER TABLE hr1
MODIFY COLUMN  birthdate DATE;
DESCRIBE hr1;


#Cleanup data format in hire_date column and convert it to proper date format
UPDATE hr1
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;



#Convert termination dates to proper format
UPDATE hr1 
SET termdate = date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
	WHERE termdate IS NOT NULL AND termdate != ' ';


#cleaning of termination dates
UPDATE hr1
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;
SET sql_mode = 'ALLOW_INVALID_DATES';
SELECT * FROM hr1;

#Change data type to Date 
ALTER TABLE hr1
MODIFY COLUMN  hire_date DATE;
DESCRIBE hr1;

#Change data type to Date 
ALTER TABLE hr1
MODIFY COLUMN termdate DATE;
DESCRIBE hr1;

#the 0000-00-00 format does not suit my needs, lets change it to null 
UPDATE hr1 
	SET termdate = IF(termdate = '0000-00-00', null, termdate)
    WHERE true;

#lets add column with calculated age, based on birthdate of our emplyees
ALTER TABLE hr1 ADD COLUMN age INT;
UPDATE hr1
SET age = timestampdiff(YEAR, birthdate, CURDATE());

#my data is cleaned, now we can analyze it in PowerBi :)


ROLLBACK;

COMMIT;