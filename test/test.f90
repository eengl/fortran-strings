program test
   use strings
   implicit none
   
   character(len=:), allocatable :: c1,c2
   integer :: i1

   c1="My name is Tony Stark.  Tony Stark is Iron Man."
   !print *,"MYSTRING = ",c1
   i1=str_count(c1,"Tony")
   !print *,"COUNT OF SPACES = ",i1

   c1=str_replace(c1,"Tony Stark","Steve Rogers")
   !print *,"MYSTRING = ",c1
   c1=str_replace(c1,"Iron Man","Captain America")
   !print *,"MYSTRING = ",c1
   c2=str_upper(c1)
   !print *,"STR_UPPER = ",str_upper(c1)
   c2=str_lower(c1)
   !print *,"STR_LOWER = ",str_lower(c1)

   c1="Ironman,Thor,Thanos,Black Panther,Winter Soldier"
   !print *,"MYSTRING = ",c1
   c2=str_split(c1,",",3)
   !print *,"STR_SPLIT = ",c2
   c2=str_split(c1,",",4)
   !print *,"STR_SPLIT = ",c2
   c2=str_split(c1,",",0)
   !print *,"STR_SPLIT = ",c2
   c2=str_split(c1,",",3)
   !print *,"STR_SPLIT = ",c2

   c1=",Ironman,Thor,,Thanos,Black Panther,Thanos,Thanos,Thor,Thor,,Winter Soldier,,,"
   !print *,"MYSTRING = ",c1
   c2=str_uniq(c1,",")
   !print *,"STR_UNIQ = ",c2

   c1="Thor"
   !print *,"MYSTRING = ",c1
   c2=str_zfill(c1,10)
   !print *,"STR_ZFILL = ",c2
   c2=str_zfill(c1,2)
   !print *,"STR_ZFILL = ",c2

   c1="Thor"
   !print *,"MYSTRING = ",c1
   c2=str_center(c1,2)
   !print *,"STR_CENTER = ",c2
   c2=str_center(c1,5,fillchar="x")
   !print *,"STR_CENTER = ",c2
   c2=str_center(c1,7,fillchar="x")
   !print *,"STR_CENTER = ",c2
   c2=str_center(c1,8,fillchar="x")
   !print *,"STR_CENTER = ",c2
   c2=str_center(c1,20)
   !print *,"STR_CENTER = ",":",c2,":"

   c1="Ironman,Thor,Thanos,Black Panther,Winter Soldier"
   !print *,"MYSTRING = ",c1
   c2=str_reverse(c1)
   !print *,"STR_REVERSE = ",":",c2,":"

end program test
