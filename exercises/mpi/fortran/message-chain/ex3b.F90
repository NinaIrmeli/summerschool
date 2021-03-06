program basic
  use mpi
  use iso_fortran_env, only : REAL64

  implicit none
  integer, parameter :: size = 100
  integer :: rc, myid, ntasks, count
  integer :: status(MPI_STATUS_SIZE)
  integer :: message(size)
  integer :: recbuffer(size)
  integer :: i(5),j(5)

  real(REAL64) :: t0, t1 

  call mpi_init(rc)
  call mpi_comm_rank(MPI_COMM_WORLD, myid, rc)
  call mpi_comm_size(MPI_COMM_WORLD, ntasks, rc)

  message = myid

  ! Start measuring the time spent in communication
  call mpi_barrier(mpi_comm_world, rc)
  t0 = mpi_wtime()

  ! TODO: Send and receive as defined in the assignment
  if ( myid .ge. 1 .and. myid .le. ntasks-2 ) then
    call MPI_sendrecv(message,size,MPI_integer,myid+1,myid+1,recbuffer,size,MPI_integer,myid-1,myid,MPI_comm_world,status,rc)
     write(*,'(A10,I3,A20,I8,A,I3,A,I3)') 'Sender: ', myid, &
          ' Sent elements: ',size, &
          '. Tag: ', myid+1, '. Receiver: ', myid+1          

  end if


  if (myid.eq.0) then
    call MPI_send(message,size,MPI_integer,myid+1,myid+1,MPI_comm_world,rc)
     write(*,'(A10,I3)') 'Sent elements: ', myid+1
        
  end if


  if (myid.eq.ntasks-1) then 
    call MPI_recv(recbuffer,size,MPI_integer,ntasks-2,ntasks-1,MPI_comm_world,status,rc)
      write(*,'(A10,I3,A,I3)') 'Receiver: ', myid, &
          ' First element: ', recbuffer(1)
 end if



  ! Finalize measuring the time and print it out
  t1 = mpi_wtime()
  call mpi_barrier(mpi_comm_world, rc)
  call flush(6)

  write(*, '(A20, I3, A, F6.3)') 'Time elapsed in rank', myid, ':', t1-t0

  call mpi_finalize(rc)

end program basic
