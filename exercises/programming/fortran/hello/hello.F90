program hello
  implicit none
  integer :: const
  real :: a,b
 
  write(*,*) 'Write two numbers: '
  read(*,*) a,b
  
  write (*,*) 'a/b: '
  write (*,'(F4.2)') a/b 


end program hello
