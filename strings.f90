module strings
   
   contains
   
   ! -------------------------------------------------------------------------------------
   ! Function: str_count
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
   ! -------------------------------------------------------------------------------------
   function str_upper(str) result(strout)
      implicit none
      character(len=*), intent(in) :: str
      character(len=:), allocatable :: strout
      integer :: i
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
   ! -------------------------------------------------------------------------------------
   function str_lower(str) result(strout)
      implicit none
      character(len=*), intent(in) :: str
      character(len=:), allocatable :: strout
      integer :: i
      do i=1,len_trim(str)
         if(iachar(str(i:i)).ge.65.and.iachar(str(i:i)).le.90)then
            strout=strout//achar(iachar(str(i:i))+32)
         else
            strout=strout//str(i:i)
         endif
      end do
   end function str_lower

   ! -------------------------------------------------------------------------------------
   ! Function str_split
   ! -------------------------------------------------------------------------------------
   function str_split(str,delim,col) result(strout)
      implicit none
      character(len=*), intent(in) :: str
      character(len=1), intent(in) :: delim
      integer, intent(in) :: col
      character(len=:), allocatable :: strout
      integer :: i,cnt
      cnt=0
      if(col.le.0.or.col.gt.(str_count(str,delim)+1).or.str_count(str,delim).eq.0)then
         strout=str
         return
      endif
      do i=1,len_trim(str)
         if(str(i:i).eq.delim)then
            cnt=cnt+1
            if(cnt.eq.col)then
               exit
            else
               strout=""
            endif
         else
            strout=strout//str(i:i)
         endif
      end do
   end function str_split

   ! -------------------------------------------------------------------------------------
   ! Function str_uniq
   ! -------------------------------------------------------------------------------------
   function str_uniq(str,delim) result(strout)
      implicit none
      character(len=*), intent(in) :: str
      character(len=1), intent(in) :: delim
      character(len=:), allocatable :: strout
      integer :: i,ii,ncols
      logical(kind=1), allocatable, dimension(:) :: work
      if(allocated(work))deallocate(work)
      ncols=str_count(str,delim)+1
      allocate(work(ncols))
      work(:)=.false.
      do i=1,ncols
         do ii=i+1,ncols
            if(str_split(str,delim,ii).eq.str_split(str,delim,i))work(ii)=.true.
         end do
         if(.not.work(i))then
            if(len_trim(strout).eq.0)then
               strout=str_split(str,delim,i)
            elseif(len_trim(strout).gt.0)then
               strout=strout//delim//str_split(str,delim,i)
            endif
         endif
      end do
      if(allocated(work))deallocate(work)
   end function str_uniq

end module strings