CREATE OR REPLACE PROCEDURE StudentEnrollTimetable (enrollSID IN NUMBER,
   total_course OUT NUMBER,
   total_unit OUT NUMBER)
IS
   year NUMBER;
   semester NUMBER;
BEGIN
   year := DateToEnrollYear(SYSDATE);
   semester := DateToEnrollSemester(SYSDATE);

   select COUNT(*)
   into total_course
   from enroll
   where e_year = year and e_sem = semester and s_id = enrollSID;
   
   select SUM(c.c_credit)
   into total_unit
   from enroll e, course c
   where e.e_year = year and e.e_sem = semester and e.s_id = enrollSID and e.c_id = c.c_id and e.c_no = c.c_no;
END;
/