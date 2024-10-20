-- Enabling Server Output to diplay output
SET SERVEROUTPUT ON;

-- Dropping table if exists - mainly for my testing (data duplication issue)
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE person';
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -942 THEN  -- ORA-00942: table or view does not exist
      RAISE;
    END IF;
END;
/

-- Creating table
CREATE TABLE person (id INTEGER, name VARCHAR2(20));

INSERT INTO person VALUES (1, 'Alice');
INSERT INTO person VALUES (2, 'Bob');
INSERT INTO person VALUES (3, 'Charlie');
INSERT INTO person VALUES (4, 'David');

COMMIT;

-- Task 1
DECLARE
    v_num INTEGER := &input_num; 
    v_is_prime BOOLEAN := TRUE; -- Number is prime
    i INTEGER;
BEGIN
    -- Case where the input is less than 2
    IF v_num < 2 THEN
        v_is_prime := FALSE;
    ELSE
        FOR i IN 2 .. v_num - 1 LOOP
            IF MOD(v_num, i) = 0 THEN
                v_is_prime := FALSE;
                EXIT; 
            END IF;
        END LOOP;
    END IF;

    -- Number is prime or not
    IF v_is_prime THEN
        DBMS_OUTPUT.PUT_LINE(v_num || ' is Prime');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_num || ' is Non-prime');
    END IF;
END;
/

-- Task 2
DECLARE
    FUNCTION is_prime(p_num INTEGER) RETURN BOOLEAN IS
        i INTEGER;
    BEGIN
        IF p_num < 2 THEN
            RETURN FALSE;
        END IF;
        FOR i IN 2 .. p_num - 1 LOOP
            IF MOD(p_num, i) = 0 THEN
                RETURN FALSE;
            END IF;
        END LOOP;
        RETURN TRUE;
    END is_prime;
BEGIN
    -- Loop through numbers 1 to 100 and print if prime
    FOR v_num IN 1 .. 100 LOOP
        IF is_prime(v_num) THEN
            DBMS_OUTPUT.PUT_LINE(v_num || ' is Prime');
        END IF;
    END LOOP;
END;
/

-- Task 3
DECLARE
    CURSOR c_person IS
        SELECT name FROM person;
    v_name VARCHAR2(20);
BEGIN
    OPEN c_person;
    LOOP
        FETCH c_person INTO v_name;
        EXIT WHEN c_person%NOTFOUND;
        
        -- Is length of the name greater than 3?
        IF LENGTH(v_name) > 3 THEN
            DBMS_OUTPUT.PUT_LINE(v_name);
        END IF;
    END LOOP;
    CLOSE c_person;
END;
/

-- Task 4
DECLARE
    CURSOR c_person IS
        SELECT name FROM person;
    v_json VARCHAR2(500) := '{"myFavoritePeople": [';
    v_name VARCHAR2(20);
    v_first BOOLEAN := TRUE; -- Manage commas
BEGIN
    OPEN c_person;
    LOOP
        FETCH c_person INTO v_name;
        EXIT WHEN c_person%NOTFOUND;
        
        -- Comma before names
        IF v_first THEN
            v_json := v_json || '"' || v_name || '"';
            v_first := FALSE;
        ELSE
            v_json := v_json || ', "' || v_name || '"';
        END IF;
    END LOOP;
    CLOSE c_person;
    
    -- Final JSON string
    v_json := v_json || ']}';
    DBMS_OUTPUT.PUT_LINE(v_json);
END;
/

-- BONUS
-- Ahhh how do I do this???!!!
