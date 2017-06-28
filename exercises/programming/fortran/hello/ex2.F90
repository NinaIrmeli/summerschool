program ex2
implicit none

integer,parameter :: m=10, n=10
integer :: i
real :: x(0:m+1,0:n+1)

x(:,:)=65.0

do i=0,m+1
  x(i,0)=20.0
  x(i,n+1)=85.
end do

do i=0,n+1
  x(0,i)=70.0
  x(m+1,i)=5.0
end do


do i=0,n+1
  write(*,'(11F5.1)') x(:,i)
end do

write(*,'(11F5.1)') x(:,:)

end program ex2
