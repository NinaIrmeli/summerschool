program hello
  use mpi
  implicit none
  integer :: rc
  integer :: comm,rank,nr

  call MPI_Init(rc)
  call MPI_Comm_rank(MPI_COMM_WORLD,rank,rc)
  call MPI_Comm_size(mpi_comm_world,nr,rc)
  print *, 'Hello world! from rank:' ,rank
  if (rank.eq.0) print *,'Total nr of ranks: ',nr 

  call MPI_Finalize(rc)


end program hello
