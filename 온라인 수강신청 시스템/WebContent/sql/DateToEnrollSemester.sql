CREATE OR REPLACE FUNCTION DateToEnrollSemester(dDate IN DATE)
	RETURN NUMBER
	IS
		month VARCHAR2(3);
		v_sem enroll.e_sem%TYPE;
	BEGIN
		month := TO_CHAR(dDATE, 'mm');
		IF (month >= '11' AND month <= '12') THEN
			v_sem := 1;
		ELSIF (month >= '01' AND month <= '04') THEN
			v_sem := 1;
		ELSIF (month >= '05' AND month <= '10') THEN
			v_sem := 2;
		END IF;
		RETURN v_sem;
	END;
/