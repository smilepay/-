create or replace function DateToEnrollYear(dDate IN DATE)
   return number
is
   nYear number;
   sMonth char(2);
begin
   select to_number(to_char(dDate, 'yyyy')), to_char(dDate, 'mm')
   into nYear, sMonth
   from dual;
   if (sMonth = '11' or sMonth='12') then
      nYear := nYear+1;
   end if;
   return nYear;
end;
/