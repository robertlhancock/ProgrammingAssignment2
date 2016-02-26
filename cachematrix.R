
## Upon calling makeCacheMatrix( x = matrix()) with a
## invertable matrix the value of the matrix will be stored for later retrieval.
## the ability to retrieve stored information is part of the exercise that demonstrates
## R's method of caching results of costly data operations where the dataset is large
## and the operation is costly.

## In the example below there exits a 3 by 3 invertable matrix identified by b.
## b is passed into the makeCacheMatrix function and is stored internal to the 
## resulting object abcd.
## 
## ## b <- matrix( c( 1,0,4,1,3,4,4,1,0), 3, 3)
## > abcd <- makeCacheMatrix(b)
## > abcd$getMatrix()
##      [,1] [,2] [,3]
## [1,]    1    1    4
## [2,]    0    3    1
## [3,]    4    4    0
## > abcd$isInverted()
## [1] FALSE
## > cacheSolve(abcd)
##             [,1]       [,2]        [,3]
## [1,]  0.08333333 -0.3333333  0.22916667
## [2,] -0.08333333  0.3333333  0.02083333
## [3,]  0.25000000  0.0000000 -0.06250000
## > abcd$getMatrix()
##             [,1]       [,2]        [,3]
## [1,]  0.08333333 -0.3333333  0.22916667
## [2,] -0.08333333  0.3333333  0.02083333
## [3,]  0.25000000  0.0000000 -0.06250000
## > abcd$isInverted()
## [1] TRUE

## abcd$isInverted can be called to retrieve an indicator that the matrix stored is the inverted value.
## 
## abcd$getMatrix() can be called to retrieve the value of the stored data.
## 
## Conversely abcd$setInvertedMatrix( x) can be called to save another matrices inversion data to be retrieved later.
## setInvertedMatrix(x) will clear the inverted indicator to TRUE
## 


## This function creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {

  ## Step 1 save the matrix x and set the inverted indicator
  isInvertedInd <<- FALSE
  thisMatrix <<- x
  
  ## Step 2 create a setMatrix function that takes as its argument
  ## matrix x and saves it. Reset the inverted indicator
  setMatrix <- function(x) {
    thisMatrix <<- x
    isInvertedInd <<- FALSE
  
  }
  

  ## Step 3 create a getMatrix function that will return the value of the matrix
  ## of matrix x. 
  getMatrix <- function() {
    thisMatrix
  }
  
  ## Step 4. set an inverted matrix
  setInvertedMatrix <- function( x){
    thisMatrix <<- x
    isInvertedInd <<- TRUE
  }
  
  ## Step 5. test the inverted indicator
  isInverted <- function(){
    return(isInvertedInd)
  }
  
  ## Step 6, create a list of the objects exposed and return them to be 
  ## used in subsetting the resulting function
  ## we will expose the setMatrix, getMatrix, setInvertedMatrix and the inverted indicator itself
  list(setMatrix = setMatrix,
       setInvertedMatrix = setInvertedMatrix, 
       getMatrix = getMatrix,
       isInverted = isInverted
       )

}

## cacheSolve: Perform an operation on a cached matrix to solve it if necessary.
## 1. Check to see if the cache matrix is inverted. 
## 2. If the matrix is inverted return it
## 3. otherwise get the cached matrix.
## 4. call solve() on the matrix to invert it.
## 5. save the resulting inverted matrix back to the cache
## 6. return the inverted matrix
cacheSolve <- function(x, ...) {
  
  ## 1. Check to see if "x" is inverted.
  if(x$isInverted()) {
    ## 2. return inverted matrix
     return( x$getMatrix())
  }
  ## 3. get the cached matrix
  data <- x$getMatrix()
  
  ## 4. use solve() to get the matrix inverted.
  m <- solve(data, ...)
  
  ## 5. cache the inverted matrix back to "x"
  x$setInvertedMatrix(m)
  
  ## 6. return the inverted matrix
  return( m)
}
