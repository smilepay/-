CREATE OR REPLACE PROCEDURE InsertEnroll (
  sStudentId IN VARCHAR2,
  sCourseId IN VARCHAR2,
  nCourseIdNo IN NUMBER,
  result OUT VARCHAR2)
IS
  too_many_sumCourseUnit EXCEPTION;
  too_many_courses EXCEPTION;
  too_many_students EXCEPTION;
  duplicate_time EXCEPTION;
  duplicate_courses EXCEPTION;
  nYear NUMBER;
  nSemester NUMBER;
  nSumCourseUnit NUMBER;
  nCourseUnit NUMBER;
  nCnt NUMBER;
  nTeachMax NUMBER;
  insert_sHour NUMBER;
  insert_eHour NUMBER;
  insertDay NUMBER;
  teach_sHour NUMBER;
  teach_eHour NUMBER;
  teachDay NUMBER;
  conflict_time_checker NUMBER;
  conflict_day_checker NUMBER;
  CURSOR duplicate_time_cursor IS
    SELECT *
    FROM enroll
    WHERE s_id = sStudentId;
BEGIN
  result := '';

DBMS_OUTPUT.put_line('#');
DBMS_OUTPUT.put_line(sStudentId || '���� �����ȣ ' || sCourseId || ', �й� ' || TO_CHAR(nCourseIdNo) || '�� ���� ����� ��û�Ͽ����ϴ�.');

  nYear := DateToEnrollYear(SYSDATE);
  nSemester := DateToEnrollSemester(SYSDATE);

  SELECT SUM(c.c_credit)
  INTO	 nSumCourseUnit
  FROM   course c, enroll e
  WHERE  e.s_id = sStudentId and e.e_year = nYear and e.e_sem = nSemester and  e.c_id = c.c_id and e.c_no = c.c_no;

  SELECT c_credit
  INTO	 nCourseUnit
  FROM	 course
  WHERE	 c_id = sCourseId and c_no = nCourseIdNo;

  IF (nSumCourseUnit + nCourseUnit > 18) THEN
     RAISE too_many_sumCourseUnit;
  END IF;

  SELECT COUNT(*)
  INTO	 nCnt
  FROM   enroll
  WHERE  s_id = sStudentId and c_id = sCourseId;

  IF (nCnt > 0) THEN
     RAISE too_many_courses;
  END IF;

  SELECT COUNT(*)
  INTO nCnt
  FROM enroll e, course c
  WHERE e.c_id=c.c_id and e.c_no=c.c_no and e.s_id=sStudentId and e.c_no != nCourseIdNo and c.c_name in (select c_name from course where c_id=sCourseId);

  IF (nCnt > 0) THEN
  RAISE duplicate_courses;
  END IF;

  SELECT t_max
  INTO	 nTeachMax
  FROM   teach
  WHERE  t_year= nYear and t_sem = nSemester and c_id = sCourseId and c_no= nCourseIdNo;

  SELECT COUNT(*)
  INTO   nCnt
  FROM   enroll
  WHERE  e_year = nYear and e_sem = nSemester and c_id = sCourseId and c_no = nCourseIdNo;

  IF (nCnt >= nTeachMax)
  THEN
     RAISE too_many_students;
  END IF;

  SELECT t.t_shour, t.t_ehour, t.t_day
  into insert_sHour, insert_eHour, insertDay
  from teach t, course c
  where t.c_id = c.c_id and t.c_no = c.c_no and c.c_id = sCourseId and c.c_no = nCourseIdNo;

  teach_sHour := 0;  teach_eHour := 0; teachDay := 0;

  FOR enroll_list IN duplicate_time_cursor LOOP
    select t.t_shour, t.t_ehour, t.t_day
    into teach_sHour, teach_eHour, teachDay
    from teach t
    where t.c_id = enroll_list.c_id and t.c_no = enroll_list.c_no;

    conflict_time_checker := compareHour(teach_sHour, teach_eHour, insert_sHour, insert_eHour);
    conflict_day_checker := compareDay(teachDay, insertDay);

    EXIT WHEN conflict_time_checker > 0 and conflict_day_checker > 0;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE(conflict_time_checker || '/' || conflict_day_checker);
  
  IF (conflict_time_checker > 0 and conflict_day_checker > 0) THEN
  RAISE duplicate_time;
  END IF;

  INSERT INTO enroll(s_id,c_id,c_no,e_year,e_sem) VALUES (sStudentId, sCourseId, nCourseIdNo, nYear, nSemester);

  COMMIT;
  result := '������û ����� �Ϸ�Ǿ����ϴ�.';

  EXCEPTION
    WHEN too_many_sumCourseUnit THEN
      result := '�ִ������� �ʰ��Ͽ����ϴ�';
    WHEN too_many_courses THEN
      result := '�̹� ��ϵǾ��ִ� �����Դϴ�.';
    WHEN too_many_students THEN
      result := '������û �ο��� �ʰ��Ǿ� ����� �Ұ����մϴ�';
    WHEN duplicate_time THEN
      result := '�̹� ��ϵ� ����� �ð��� �ߺ��˴ϴ�.';
    WHEN duplicate_courses THEN
      result := '�̹� �ٸ� �й��� ���Ǹ� ��û�Ͽ����ϴ�.';
    WHEN no_data_found THEN
      result := '�̹� �б� ������ �ƴմϴ�.';
    WHEN OTHERS THEN
      ROLLBACK;
      result := SQLCODE;
END;
/