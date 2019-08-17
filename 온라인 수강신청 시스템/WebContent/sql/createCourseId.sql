create or replace function createCourseId
  RETURN VARCHAR2
  IS
    courseId course.c_id%TYPE;
    nCnt NUMBER;
    temp number;
    CURSOR last_teach_cursor IS
    select *
    from teach
    order by c_id;
  BEGIN
    courseId := 'C000';
    for teach_list in last_teach_cursor loop
      courseId := teach_list.c_id;
    end loop;
   
    select substr(courseId, 2, 3)
    into courseId
    from dual;

    temp := TO_NUMBER(courseId);
    temp := temp + 1;

    courseId := 'C' || LPAD(TO_CHAR(temp), 3, '0');
    RETURN courseId;
  end;
  /
