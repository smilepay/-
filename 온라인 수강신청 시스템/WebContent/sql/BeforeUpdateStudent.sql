create or replace trigger BeforeUpdateOnStudent
  BEFORE
  update on students
  FOR EACH ROW
DECLARE
  same_password EXCEPTION;
  underflow_length EXCEPTION;
  invalid_value EXCEPTION;
  nLength NUMBER;
  nBlank NUMBER;

BEGIN

  select LENGTH(:new.s_pw), INSTR(:new.s_pw, ' ')
  into nLength, nBlank
  from dual;

  IF (:old.s_pw = :new.s_pw) THEN
  RAISE same_password;
  END IF;

  IF (nLength < 4) THEN
  RAISE underflow_length;
  END IF;

  IF (nBlank > 0) THEN
  RAISE invalid_value;
  END IF;

  EXCEPTION
  WHEN same_password THEN
    RAISE_APPLICATION_ERROR(-20001, '이전과 동일한 비밀번호는 사용할 수 없습니다');
  WHEN underflow_length THEN
    RAISE_APPLICATION_ERROR(-20002, '비밀번호는 4자리 이상이어야 합니다.');
  WHEN invalid_value THEN
    RAISE_APPLICATION_ERROR(-20003, '비밀번호에 공란은 입력되지 않습니다.');

END;
/
