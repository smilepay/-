create or replace PROCEDURE InsertCourse (
  courseName IN VARCHAR2,
  courseNo IN NUMBER,
  courseCredit IN NUMBER,
  professorID IN VARCHAR2,
  startHour IN NUMBER,
  startMinute IN NUMBER,
  endHour IN NUMBER,
  endMinute IN NUMBER,
  courseDay IN VARCHAR2,
  courseMax IN NUMBER,
  courseRoom IN VARCHAR2,
  result OUT VARCHAR2)
IS
  duplicate_course EXCEPTION; /*이미 등록한 수업일 경우*/
  not_available_room EXCEPTION; /*해당 장소와 시간에 이미 수업이 등록되어있는 경우*/
  overlap_schedule EXCEPTION; /*다른 강의 시간과 겹치는 경우*/
  nYear NUMBER;
  nSemester NUMBER;
  nCnt NUMBER;
  nCourseId course.c_id%TYPE;
  myHour VARCHAR2(20);
  teach_sHour teach.t_shour%TYPE;
  teach_eHour teach.t_ehour%TYPE;
  teachDay teach.t_day%TYPE;
/*  teachTime NUMBER;
  insertTime NUMBER;*/
  conflict_time_checker NUMBER;
  conflict_day_checker NUMBER;
  CURSOR time_cursor IS
  select *
  from teach
  where p_id = professorID;
  CURSOR room_cursor IS
  select *
  from teach
  where t_room = courseRoom;
BEGIN

  DBMS_OUTPUT.put_line(professorID || '님이 ' || courseName || ' 강좌 등록을 요청하였습니다.');
  
  nYear := DateToEnrollYear(SYSDATE);
  nSemester := DateToEnrollSemester(SYSDATE);
  teachDay := getNumberTeachDay(courseDay);
  teach_sHour := startHour * 100 + startMinute;
  teach_eHour := endHour * 100 + endMinute;

  dbms_output.put_line('요일: ' || teachDay);

  select COUNT(*)
  into nCnt
  from teach t, course c
  where t.t_day = teachDay and t.t_shour = teach_sHour and t.t_ehour = teach_eHour and c.c_name = courseName and c.c_no = courseNo and t.t_year = nYear and t.t_sem = nSemester and t.p_id = professorID;

  IF (nCnt > 0) THEN
  RAISE duplicate_course;
  END IF;

  conflict_time_checker := 0;
  conflict_day_checker := 0;
  
  FOR teach_list IN time_cursor LOOP
    conflict_time_checker := compareHour(teach_sHour,  teach_eHour, teach_list.t_shour, teach_list.t_ehour);
    conflict_day_checker := compareDay(teachDay, teach_list.t_day);
    EXIT WHEN (conflict_time_checker > 0 and conflict_day_checker > 0);
  END LOOP;

  IF (conflict_time_checker > 0 and conflict_day_checker > 0) THEN
  RAISE overlap_schedule;
  END IF;
  DBMS_OUTPUT.put_line('#1 ' || conflict_time_checker || ' | ' || conflict_day_checker);

  conflict_time_checker := 0;
  conflict_day_checker := 0;
  
  FOR teach_list IN room_cursor LOOP
    conflict_time_checker := compareHour(teach_sHour, teach_eHour, teach_list.t_shour, teach_list.t_ehour);
    conflict_day_checker := compareDay(teachDay, teach_list.t_day);
    EXIT WHEN (conflict_time_checker > 0 and conflict_day_checker > 0);
  END LOOP;

  IF (conflict_time_checker > 0 and conflict_day_checker > 0) THEN
  RAISE not_available_room;
  END IF;
  DBMS_OUTPUT.put_line('#2 ' || conflict_time_checker || ' | ' || conflict_day_checker);

  SELECT count(*)
  INTO nCnt
  FROM course;

 IF (nCnt > 0) THEN
  nCourseId := createCourseId();
 ELSE
  nCourseId := 'C000'; 
 END IF;
 
  INSERT INTO course(c_id, c_no, c_name, c_credit) VALUES(nCourseId, courseNo, courseName, courseCredit);
  INSERT INTO teach(c_id, c_no, t_year, t_sem, p_id, t_shour, t_ehour, t_day, t_room, t_max)
  VALUES(nCourseId, courseNo, nYear, nSemester, professorID, teach_sHour, teach_eHour, teachDay, courseRoom, courseMax);

  COMMIT;
  result := '강좌가 개설되었습니다.';

  EXCEPTION
  WHEN not_available_room THEN
    result := '해당 강의실은 이미 예약되어있습니다.';
  WHEN overlap_schedule THEN
    result := '이미 등록된 강의와 시간이 겹칩니다.';
  WHEN duplicate_course THEN
    result := '이미 등록한 강의입니다.';
  WHEN OTHERS THEN
    ROLLBACK;
    result := SQLCODE;
  END;
  /
