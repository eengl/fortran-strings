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

   mystring="Eric"
   print *,"MYSTRING = ",mystring
   print *,"STR_ZFILL = ",str_zfill(mystring,10)
   print *,"STR_ZFILL = ",str_zfill(mystring,2)

   mystring="Gina"
   print *,"MYSTRING = ",mystring
   print *,"STR_CENTER = ",str_center(mystring,2)
   print *,"STR_CENTER = ",str_center(mystring,5,fillchar="x")
   print *,"STR_CENTER = ",str_center(mystring,7,fillchar="y")
   print *,"STR_CENTER = ",str_center(mystring,8,fillchar="z")
   print *,"STR_CENTER = ",":",str_center(mystring,20),":"

end program test
