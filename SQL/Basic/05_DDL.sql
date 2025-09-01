-- DDL (DATA DEFINTION LANGUAGE)

-- CREATE

CREATE TABLE persons(
	id int NOT NULL,
-- column_name, data_type, contraint
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone_number VARCHAR(50) NOT NULL,
	user_id int NOT NULL,
	address_id int NOT NULL,
	CONSTRAINT pk_persons PRIMARY KEY (id),
	CONSTRAINT fk_persons FOREIGN KEY(user_id) REFERENCES USERS(id), -- Setting the foreign KEY
	CONSTRAINT fk_persons FOREIGN KEY (address_id) REFERENCES ADDRESS(id)
)

-- ALTER

ALTER TABLE persons 
ADD email varchar(50)

-- MODIFY
ALTER TABLE persons
MODIFY phone_number VARCHAR(100) NULL

ALTER TABLE persons
DROP column email

-- DROP

DROP TABLE persons