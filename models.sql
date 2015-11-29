drop table if exists users cascade;

create table users (
  uid serial primary key,
  username varchar,
  password varchar
);

drop table if exists classes cascade;

create table classes (
  cid serial primary key,
  day date,
  time time
);

drop table if exists attending cascade;

create table attending (
  aid serial primary key,
  user_id integer references users(uid),
  class_id integer references classes(cid)
);

insert into users (username, password) values ('ava', 'ava');
insert into users (username, password) values ('bert', 'bert');
insert into users (username, password) values ('calum', 'calum');

insert into classes (day, time) values
  ('Jan 1, 2016', '10:00 AM'),
  ('Jan 1, 2016', '12:00 PM'),
  ('Jan 1, 2016', '1:00 PM'),
  ('Jan 2, 2016', '8:00 AM'),
  ('Jan 2, 2016', '9:00 AM');

insert into attending (user_id, class_id) values
  ((select uid from users where username = 'ava'), (select cid from classes where day = 'Jan 1, 2016' and time = '10:00 AM')),
  ((select uid from users where username = 'ava'), (select cid from classes where day = 'Jan 2, 2016' and time = '8:00 AM')),
  ((select uid from users where username = 'bert'), (select cid from classes where day = 'Jan 1, 2016' and time = '12:00 PM')),
  ((select uid from users where username = 'bert'), (select cid from classes where day = 'Jan 2, 2016' and time = '9:00 AM')),
  ((select uid from users where username = 'calum'), (select cid from classes where day = 'Jan 1, 2016' and time = '10:00 AM')),
  ((select uid from users where username = 'calum'), (select cid from classes where day = 'Jan 2, 2016' and time = '8:00 AM')),
  ((select uid from users where username = 'calum'), (select cid from classes where day = 'Jan 1, 2016' and time = '1:00 PM'));

select * from users;
select * from classes;
select * from attending;

select uid, username from users
  inner join attending on users.uid = attending.user_id
  inner join classes on classes.cid = attending.class_id
  order by cid;

select * from classes
  inner join attending on classes.cid = attending.class_id
  --select uid, username from users
  inner join users on users.uid = attending.user_id
  order by cid;
