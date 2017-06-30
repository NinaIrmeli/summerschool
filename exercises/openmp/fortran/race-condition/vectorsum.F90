program vectorsum
  use iso_fortran_env, only: int64
  implicit none
  integer, parameter :: ik = int64
  integer(kind=ik), parameter :: nx = 102400_ik

  integer(kind=ik), dimension(nx) :: vecA
  integer(kind=ik) :: asum,sum, psum, sumex
  integer(kind=ik) :: i

  ! Initialization of vector
  do i = 1, nx
     vecA(i) = i
  end do

  sum = 0
  ! TODO: Parallelize the computation
  !omp parallel
  !omp do
  do i = 1, nx
     sum = sum + vecA(i)
  end do
  write(*,*) 'Sum: ', sum
  !omp end do
  !$omp critical(dosum)
  asum=asum+sum
  !omp end critical(dosum)
  !omp end parallel
end program vectorsum
