insert into students values(1610861, '0000', '장서연', '컴퓨터과학전공', '경기도', 'apple@naver.com');

insert into students values(1614263, '1234', '박아영', '컴퓨터과학전공', '서울', 'pay@naver.com');

insert into students values(1616161, '5678', '김숙명', '영문학과', '전라도', 'abc@daum.net');

insert into students values(1511222, '0000', '최지니', '물리학과', '서울', 'as@naver.com');



insert into course values('1234',1,3,'데베프');

insert into course values('7894',2,2,'영어');

insert into course values('5698',1,3,'컴퓨터수학');

insert into course values('7747',1,2,'문사테');



insert into professor values(13145, '1111', '김철수', '컴퓨터과학전공', 'rrr@naver.com');

insert into professor values(12433, '2222', '박가현', '중문학과', 'cccc@naver.com');

insert into professor values(15144, '8888', '최단아', '영어영문학과', 'tw@naver.com');

insert into professor values(11222, '3333', '이호석', '체육교육학과', 'pp@naver.com');



insert into teach values('1234', 1, 2019,2,13145,1330,1445,2,20,'명신관202');

insert into teach values('7894', 2, 2019,2,15144,1500,1615,3,30,'순헌관304');

insert into teach values('7747', 1, 2019,2,11222,0900,1015,1,70,'진리관415');



insert into enroll values('1234',1,2019,2,1616161);

insert into enroll values('7894',2,2019,2,1614263);

insert into enroll values('7747',1,2019,2,1616161);
