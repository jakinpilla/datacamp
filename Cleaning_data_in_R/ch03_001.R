class(99L)
class(F)


students <- read_csv('students_with_dates.csv')
students %>% str()

students$Grades <- as.character(students$Grades)
students$Medu <- as.factor(students$Medu)
students$Fedu <- as.factor(students$Fedu)

students %>% str()

students$dob <- as.character(students$dob)
students$nurse_visit <- as.character(students$nurse_visit)

library(lubridate)

dmy('17 Sep 2015')
'July 15, 2012 12:56' %>% mdy_hm()

students$dob[1:10] %>% class()
students$dob <- ymd(students$dob)
students$dob[1:10] %>% class()

students$nurse_visit <- ymd_hms(students$nurse_visit)


library(stringr)

str_trim(c('  Filip ', 'Nick ', ' Jonathan'))

c('23485W', '8823453Q', '994Z') %>%
  str_pad(width = 9, side = 'left', pad = '0')



# str_detect, str_replace... ----------------------------------------------

students <- read_csv('students_with_dates.csv')
students$dob <- as.character(students$dob)

students %>%
  mutate(is_1997 = str_detect(dob, '1997')) -> students2

students2 %>% colnames() 
  
students2$sex %>%
  str_replace('F', 'Female') %>%
  str_replace('M', 'Male') -> students2$sex

str(students2)


# NA ----------------------------------------------------------------------

is.na(students2) %>% any()
table(students$address)
table(students$Pstatus)
table(students$dob)

titanic <- read_csv('titanic3.csv')

titanic %>% is.na() %>% any()

titanic %>% head(50)

titanic %>% dim()

titanic$cabin[is.na(titanic$cabin)] <- ''
titanic$cabin[is.na(titanic$cabin)]


titanic <- read_csv('titanic3.csv')
complete.cases(titanic)
na.omit(titanic)
titanic %>% View()
