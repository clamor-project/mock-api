set schema 'clamor';

drop table if exists "user";
drop table if exists "goup";
drop table if exists "role";
drop table if exists user_group;
drop table if exists group_message;
drop table if exists "event";

create table "user"(
	id: serial primary key,
	username: text unique not null,
	"password": text not null,
	"email": text unique not null,
	is_admin: boolean
);

create table "group"(
	id: serial primary key,
	"name": text unique not null,
	description: text,
	private: boolean
);

create table "role"(
	id: serial primary key,
	role_name: text
);

insert into "role" ("role_name")
values ('organizer'), ('member'), ('banned');

create table user_group(
	id: serial primary key,
	user_id: int references "user" on delete cascade,
	group_id: int references  "group" on delete cascade,
	"role": int references "role",
	joined_date: date not null
);

create table group_message(
	id: serial primary key,
	author: int references "user" on delete cascade,
	date_created: date default now(),
	"content": text not null
);

create table "event"(
	id: serial primary key,
	creator: int references "user" on delete no action,
	description: text not null,
	date_posted: date default now(),
	date_of: date not null,
);