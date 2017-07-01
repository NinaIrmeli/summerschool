program exchange
  use mpi
  implicit none
  integer, parameter :: size = 100
  integer :: rc, myid, ntasks, count
  integer :: status(MPI_STATUS_SIZE)
  integer :: message(size)
  integer :: receiveBuffer
  integer :: vecA(100000) ,vecB(100000), recvec

  vecA(:)=0
  vecB(:)=1


  call mpi_init(rc)
  call mpi_comm_rank(MPI_COMM_WORLD, myid, rc)
  call mpi_comm_size(MPI_COMM_WORLD, ntasks, rc)

!  message = myid
  ! TODO: Implement sending and receiving as defined in the assignment

   
  if ( myid == 0 ) then
  call MPI_send(vecA,size,MPI_integer,1,10,MPI_comm_world,rc)
  call MPI_recv(recvec,size,MPI_integer,1,11,MPI_comm_world,status,rc)
     write(*,'(A10,I3,A10,I3)') 'Rank: ', myid, &
          ' received ', recvec

  else if (myid == 1) then
  call MPI_send(vecB,size,MPI_integer,0,11,MPI_comm_world,rc)
  call MPI_recv(recvec,size,MPI_integer,0,10,MPI_comm_world,status,rc)

     write(*,'(A10,I3,A10,I3)') 'Rank: ', myid, &
          ' received ', recvec
  end if



  call mpi_finalize(rc)

end program exchange
