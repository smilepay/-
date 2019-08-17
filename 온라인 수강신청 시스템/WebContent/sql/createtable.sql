create table Students (
s_id NUMBER(10),
s_pw VARCHAR(20),
s_name VARCHAR(10),
s_major VARCHAR(20),
s_addr VARCHAR(30),
s_email VARCHAR(50),
CONSTRAINT S_PK PRIMARY KEY (s_id));

create table Professor (
p_id NUMBER(10),
p_pw VARCHAR(20),
p_name VARCHAR(10),
p_major VARCHAR(20),
p_email VARCHAR(50),
CONSTRAINT P_PK PRIMARY KEY (p_id));

CREATE TABLE Course(
c_id VARCHAR(4),
c_no NUMBER(2),
c_credit NUMBER(1),
c_name VARCHAR(30),
CONSTRAINT C_PK PRIMARY KEY (c_id,c_no));

CREATE TABLE Enroll(
c_id VARCHAR(4),
c_no NUMBER(2),
e_year NUMBER(4),
e_sem NUMBER(1),
s_id NUMBER(10) REFERENCES Students (s_id),
CONSTRAINT E_PK PRIMARY KEY (c_id,e_year,e_sem,s_id));

CREATE TABLE Teach(
c_id VARCHAR(4),
c_no NUMBER(2),
t_year NUMBER(4),
t_sem NUMBER(1),
p_id NUMBER(10) REFERENCES Professor (p_id),
t_shour NUMBER(4),
t_ehour NUMBER(4),
t_day NUMBER(1),
t_max NUMBER(3),
t_room VARCHAR(20),
CONSTRAINT T_PK PRIMARY KEY (c_id,c_no,t_year, t_sem));

CREATE TABLE NOTICE(
	n_no NUMBER(10) CONSTRAINT pk_n PRIMARY KEY,
	n_name VARCHAR2(20),
	n_pw VARCHAR2(20),/*b_pwd*/
	n_title VARCHAR2(40) NOT NULL,
	n_cont VARCHAR2(1000),/*content*/
	n_look NUMBER(10) /*b_hit*/
);

CREATE SEQUENCE n_no
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 9999999999;
   
commit;
