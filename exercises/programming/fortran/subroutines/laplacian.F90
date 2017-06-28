module laplacian_mod
  implicit none
  real, parameter :: dx = 0.01, dy = 0.01
  
 contains
 
  subroutine initialize(x,nx,ny)
! TODO: implement a subroutine that initializes the input arrayd
  implicit none
  
  integer,intent(out) :: nx, ny
  integer ::  alloc_stat
  real,intent(inout) :: x(:,:)
 
  write (*,*) 'Initialize array'
  write(*,*) 'Give number of rows and columns for matrix: '
  read(*,*) nx,ny

  
  allocate(x(0:nx+1,0:ny+1), stat=alloc_stat)
  if (alloc_stat /=0) call abort()


  x(:,:)  = 65.0
  x(:,1)  = 20.0
  x(:,ny) = 70.0
  x(1,:)  = 85.0
  x(nx,1) = 5.0
   
  end subroutine initialize
   




  subroutine laplacian(curr, prev,nx,ny)
! TODO: insert a subroutine that computes a laplacian of the
! array "prev" and returns it as an array "curr"
  implicit none
  integer :: i,j
  integer :: nx,ny
  real, intent(in) :: prev(nx,ny)
  real, intent(out) :: curr(nx,ny)
 
  write(*,*) 'Calculate Laplacian'
 
  do j=1,ny
  do i=1,nx
    curr(i,j) = (prev(i-1,j)-2*prev(i,j)+prev(i+1,j))/dx**2 + (prev(i,j-1)-2*prev(i,j)+prev(i,j+1))/dy**2
  end do
  end do

  end subroutine laplacian







  subroutine write_field(array,nx,ny)
! TODO: write a subroutine that prints "array" on screen
  implicit none
  integer :: i
  integer, intent(in) :: nx, ny
  real, intent(in) :: array(nx,ny)
 
  write(*,*) "Laplacian of the array:"
  do i = 1, nx
    write(*,'(*(G10.1))') array(i,:)
  end do



  end subroutine write_field

end module laplacian_mod
