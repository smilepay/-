create or replace function getNumberHour(
  startHour IN VARCHAR2,
  startMinute IN VARCHAR2,
  endHour IN VARCHAR2,
  endMinute IN VARCHAR2)
  RETURN NUMBER
  IS
  nStartHour NUMBER;
  nStartMinute NUMBER;
  nEndHour NUMBER;
  nEndMinute NUMBER;
  teachHour NUMBER;
BEGIN
  nStartHour := TO_NUMBER(startHour);
  nStartMinute := TO_NUMBER(startMinute);
  nEndHour := TO_NUMBER(endHour);
  nEndMinute := TO_NUMBER(endMinute);

  /* teachHour NUMBER(2) code */
  /* (1) 9:00 ~ 10:15, (2) 10:30 ~ 11:45, (3) 12:00 ~ 13:15, (4) 13:30 ~ 14:45, (5) 15:00 ~ 16:15 */
  /* (6) 16:30 ~ 17:45, (7) 8:30 ~ 10:20, (8) 10:00 ~ 11:50, (9) 11:00 ~ 12:50, (10) 12:00 ~ 14:50 */
  /* (11) 15:00 ~ 16:50, (12) 17:00 ~ 18:50 , (13) 17:00 ~ 19:50 */
  
  IF (nStartHour = 9 and nStartMinute = 0 and nEndHour = 10 and nEndMinute = 15) THEN
    teachHour := 1;
  ELSIF (nStartHour = 10 and nStartMinute = 30 and nEndHour = 11 and nEndMinute = 45) THEN
    teachHour := 2;
  ELSIF (nStartHour = 12 and nStartMinute = 0 and nEndHour = 13 and nEndMinute = 15) THEN
    teachHour := 3;
  ELSIF (nStartHour = 13 and nStartMinute = 30 and nEndHour = 14 and nEndMinute = 45) THEN
    teachHour := 4;
  ELSIF (nStartHour = 15 and nStartMinute = 0 and nEndHour = 16 and nEndMinute = 15) THEN
    teachHour := 5;
  ELSIF (nStartHour = 16 and nStartMinute = 30 and nEndHour = 17 and nEndMinute = 45) THEN
    teachHour := 6;
  ELSIF (nStartHour = 8 and nStartMinute = 30 and nEndHour = 10 and nEndMinute = 20) THEN
    teachHour := 7;
  ELSIF (nStartHour = 10 and nStartMinute = 0 and nEndHour = 11 and nEndMinute = 50) THEN
    teachHour := 8;
  ELSIF (nStartHour = 11 and nStartMinute = 00 and nEndHour = 12 and nEndMinute = 50) THEN
    teachHour := 9;
  ELSIF (nStartHour = 12 and nStartMinute = 0 and nEndHour = 14 and nEndMinute = 50) THEN
    teachHour := 10;
  ELSIF (nStartHour = 15 and nStartMinute = 0 and nEndHour = 16 and nEndMinute = 50) THEN
    teachHour := 11;
  ELSIF (nStartHour = 17 and nStartMinute = 0 and nEndHour = 18 and nEndMinute = 50) THEN
    teachHour := 12;
  ELSIF (nStartHour = 17 and nStartMinute = 0 and nEndHour = 19 and nEndMinute = 50) THEN
    teachHour := 13;
  ELSE
    teachHour := 14;
  END IF;

  RETURN teachHour;

END;
/
