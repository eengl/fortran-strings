program test
   use strings
   implicit none
   
   character(len=:), allocatable :: c1,c2
   integer :: i1
   logical :: l1

   c1="My name is Tony Stark.  Tony Stark is Iron Man."
   i1=str_count(c1,"Tony")
   if(i1.ne.2)call exit(1)
   i1=str_count(c1,"Tony",match_case=.true.)
   if(i1.ne.2)call exit(1)
   i1=str_count(c1,"TONY",match_case=.false.)
   if(i1.ne.2)call exit(1)
   i1=str_count(c1,"tony",match_case=.true.)
   if(i1.ne.0)call exit(1)

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

   c1="Ironman,Thor,Thanos,Black Panther,Winter Soldier"
   l1=str_test(c1,"Thor") ! TRUE
   !print *,l1
   if(.not.l1)call exit(1)
   l1=str_test(c1,"Vision") ! FALSE
   !print *,l1
   if(l1)call exit(1)
   l1=str_test(c1,"THOR",match_case=.true.) ! False
   if(l1)call exit(1)
   l1=str_test(c1,"THOR",match_case=.false.) ! True
   if(.not.l1)call exit(1)

   c1="Ironman,Thor,Thanos,Black Panther,Winter Soldier"
   if(str_swapcase(str_swapcase(c1)).ne.c1)call exit(1)

   c1="accessg,accesse,aigfs,ecmwfd,ecmwfe,gefs,gfs"
   write(*,*)c1
   write(*,*)str_uniq(c1,",")
   if(str_uniq(c1,",").ne.c1)call exit(1)

end program test
