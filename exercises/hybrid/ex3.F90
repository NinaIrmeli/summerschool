program hello
  use mpi
  implicit none
  integer :: rc
  integer :: comm,rank,omp_rank,nr,omptag
  integer :: size=1
  integer :: sendbuf(2),recvbuf(2)
  integer :: status


  call MPI_Init(rc)
  call MPI_Comm_rank(MPI_COMM_WORLD,rank,rc)
  call MPI_Comm_size(mpi_comm_world,nr,rc)

  if (rank.eq.0) print *,'Total nr of ranks: ',nr

  !$omp parallel private(omp_rank,omptag)
    omp_rank=omp_get_thread_num()
    omptag=1000+omp_rank

    if (rank.eq.0) then
    else
      sendbuf=(/rank,omp_rank/)
    end if

    call MPI_sendrecv(sendbuf,size,MPI_integer,rank+1,omptag, &
                      recvbuf,size,MPI_integer,rank-1,omptag,MPI_comm_world,status,rc)

    write(*,*) 'Rank', rank, 'thread', omp_rank, 'Sending: ', sendbuf, &
               'Receiving: ', recvbuf
  !$omp end parallel

  call MPI_Finalize(rc)


end program hello
