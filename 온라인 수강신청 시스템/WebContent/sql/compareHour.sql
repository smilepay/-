﻿create or replace function compareHour(
 teach_sHour IN NUMBER,
 teach_eHour IN NUMBER,
 insert_sHour IN NUMBER,
 insert_eHour IN NUMBER)
 RETURN NUMBER
IS
 conflict_checker NUMBER;
BEGIN
 conflict_checker := 0;

IF (insert_sHour >= teach_sHour and insert_sHour <= teach_eHour) THEN
  conflict_checker := conflict_checker + 1;
ELSIF (insert_eHour >= teach_sHour and insert_eHour <= teach_eHour) THEN
 conflict_checker := conflict_checker + 1;
ELSIF (insert_sHour <= teach_sHour and insert_eHour >= teach_eHour) THEN
 conflict_checker := conflict_checker + 1;
END IF;

RETURN conflict_checker;
END;
/

