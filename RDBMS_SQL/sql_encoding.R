library(RMySQL)
con <- dbConnect(RMySQL::MySQL(), 
                 dbname = "my_db", 
                 port = 3306,
                 user = "root",
                 password = "chr0n3!7!")


departments <- data.frame(
  dep_num = c(10, 20, 30),
  dep_name = c('교수부', '행정부', '전발부')
)


employee <- data.frame(
  emp_num = c(7232, 7369, 7499, 7521, 7566, 7654, 7698, 7782, 7844, 7876),
  emp_name = c('김경창', '최인영', '이한국', '이해영', '김영민', '김일국', '박영미', '조수미', 
               '홍태산', '임필승'),
  emp_position = c('부대장', '교수부장', '운영교관', '체계교관', '행정부장', '전술교관', 
                   '군수장교', '인사장교', '전발부장', '교리장교'),
  adm_emp_num = c(7230, 7232, 7369, 7369, 7232, 7369, 7566, 7566, 7232, 7844),
  sal = c(300, 220, 140, 130, 230, 110, 120, 100, 210, 100),
  dep_num = c(10, 10, 10, 10, 20, 10, 20, 20, 30, 30)
)

dbListTables(con)

dbGetQuery(con, "set names 'euckr'")
dbSendQuery(con, "SET NAMES euckr;")
dbSendQuery(con, "SET CHARACTER SET euckr;")
dbSendQuery(con, "SET character_set_connection=euckr;")


dbWriteTable(conn = con, 'departments', departments, overwrite = T, row.names =F)
 

?dbWriteTable

create table departments
(dep_num int primary key, 
  dep_name varchar(10) not null);

?dbReadTable

tbl <- dbReadTable(conn = con, 'departments')

Encoding(tbl[, 2]) <- 'UTF-8'
tbl




