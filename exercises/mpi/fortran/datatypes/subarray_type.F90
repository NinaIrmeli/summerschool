program datatype2

  use mpi

  implicit none

  integer, dimension(8,8) :: array
  integer :: rank, ierr
  !TODO: declare variable for block datatype
  integer :: arraytype
  integer, dimension(2) :: sizes, subsizes, offsets
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

  !TODO: create a datatype for a subblock [2:5][3:5] of the 8x8 matrix
  sizes(1) = 8
  sizes(2) = 8
  subsizes(1) = 4
  subsizes(2) = 3
  offsets(1) = 2 
  offsets(2) = 3

  call MPI_Type_create_subarray(2,sizes,subsizes,offsets,MPI_order_fortran,MPI_integer,arraytype,ierr)
  call MPI_type_commit(arraytype,ierr)

  !TODO: send a block of a matrix from rank 0 to rank 1

  if (rank.eq.0) then
    call MPI_send(array,1,arraytype,1,1,MPI_comm_world,ierr)
  else if (rank.eq.1) then
    call MPI_recv(array,1,arraytype,0,1,MPI_comm_world,ierr)
  end if


  ! Print out the result
  if (rank == 1) then
     do i=1,8
        write(*,'(8I3)') array(i, :)
     end do
  end if
      
  !TODO: free mpi datatype	
  call MPI_type_free(arraytype,ierr)
  call mpi_finalize(ierr)

end program datatype2
