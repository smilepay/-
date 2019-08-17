create or replace function getNextCno(
  courseId VARCHAR2)
  RETURN NUMBER
  IS
  next_no number;
  courseName course.c_name%TYPE;
  CURSOR last_cno IS
  select *
  from course
  order by c_no;
BEGIN

  select c_name
  into courseName
  from course
  where c_id=courseId;

  FOR course_list in last_cno LOOP
    IF (course_list.c_name=courseName) THEN
      next_no := course_list.c_no;
    END IF;
  END LOOP;

  next_no := next_no + 1;
  RETURN next_no;

END;
/