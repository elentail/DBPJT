DELIMITER $$
DROP PROCEDURE IF EXISTS INSERT_BUILDING;
CREATE PROCEDURE INSERT_BUILDING(
        IN  p_name varchar(200),
        IN  p_position varchar(200),
        IN  p_capacity INT
     )
BEGIN 
	DECLARE valid bool;
    IF(p_capacity >= 1) THEN
		INSERT INTO Building (name,position,capacity) 
			VALUES ( p_name, p_position, p_capacity);
       SET valid = true;
    ELSE
       SET valid = false;
    END IF;
	SELECT valid;
END
$$
DELIMITER ;


DELIMITER $$
DROP PROCEDURE IF EXISTS INSERT_AUDIENCE;
CREATE PROCEDURE INSERT_AUDIENCE(
        IN  p_name varchar(200),
        IN  p_gender char(1),
        IN  p_age INT
     )
BEGIN 
	DECLARE valid bool;
    IF (p_age >= 1) and (p_gender in ('M','F')) THEN
		INSERT INTO Audience (name,gender,age) 
			VALUES ( p_name, p_gender, p_age);
       SET valid = true;
    ELSE
       SET valid = false;
    END IF;
	SELECT valid;
END
$$
DELIMITER ;


DELIMITER $$
DROP PROCEDURE IF EXISTS INSERT_PERFORMANCE;
CREATE PROCEDURE INSERT_PERFORMANCE(
        IN  p_name varchar(200),
        IN  p_category varchar(200),
        IN  p_price INT
     )
BEGIN 
	DECLARE valid bool;
    IF (p_price >= 0) THEN
		INSERT INTO Performance (name,category,price) 
			VALUES ( p_name, p_category, p_price);
       SET valid = true;
    ELSE
       SET valid = false;
    END IF;
	SELECT valid;
END
$$
DELIMITER ;

