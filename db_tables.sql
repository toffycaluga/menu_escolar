create table schools(
    id serial primary key,
    name varchar(45) not null,
    email varchar(45) not null,
    password varchar(255) not null,
    es_admin boolean
)


create table orders(
    id serial primary key,
    date timestamp not null,
    is_rectified boolean default false,
    observations varchar(1024),
    school_id integer not null,
    vegetarian integer not null,
    vegetarian_real integer default 0,
    celiac integer not null ,
    celiac_real integer default 0,
    standart integer not null,
    standar_real integer default 0,
    caloric integer not null,
    caloric_real integer default 0,
    ethnic integer not null ,
    ethnic_real integer default 0,
    foreign key (school_id) references schools(id)
);