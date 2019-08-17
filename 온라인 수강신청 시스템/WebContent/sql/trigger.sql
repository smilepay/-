CREATE OR REPLACE TRIGGER StudentInfoUpdate BEFORE/*beforeupdatestudent*/
UPDATE ON students
FOR EACH ROW
DECLARE
	pw_lessthan4 EXCEPTION;
	no_spacebar EXCEPTION;
	pw_len NUMBER;
	is_blank NUMBER;
BEGIN
	pw_len := length(:new.s_pw);
	IF (pw_len<4)
		THEN RAISE pw_lessthan4;
	END IF;
	IF (:new.s_pw = replace(:new.s_pw,' ',''))
		THEN is_blank := 0;
	ELSE is_blank :=1;
	END IF;
	IF (is_blank!=0)
		THEN RAISE no_spacebar;
	END IF;
	EXCEPTION
	WHEN pw_lessthan4 THEN
		RAISE_APPLICATION_ERROR(-20002, '비밀 번호를 4자리 이상 입력해주세요.');
	WHEN no_spacebar THEN
		RAISE_APPLICATION_ERROR(-20003, '비밀번호에 공란을 포함할 수 없습니다.');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/