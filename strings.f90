module strings
   
   contains
   
   ! -------------------------------------------------------------------------------------
   ! Function: str_count
   !> @brief Count the occurrences of a substring in a string.
   !> @param[in] str - string to count from
   !> @param[in] substr - substring to count
   !> @return count of \b substr in \b str
   ! -------------------------------------------------------------------------------------
   function str_count(str,substr) result(count)
      implicit none
      character(len=*), intent(in) :: str
      character(len=*), intent(in) :: substr
      integer :: i,count
      count=0         
      do i=1,len_trim(str)
         if(str(i:i+(len_trim(substr)-1)).eq.substr)count=count+1
      end do
   end function str_count

   ! -------------------------------------------------------------------------------------
   ! Function: str_replace
   !> @brief Replace a substring with another substring within a parent string.
   !> @param[in] str - string to work on
   !> @param[in] old - string to replace
   !> @param[in] new - string to substritute from \b old.
   !> @return modified string where occurrences of \b old replaces with \b new
   ! -------------------------------------------------------------------------------------
   function str_replace(str,old,new) result(strout)
      implicit none
      character(len=*), intent(in) :: str
      character(len=*), intent(in) :: old
      character(len=*), intent(in) :: new
      character(len=:), allocatable :: strout
      integer :: i,len_old,len_new
      logical(kind=1), dimension(len_trim(str)) :: work
      work(:)=.false.
      len_old=len_trim(old)
      len_new=len_trim(new)
      strout=""
      do i=1,len_trim(str)
         if(work(i))cycle
         if(str(i:i+(len_old-1)).eq.old)then
            strout=strout//new
            work(i:i+(len_old-1))=.true.
         else
            strout=strout//str(i:i)
            work(i)=.true.
         endif
      end do
   end function str_replace

   ! -------------------------------------------------------------------------------------
   ! Function: str_upper
   !> @brief Convert all letters to uppercase.
   !> @param[in] str - string to work on
   !> @return modified string with all letters converted to uppercase.
   ! -------------------------------------------------------------------------------------
   function str_upper(str) result(strout)
      implicit none
      character(len=*), intent(in) :: str
      character(len=:), allocatable :: strout
      integer :: i
      strout=""
      do i=1,len_trim(str)
         if(iachar(str(i:i)).ge.97.and.iachar(str(i:i)).le.122)then
            strout=strout//achar(iachar(str(i:i))-32)
         else
            strout=strout//str(i:i)
         endif
      end do
   end function str_upper

   ! -------------------------------------------------------------------------------------
   ! Function: str_lower
   !> @brief Convert all letters to lowercase.
   !> @param[in] str - string to work on
   !> @return modified string with all letters converted to lowercase.
   ! -------------------------------------------------------------------------------------
   function str_lower(str) result(strout)
      implicit none
      character(len=*), intent(in) :: str
      character(len=:), allocatable :: strout
      integer :: i
      strout=""
      do i=1,len_trim(str)
         if(iachar(str(i:i)).ge.65.and.iachar(str(i:i)).le.90)then
            strout=strout//achar(iachar(str(i:i))+32)
         else
            strout=strout//str(i:i)
         endif
      end do
   end function str_lower

   ! -------------------------------------------------------------------------------------
   ! Function: str_split
   !> @brief Split string based on a character delimiter and return string given by the
   !>        column number.
   !> @param[in] str - string to work on
   !> @param[in] delim - character delimiter
   !> @param[in] col - delimited column to return
   !> @return string
   ! -------------------------------------------------------------------------------------
   function str_split(str,delim,col) result(strout)
      implicit none
      character(len=*), intent(in) :: str
      character(len=1), intent(in) :: delim
      integer, intent(in) :: col
      character(len=:), allocatable :: strout
      character(len=:), allocatable :: ctemp
      character(len=:), allocatable :: cwork
      integer :: i,cnt,lastpos
      cnt=0
      lastpos=0
      strout=""
      if(col.le.0.or.col.gt.(str_count(str,delim)+1).or.str_count(str,delim).eq.0)then
         strout=str
         return
      endif
      ctemp=str//delim
      do i=1,len_trim(ctemp)
         if(ctemp(i:i).eq.delim)then
            cnt=cnt+1
            if(cnt.eq.col)then
               cwork=ctemp(lastpos+1:i-1)
               exit
            endif
            lastpos=i
         endif
      end do
      strout=cwork
   end function str_split

   ! -------------------------------------------------------------------------------------
   ! Function: str_uniq
   !> @brief Removed duplicative entries from a \b delimited string. 
   !> @param[in] str - string to work on
   !> @param[in] delim - character delimiter
   !> @return modified string
   ! -------------------------------------------------------------------------------------
   function str_uniq(str,delim) result(strout)
      implicit none
      character(len=*), intent(in) :: str
      character(len=1), intent(in) :: delim
      character(len=:), allocatable :: strout
      character(len=:), allocatable :: ctemp
      character(len=:), allocatable :: col
      integer :: n,nn,ncols,ndelims,nuniq,strlen
      logical(kind=1) :: strfound
      ncols=0
      ndelims=0
      nuniq=0
      strlen=0
      ctemp=trim(adjustl(str))
      strlen=len(ctemp)
      ndelims=str_count(ctemp,delim)
      ncols=ndelims+1
      strout=""
      do n=1,ncols
         col=str_split(ctemp,delim,n)
         if(n.eq.1)then
            strout=col//delim
            nuniq=len(strout)
         endif
         strfound=.false.
         do nn=1,nuniq
            if(col.eq.strout(nn:(nn+len(col))-1))then
               strfound=.true.
               exit
            endif
         end do
         if(.not.strfound)then
            strout=strout//col//delim
            nuniq=len(strout)
         endif
      end do
      if(strout(1:1).eq.delim)strout=strout(2:len(strout))
      strlen=len(strout)
      if(strout(strlen:strlen).eq.delim)strout=strout(1:len(strout)-1)
   end function str_uniq

   ! -------------------------------------------------------------------------------------
   ! Function: str_zfill
   !> @brief Pad a string with zeroes ("0") to specified width. If width is <= input
   !>        string width, then the original string is returned.
   !> @param[in] str - string to work on
   !> @param[in] width - width of padded string
   !> @return modified string
   ! -------------------------------------------------------------------------------------
   function str_zfill(str,width) result(strout)
      implicit none
      character(len=*), intent(in) :: str
      integer, intent(in) :: width
      character(len=:), allocatable :: strout
      strout=""
      if(width.le.len_trim(str))then
         strout=str
      else
         strout=repeat("0",width-len_trim(str))//str
      endif
   end function str_zfill

   ! -------------------------------------------------------------------------------------
   ! Function: str_center
   !> @brief Center a string to a specified width.  The default character to fill in the
   !>        centered string is a blank character.
   !> @param[in] str - string to work on
   !> @param[in] width - width of centered string
   !> @param[in] fillchar - character to fill centered string. \b[OPTIONAL]
   !> @return centered string
   ! -------------------------------------------------------------------------------------
   function str_center(str,width,fillchar) result(strout)
      implicit none
      character(len=*), intent(in) :: str
      integer, intent(in) :: width
      character(len=1), intent(in), optional :: fillchar
      character(len=:), allocatable :: strout
      character(len=1) :: local_fillchar
      local_fillchar=" "
      strout=""
      if(present(fillchar))local_fillchar=fillchar
      if(width.le.len_trim(str))then
         strout=str
      else
         if(mod(width,2).eq.0)then
            strout=repeat(local_fillchar,width/2)//str//repeat(local_fillchar,width/2)
         else
            strout=repeat(local_fillchar,(width/2)-1)//str//repeat(local_fillchar,(width/2)-2)
         endif
      endif
   end function str_center

   ! -------------------------------------------------------------------------------------
   ! Function: str_reverse
   !> @brief Reverse a string.
   !> @param[in] str - string to work on
   !> @return string reverse of \b str
   ! -------------------------------------------------------------------------------------
   function str_reverse(str) result(strout)
      implicit none
      character(len=*), intent(in) :: str
      character(len=:), allocatable :: strout
      integer :: i
      strout=""
      do i=len(str),1,-1
         strout=strout//str(i:i)
      end do
   end function str_reverse

   ! -------------------------------------------------------------------------------------
   ! Function: str_test
   !> @brief Return .true. if substr is in str, .false. otherwise
   !> @param[in] str - string to work on
   !> @param[in] substr - string to search for in str
   !> @return .true. or .false.
   ! -------------------------------------------------------------------------------------
   function str_test(str,substr) result(strtest)
      implicit none
      character(len=*), intent(in) :: str
      character(len=*), intent(in) :: substr
      logical :: strtest
      if(str_count(str,substr).eq.0)then
         strtest=.false.
      elseif(str_count(str,substr).gt.0)then
         strtest=.true.
      endif
   end function str_test

end module strings