-- DDL (DATA DEFINTION LANGUAGE)

-- CREATE

CREATE TABLE persons(
	id int NOT NULL,
-- column_name, data_type, contraint
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone_number VARCHAR(50) NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY (id)
)

-- ALTER

ALTER TABLE persons 
ADD email varchar(50)

ALTER TABLE persons
DROP column email

-- DROP

DROP TABLE persons