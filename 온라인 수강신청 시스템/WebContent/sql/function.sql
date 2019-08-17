CREATE OR REPLACE FUNCTION DateForEnrollYear(dDate IN DATE)
RETURN NUMBER
IS
return_year NUMBER;
mon NUMBER;
BEGIN
return_year := TO_NUMBER(TO_CHAR(dDate, 'YYYY'));
mon := TO_NUMBER(TO_CHAR(dDate, 'MM'));
IF (mon >= 1 AND mon <= 10) THEN RETURN return_year;
ELSE RETURN return_year+1;
END IF;
END;
/

CREATE OR REPLACE FUNCTION DateForEnrollSemester(dDate IN DATE)
RETURN NUMBER
IS
return_sem NUMBER;
mon NUMBER;
BEGIN
mon := TO_NUMBER(TO_CHAR(dDate, 'MM'));
IF (mon >= 5 AND mon <= 10) THEN return_sem := 2;
ELSE return_sem := 1;
END IF;
RETURN return_sem;
END;
/