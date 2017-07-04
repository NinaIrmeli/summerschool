program hello
  use mpi
  implicit none
  integer :: rc
  integer :: comm,rank,omp_rank,nr

  call MPI_Init(rc)
  call MPI_Comm_rank(MPI_COMM_WORLD,rank,rc)
  call MPI_Comm_size(mpi_comm_world,nr,rc)
 
  !$omp parallel
    omp_rank=omp_get_thread_num()
    print *, 'Hello world! from rank:' ,rank, 'Thread: ',omp_rank
  !$omp end parallel
    if (rank.eq.0) print *,'Total nr of rank' 

  call MPI_Finalize(rc)


end program hello
