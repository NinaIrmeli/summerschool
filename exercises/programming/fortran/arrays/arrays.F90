program arrays
  implicit none
  integer :: nx, ny
  integer :: i, alloc_stat
  
  real, allocatable :: x(:,:)  
 
  write (*,*) 'Give number of rows and columns for matrix A:'
  read (*,*) nx, ny

  allocate (x(0:nx,0:ny), stat=alloc_stat)
  if (alloc_stat /= 0) call abort()


  ! TODO Use array syntax to initialize the array
  x(:,:)=55.0
  x(0,:)=1.0
  x(:,0)=2.0
  x(nx,:)=3.0
  x(:,ny)=4.0
  





  !--------------------------------------------------
  ! Print out the array
  do i = 0, nx
    write(*,'(*(F6.1))') x(i,:)
  end do


end program arrays
