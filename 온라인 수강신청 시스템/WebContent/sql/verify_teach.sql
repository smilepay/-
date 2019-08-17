CREATE OR REPLACE PROCEDURE ProfessorEnrollTimeTable (enrollPID IN NUMBER,/*selecttimetableprofessor*/
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
	from teach
	where t_year = year and t_sem = semester and p_id = enrollPID;
	
	select SUM(c.c_credit)
	into total_unit
	from teach t, course c
	where t.t_year = year and t.t_sem = semester and t.p_id = enrollPID and t.c_id = c.c_id and t.c_no = c.c_no;
	DBMS_OUTPUT.PUT_LINE('총 '||total_course||' 과목과 총 '||total_unit||' 학점을 강의합니다.');
END;
/