program hello
  use omp_lib
  implicit none
  integer :: thrd_id, nthreads

  print *, 'Hello world!'
  !$omp parallel
  nthreads=omp_get_num_threads()
  thrd_id=omp_get_thread_num()
  !$omp master
   write(*,*) 'Number of threads: '
    write(*,*) nthreads
  !$omp end master
  print *,'Thread id'
  print *, thrd_id
  print *, 'X'
  !$omp end parallel

end program hello
