USE testdb;	

DROP PROCEDURE IF EXISTS INSERT_BUILDING;
DELIMITER $$
CREATE PROCEDURE INSERT_BUILDING(
        IN  p_name varchar(200),
        IN  p_location varchar(200),
        IN  p_capacity INT
     )
BEGIN 
	DECLARE valid bool;
    IF(p_capacity >= 1) THEN
		INSERT INTO Building (name,location,capacity) 
			VALUES ( p_name, p_location, p_capacity);
       SET valid = true;
    ELSE
       SET valid = false;
    END IF;
	SELECT valid;
END
$$
DELIMITER ;


DROP PROCEDURE IF EXISTS INSERT_AUDIENCE;
DELIMITER $$
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


DROP PROCEDURE IF EXISTS INSERT_PERFORMANCE;
DELIMITER $$
CREATE PROCEDURE INSERT_PERFORMANCE(
        IN  p_name varchar(200),
        IN  p_type varchar(200),
        IN  p_price INT
     )
BEGIN 
	DECLARE valid bool;
    IF (p_price >= 0) THEN
		INSERT INTO Performance (name,type,price) 
			VALUES ( p_name, p_type, p_price);
       SET valid = true;
    ELSE
       SET valid = false;
    END IF;
	SELECT valid;
END
$$
DELIMITER ;


DROP PROCEDURE IF EXISTS ASSIGN_PERFORMANCE;
DELIMITER $$
CREATE PROCEDURE ASSIGN_PERFORMANCE(
        IN  p_bid INT,
        IN  p_pid INT
        )
BEGIN 
	DECLARE p_cap INT;
    DECLARE valid bool;
    DECLARE i INT DEFAULT 1;
    
    SET p_cap = (SELECT capacity FROM Building WHERE idHall = p_bid);
    IF p_cap is NOT NULL THEN

		WHILE i <= p_cap DO
			INSERT INTO BookStatus(id_hall,id_show,seat_id) values (p_bid,p_pid,i);
			SET i = i + 1;
		END WHILE;
		SET valid = true;
    ELSE
		SET valid = false;
    END IF;
	SELECT valid;
END
$$
DELIMITER ;


DROP PROCEDURE IF EXISTS ASSIGN_BOOK;
DELIMITER $$
CREATE PROCEDURE ASSIGN_BOOK(
        IN  p_pid INT,
        IN  p_aid INT,
        IN p_sid INT
        )
BEGIN
	DECLARE valid bool;
	IF p_pid in (SELECT distinct idHall FROM Building) and p_aid in (SELECT distinct idAudience FROM Audience) then
    
		UPDATE BookStatus SET id_audience=p_aid
        WHERE p_pid=id_hall and seat_id = p_sid ;
    
		SET valid = true;
    ELSE
		SET valid = false;
    END IF;
	SELECT valid;
END
$$
DELIMITER ;


DROP PROCEDURE IF EXISTS PRINT_BUILDING;
DELIMITER $$    
CREATE PROCEDURE PRINT_BUILDING()
BEGIN

SELECT B.*, 
	CASE WHEN T.assigned is NULL then 0
    ELSE T.assigned END as assigned FROM Building B LEFT OUTER JOIN 
	(SELECT id_hall,count(*) as assigned FROM BookStatus GROUP BY id_hall) T on B.idHall= T.id_hall ;
END
$$
DELIMITER ;

    
DROP PROCEDURE IF EXISTS PRINT_PERFORMANCE;
DELIMITER $$    
CREATE PROCEDURE PRINT_PERFORMANCE()
BEGIN
SELECT P.*,
	CASE WHEN T.booked is NULL then 0
    ELSE T.booked END as booked
	FROM Performance P LEFT OUTER JOIN 
		(SELECT id_show,count(id_audience) as booked FROM BookStatus GROUP BY id_show) T on P.idShow = T.id_show;
        
END
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS PRINT_AUDIENCE;
DELIMITER $$
CREATE procedure PRINT_AUDIENCE()
BEGIN
SELECT * FROM Audience;
END
$$
DELIMITER ;



DROP PROCEDURE IF EXISTS PRINT_PERFORMANCE_WITH_BID;
DELIMITER $$
CREATE procedure PRINT_PERFORMANCE_WITH_BID
	(IN p_idhall INT)
BEGIN
SELECT P.*,
	CASE WHEN T.booked is NULL then 0
    ELSE T.booked END as booked
	FROM Performance P JOIN 
		(SELECT id_show,count(id_audience) as booked FROM BookStatus WHERE id_hall=p_idhall GROUP BY id_show) T on P.idShow = T.id_show;
END
$$
DELIMITER ;


DROP PROCEDURE IF EXISTS PRINT_AUDIENCE_WITH_PID;
DELIMITER $$
CREATE procedure PRINT_AUDIENCE_WITH_PID
	(IN p_idshow INT)
BEGIN
	SELECT DISTINCT A.* FROM Audience A JOIN BookStatus B on B.id_show = p_idshow and A.idAudience=B.id_audience;
END
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS PRINT_BOOKING_WITH_PID;
DELIMITER $$
CREATE procedure PRINT_BOOKING_WITH_PID
	(IN p_idshow INT)
BEGIN
	SELECT seat_id, CASE 
		WHEN id_audience is NULL THEN ''
        ELSE id_audience
        END as audience_id
        FROM BookStatus WHERE id_show = p_idshow;
END
$$
DELIMITER ;
