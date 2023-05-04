create table student(
USN varchar(10),
sname varchar(50),
address varchar(40),
phone number(10),
gender char,
primary key(USN)
);

create table semsec(
SSID varchar(5),
sem number(1),
sec char,
primary key(SSID)
);

create table class(
USN varchar(10),
SSID varchar(5),
primary key(USN, SSID),
foreign key (USN) references student(USN),
foreign key (SSID) references semsec(SSID)
);

create table subject(
subcode varchar(6),
title varchar(15),
sem number(1),
credits number(1),
primary key(subcode)
);

create table ciemarks(
USN varchar(10),
subcode varchar(6),
SSID varchar(5),
CIE1 number(2),
CIE2 number(2),
CIE3 number(2),
FinalCIE number(2),
primary key(USN, subcode, SSID),
foreign key(USN) references student(USN),
foreign key(subcode) references subject(subcode),
foreign key(SSID) references semsec(SSID)
);

insert into student values ('1DA15CS001', 'Ajay', 'Banglore', 9845807018, 'M')
insert into student values ('1DA15CS065', 'Ishika', 'Manglore', 9845807018, 'F')
insert into student values ('1DA15CS101', 'Pradeep', 'Banglore', 9845807018, 'M')
insert into student values ('1DA19CS001', 'Abhishek', 'Banglore', 9845807018, 'M')
insert into student values ('1DA19CS045', 'Diskshya', 'Manglore', 9845807018, 'F')
insert into student values ('1DA19CS089', 'Mina', 'Banglore', 9845807018, 'F')
insert into student values ('1DA19CS133', 'Siddhartha', 'Banglore', 9845807018, 'M')
select * from student;


insert into semsec values ('CSE5A', 5, 'A')
insert into semsec values ('CSE5B', 5, 'B')
insert into semsec values ('CSE5C', 5, 'C')
insert into semsec values ('CSE4A', 4, 'A')
insert into semsec values ('CSE4B', 4, 'B')
insert into semsec values ('CSE4C', 4, 'C')
select * from semsec;


insert into class values ('1DA15CS001', 'CSE5A')
insert into class values ('1DA15CS065', 'CSE5B')
insert into class values ('1DA15CS101', 'CSE5C')

insert into class values ('1DA19CS001', 'CSE4A')
insert into class values ('1DA19CS045', 'CSE4B')
insert into class values ('1DA19CS089', 'CSE4C')
insert into class values ('1DA19CS133', 'CSE4C')
select * from class;


insert into subject values ('18CS41','ADT', 4, 4)
insert into subject values ('18CS42','MCES', 4, 4)
insert into subject values ('18CS43','C++', 4, 3)
insert into subject values ('18CS44','COA', 4, 3)

insert into subject values ('18CS51','Java', 5, 4)
insert into subject values ('18CS52','CNIP', 5, 4)
insert into subject values ('18CS53','SE', 5, 3)
insert into subject values ('18CS54','DBMS', 5, 3)
select * from subject;


insert into ciemarks values ('1DA15CS101', '18CS51', 'CSE5C', 24, 23, 22, NULL)
insert into ciemarks values ('1DA15CS101', '18CS52', 'CSE5C', 23, 21, 19,NULL)
insert into ciemarks values ('1DA15CS101', '18CS53', 'CSE5C', 14, 18, 21,NULL)
insert into ciemarks values ('1DA15CS101', '18CS54', 'CSE5C', 20, 22, 24,NULL)
select * from ciemarks;

Q1)List all the student details studying in fourth semester ‘C’section

select s.*, ss.sem, ss.sec
from student s, semsec ss, class c
where s.USN = C.USN and ss.SSID = C.SSID
and ss.sem = 4 and ss.sec = 'C'


Q2)Compute the total number of male and female students in each semester and in each section. 

select ss.sem, ss.sec, s.gender, count(s.gender) as count
from student s, semsec ss, class c
where s.USN = C.USN and ss.SSID = C.SSID
group by ss.sem, ss.sec, s.gender
order by sem;

Q3)Create a view of Test1 marks of student USN ‘1DA15CS101’ in all subjects. 

create view stu_cie1_marks as
select CIE1, subcode
from ciemarks
where USN = '1DA15CS101';

Q4)Calculate the FinalCIE (average of best two test marks) and update the corresponding table for all students. 

update ciemarks
set FinalCIE = ((CIE1 + CIE2 + CIE3) - LEAST(CIE1, CIE2, CIE3))/2;
select * from ciemarks;

Q5)Categorize students based on the following criterion: 
If FinalCIE = 17 to 20 then CAT = ‘Outstanding’ 
If FinalCIE< 12 then CAT = ‘Weak’
If FinalCIE = 12 to 16 then CAT = ‘Average’
Give these details only for 8th semester A, B, and C section students.


select s.*,
(case
when m.FinalCIE between 22 and 25 then 'Outstanding'
when m.FinalCIE between 18 and 21 then 'Average'
else 'weak'
end) as CAT
from student s, semsec ss, ciemarks m, subject sub
where s.USN = m.USN and ss.SSID = m.SSID and
sub.subcode = m.subcode and sub.sem = 5;