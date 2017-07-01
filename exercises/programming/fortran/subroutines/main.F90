program subroutines
  use laplacian_mod
  implicit none
! TODO: define the arrays
  integer :: nx, ny
  real, allocatable :: previous(:,:), current(:,:)

  write (*,*) 'Give number of rows and columns for matrix A:'
  read (*,*) nx, ny


  ! initialize the array
  call initialize(previous,nx,ny)

  call write_field(previous)

  ! compute the Laplacian
  call laplacian(current, previous,nx,ny)

  ! print the result array
  call write_field(current,nx,ny)
 
end program subroutines

