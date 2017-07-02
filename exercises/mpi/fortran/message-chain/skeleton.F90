program basic
  use mpi
  use iso_fortran_env, only : REAL64

  implicit none
  integer, parameter :: size = 100
  integer :: rc, myid, ntasks, count,dest,source
  integer :: status(MPI_STATUS_SIZE,2), requests(2)
  integer :: message(size)
  integer :: recbuffer(size)

  real(REAL64) :: t0, t1 

  call mpi_init(rc)
  call mpi_comm_rank(MPI_COMM_WORLD, myid, rc)
  call mpi_comm_size(MPI_COMM_WORLD, ntasks, rc)

  message = myid

  ! Start measuring the time spent in communication
  call mpi_barrier(mpi_comm_world, rc)
  t0 = mpi_wtime()

  ! TODO: Send and receive as defined in the assignment


  if ( myid < ntasks-1 ) then
    dest = myid+1
  else
    dest=MPI_proc_null
  end if
  if (myid>0) then
    source=myid-1
  else
    source=MPI_proc_null
  end if
 
  call MPI_Irecv(recbuffer,size,MPI_integer,source,myid,MPI_comm_world,requests(2),rc)
  call MPI_Isend(message,size,MPI_integer,dest,myid+1,MPI_comm_world,requests(1),rc)

     call MPI_waitall(2,requests,status,rc)

!  write(*,'(A10,I3,A10,I3)') 'Sender: ', myid, 'Message: ', message(0)
  write(*,'(A10,I3,A15,I3,A15,I3,A15,I3)') 'Sender:', myid, 'Message: ', message(0), &
                          'Receiver: ', myid, ' First element: ', recbuffer(1)
  

!  write(*,*) 'Reciever: '
 !    write(*,'(A10,I3,A,I3)') 'Receiver: ', myid, &
 !         ' First element: ', recbuffer(1)
 
  ! Finalize measuring the time and print it out
  t1 = mpi_wtime()
  call mpi_barrier(mpi_comm_world, rc)
  call flush(6)

  write(*, '(A20, I3, A, F6.3)') 'Time elapsed in rank', myid, ':', t1-t0

  call mpi_finalize(rc)

end program basic
