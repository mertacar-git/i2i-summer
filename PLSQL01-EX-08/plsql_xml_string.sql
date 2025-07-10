
DECLARE
    input_str VARCHAR2(30) := 'abbcddfggfca'; -- Buraya istediğin stringi yazabilirsin
    len       PLS_INTEGER := LENGTH(input_str);
    valid     BOOLEAN := TRUE;
    i         PLS_INTEGER;
    j         PLS_INTEGER;
    ch        CHAR(1);
BEGIN
    -- Uzunluk kontrolü
    IF len > 30 THEN
        DBMS_OUTPUT.PUT_LINE('Error: String exceeds max length of 30.');
        valid := FALSE;
    END IF;

    -- Boşluk ve rakam kontrolü
    FOR i IN 1 .. len LOOP
        ch := SUBSTR(input_str, i, 1);
        IF ch = ' ' OR ch BETWEEN '0' AND '9' THEN
            DBMS_OUTPUT.PUT_LINE('Error: String contains space or numeric character.');
            valid := FALSE;
            EXIT;
        END IF;
    END LOOP;

    -- Karakter tekrar kontrolü
    FOR i IN 1 .. len-1 LOOP
        FOR j IN i+1 .. len LOOP
            IF SUBSTR(input_str, i, 1) = SUBSTR(input_str, j, 1) THEN
                DBMS_OUTPUT.PUT_LINE('Error: String contains duplicate characters.');
                valid := FALSE;
                EXIT;
            END IF;
        END LOOP;
        EXIT WHEN valid = FALSE;
    END LOOP;

    -- Eğer geçerliyse XML formatında çıktı ver
    IF valid THEN
        DBMS_OUTPUT.PUT_LINE('<string>');
        FOR i IN 1 .. len LOOP
            DBMS_OUTPUT.PUT_LINE('  <char>' || SUBSTR(input_str, i, 1) || '</char>');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('</string>');
    END IF;
END;
/
