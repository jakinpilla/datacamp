-- !preview con=DBI::dbConnect(RMySQL::MySQL(), user = "root", password = "chr0n3!7!", dbname = 'adult')

SELECT * from adult;

select education, occupation from adult;