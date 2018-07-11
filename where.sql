drop table members;
drop table locations;
create table members(id integer primary key autoincrement, name varchar(50), grade varchar(50), team varchar(50));
create table locations(id integer primary key autoincrement, member_id integer, place varchar(50), time datetime);
