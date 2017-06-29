program main
  use io
  implicit none
  character(len=20) :: filename
  real, dimension(:,:), allocatable :: field
  
  filename='bottle.dat' 
  
  call read_field(field, 'bottle.dat')

  call write_field(field, 0)

end program main
