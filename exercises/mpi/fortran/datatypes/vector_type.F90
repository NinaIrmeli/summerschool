program datatype1
  use mpi
  implicit none

  integer, dimension(8,8) :: array
  integer :: rank, ierr
  !TODO: declare variable for datatype
  integer :: rowtype
  integer :: i, j

  call mpi_init(ierr)
  call mpi_comm_rank(MPI_COMM_WORLD, rank ,ierr)

  ! initialize arrays
  if (rank == 0) then
     do i=1,8
        do j=1,8
           array(i,j) = i*10 + j
        end do
     end do
  else
     array(:,:) = 0
  end if

  !TODO: create datatype describing one row, use mpi_type_vector
  call MPI_type_vector(8,1,8,MPI_integer,rowtype,ierr)   
  call MPI_type_commit(rowtype,ierr)

  !TODO: send first row of matrix from rank 0 to 1
  if (rank.eq.0) then
  call MPI_send(array,1,rowtype,1,1,mpi_comm_world,ierr)
  else if (rank.eq.1) then
  call MPI_recv(array,1,rowtype,0,1,mpi_comm_world,MPI_status_ignore,ierr)
  end if
 
  ! Print out the result
  if (rank == 1) then
     do i=1,8
        write(*,'(8I3)') array(i, :)
     end do
  end if

  !TODO free datatype
  call MPI_type_free(rowtype,ierr)


  call mpi_finalize(ierr)

end program datatype1
