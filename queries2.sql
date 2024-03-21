use fruits;

#left outer join
select A.name, B.color from A
left join B
on A.color_id = B.color_id;

#left anti join
select A.name, B.color from A
left join B
on A.color_id = B.color_id
where B.color_id is NULL;

#right outer join
select A.name, B.color from A
right join B
on A.color_id = B.color_id;

#right anti join
select A.name, B.color from A
right join B
on A.color_id = B.color_id
where A.color_id is NULL;

#inner join
select A.name, B.color from A
inner join B
on A.color_id = B.color_id;

#full outer join
select * from A
full join B
on A.color_id = B.color_id;

#empty outer join
select * from A
full join B
on A.color_id = B.color_id
where A.color_id is null
or B.color_id is null;

#cartesian product (cross join)
select * from A cross join B;