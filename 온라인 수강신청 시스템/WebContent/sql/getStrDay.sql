create or replace function getStrDay(
  courseDay IN NUMBER)
  RETURN VARCHAR2
  IS
  strDay varchar2(10);
  firstDay varchar2(10);
  secondDay varchar2(10);
BEGIN  
  if (10 <= courseDay and courseDay < 20) then
	firstDay := '��';
  elsif (20 <= courseDay and courseDay < 30) then
	firstDay := 'ȭ';
  elsif (30 <= courseDay and courseDay < 40) then
	firstDay := '��';
  elsif (40 <= courseDay and courseDay < 50) then
	firstDay := '��';
  elsif (50 <= courseDay and courseDay < 60) then
	firstDay := '��';
  end if;
  
  if (MOD(courseDay, 10) = 1) then
	secondDay := '��';
  elsif (MOD(courseDay, 10) = 2) then
	secondDay := 'ȭ';
  elsif (MOD(courseDay, 10) = 3) then
	secondDay := '��';
  elsif (MOD(courseDay, 10) = 4) then
	secondDay := '��';
  elsif (MOD(courseDay, 10) = 5) then
	secondDay := '��';
  end if;
  
  if (courseDay < 10) then
	strDay := secondDay;
  else
	strDay := CONCAT(firstDay, secondDay);
  end if;
  return strDay;
	
END;
/