create or replace function getStrHour(
  startTime IN NUMBER,
  endTime IN NUMBER)
  RETURN VARCHAR2
  IS
    strStart VARCHAR2(4);
    strEnd VARCHAR2(4);
    strHour VARCHAR2(30);
  BEGIN
    strHour := '';
    strStart := TO_CHAR(startTime);
    strEnd := TO_CHAR(endTime);
    IF (LENGTH(strStart) = 3) THEN
      strStart := '0' || strStart;
    END IF;
    IF (LENGTH(strEnd) = 3) THEN
      strEnd := '0' || strEnd;
    END IF;
    strHour := SUBSTR(strStart, 1, 2) || ':';
    strHour := strHour || SUBSTR(strStart, 3, 2) || '~';
    strHour := strHour || SUBSTR(strEnd, 1, 2) || ':';
    strHour := strHour || SUBSTR(strEnd, 3, 2);
    RETURN strHour;
  END;
  /
