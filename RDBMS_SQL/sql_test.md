sql\_practice
================
2020 1 28

먼저 부서 테이블을 생성합니다. 명령어: create table…

``` sql
create table departments
(dep_num int(10) primary key,
dep_name varchar(15) not null);
```

생성된 테이블에 데이터들을 insert 합니다. 명령어:insert into…values…

``` sql
insert into departments (dep_num, dep_name)
values(10, '교수부'),
(20, '행정부'),
(30, '전발부');
```

``` sql
select * from departments;
```

| dep\_num | dep\_name |
| -------: | :-------- |
|       10 | 교수부       |
|       20 | 행정부       |
|       30 | 전발부       |

3 records

``` sql
desc departments;
```

| Field     | Type   | Null | Key | Default | Extra |
| :-------- | :----- | :--- | :-- | :------ | :---- |
| dep\_num  | double | YES  |     | NA      |       |
| dep\_name | text   | YES  |     | NA      |       |

2 records
