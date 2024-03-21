create database fruits;
use fruits;

create table A(
    color_id integer,
    name varchar(16)
);

insert into A
    (color_id,name)
VALUES
    ('1','apple'),
    ('1','apple'),
    ('1','apple'),
    ('1','apple'),
    ('2','banana'),
    ('2','banana'),
    ('3','guava');

create table B(
    color_id integer,
    color varchar(16)
);

insert into B
    (color_id, color)
VALUES
    ('1','red'),
    ('2','yellow'),
    ('3','green');

show tables;