create or replace function getNumberTeachDay(
  courseDay IN VARCHAR2)
  RETURN number
  IS
  nCourseDay NUMBER;
BEGIN
  nCourseDay := TO_NUMBER(courseDay);
  RETURN nCourseDay;
END;
/
