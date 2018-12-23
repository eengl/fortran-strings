program test
   use strings
   implicit none
   
   character(len=:), allocatable :: mystring

   mystring="My name is Tony Starrk. Tony is awesome."
   print *,"MYSTRING = ",mystring
   print *,"COUNT OF SPACES = ",str_count(mystring,"Eric")

   print *,"STR_REPLACE = ",str_replace(mystring,"Eric","Gina")
   print *,"STR_UPPER = ",str_upper(mystring)
   print *,"STR_LOWER = ",str_lower(mystring)

   mystring="ironman,thor,thanos"
   print *,"MYSTRING = ",mystring
   print *,"STR_SPLIT = ",str_split(mystring,",",3)
   print *,"STR_SPLIT = ",str_split(mystring,",",4)
   print *,"STR_SPLIT = ",str_split(mystring,",",0)
   print *,"STR_SPLIT = ",str_split(mystring,"!",3)

   mystring=",eric,eric,gina,naomi,tony,,,gina,tony,naomi,eric,gina,,,"
   print *,"MYSTRING = ",mystring
   print *,"STR_UNIQ = ",str_uniq(mystring,",")

end program test
