DELIMITER $$
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

