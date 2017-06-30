program vectorsum
  use omp_lib
  implicit none
  integer :: omp_rank
  integer, parameter :: rk = kind(1d0)
  integer, parameter :: ik = selected_int_kind(9)
  integer, parameter :: nx = 1e8
  real :: starttime, endtime
  real(kind=rk), dimension(nx) :: vecA, vecB, vecC
  real(kind=rk)    :: sum
  integer(kind=ik) :: i

  ! Initialization of vectors
  do i = 1, nx
     vecA(i) = 1.0_rk/(real(nx - i + 1, kind=rk))
     vecB(i) = vecA(i)**2
  end do

  ! TODO:
  !   Implement here the parallelized version of vector addition,

  !$omp parallel private(omp_rank,starttime,endtime)
  ! omp_rank = omp_get_thread_num()
  starttime=omp_get_wtime()
  !$omp do schedule(static)
  do i=1,nx
   vecC(i) = vecA(i) + vecB(i)
  end do  
  !$omp end do
  endtime=omp_get_wtime()
  write(*,*) endtime-starttime
  !$omp end parallel
  ! Compute the check value
  write(*,*) 'Reduction sum: ', sum(vecC)

end program vectorsum
