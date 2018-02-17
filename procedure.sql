use testdb;

DELIMITER $$
CREATE PROCEDURE INSERT_HALL(
        IN  p_name varchar(200),
        IN  p_position varchar(200),
        IN  p_capacity INT 
     #   OUT valid INT
     )
BEGIN 
	DECLARE valid INT;
    IF(p_capacity >= 1) THEN
		INSERT INTO Hall(name,position,capacity) 
			VALUES ( p_name, p_position, p_capacity);
       SET valid = 1;
    ELSE
       SET valid = -1;
    END IF;
    SELECT valid;
END
$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE INSERT_SHOW(
        IN  p_name varchar(200),
        IN  p_category varchar(200),
        IN  p_price INT 
     #   OUT valid INT
     )
BEGIN 
	DECLARE valid INT;
    IF(p_price >= 0) THEN
		INSERT INTO Hall(name,category,price) 
			VALUES ( p_name, p_category, p_price);
       SET valid = 1;
    ELSE
       SET valid = -1;
    END IF;
    SELECT valid;
END
$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE INSERT_AUDIENCE(
        IN  p_name varchar(200),
        IN  p_gender varchar(200),
        IN  p_age INT 
     #   OUT valid INT
     )
BEGIN 
	DECLARE valid INT;
    IF(p_age >= 1)  and (p_gender in ('M','F')) THEN
		INSERT INTO Audience(name,gender,age) 
			VALUES ( p_name, p_gender, p_age);
       SET valid = 1;
    ELSE
       SET valid = -1;
    END IF;
    SELECT valid;
END
$$
DELIMITER ;
