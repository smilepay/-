create or replace function compareDay(
  teachDay IN NUMBER,
  insertDay IN NUMBER)
  RETURN number
  IS
  teach_firstNum NUMBER;
  teach_secondNum NUMBER;
  insert_firstNum NUMBER;
  insert_secondNum NUMBER;
  conflict_checker NUMBER;
BEGIN
  teach_firstNum := 6;
  teach_secondNum := 7;
  insert_firstNum := 8;
  insert_secondNum := 9;
  conflict_checker := 0;
  
  IF (teachDay < 10) THEN
	teach_secondNum := teachDay;
  ELSIF (teachDay >= 10) THEN
	teach_firstNum := SUBSTR(TO_CHAR(teachDay), 1, 1);
	teach_secondNum := SUBSTR(TO_CHAR(teachDay), 2, 1);
  END IF;
  
  insert_firstNum := SUBSTR(TO_CHAR(insertDay), 1, 1);
  insert_secondNum := SUBSTR(TO_CHAR(insertDay), 2, 1);
  
  IF ((teach_firstNum = insert_firstNum) or (teach_firstNum = insert_secondNum) or (teach_secondNum = insert_firstNum) or (teach_secondNum = insert_secondNum)) THEN
	conflict_checker := 1;
  END IF;

  RETURN conflict_checker;
END;
/
