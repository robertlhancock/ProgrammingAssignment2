## Put comments here that give an overall description of what your
## functions do


## Upon calling makeCacheMatrix( x = matrix()) with a
## invertable matrix the value of the inverse will be stored for later retrieval.
## the ability to retrieve stored information is part of the exercise that demonstrates
## R's method of caching results of costly data operations where the dataset is large
## and the operation is costly.

## In the example below there exits a 3 by 3 invertable matrix identified by b.
## b is passed into the makeCacheMatrix function and its inverse is stored internal to the 
## resulting object abcd.
## abcd$y can be called to retrieve the value of the stored data.
## Also abcd$get() can be called to retrieve the value of the stored data.
## Conversely abcd$set( x) can be called to save another matrices inversion data to be retrieved later.
## 

## > b
##   [,1] [,2] [,3]
##   [1,]    1    0    4
##   [2,]    1    3    4
##   [3,]    4    1    0
##> abcd <- makeCacheMatrix(b)
##
##> abcd$get()
##  ##  [,1]        [,2]    [,3]
##  [1,]  0.08333333 -0.08333333  0.2500
##  [2,] -0.33333333  0.33333333  0.0000
##  [3,]  0.22916667  0.02083333 -0.0625
##
## create a new matrix named a by multiplying b * 10
## a<-b*10
##  > a
##  [,1] [,2] [,3]
##  [1,]   10    0   40
##  [2,]   10   30   40
##  [3,]   40   10    0
##
##
##> save the inverse of a
##> abcd$set(a)
##
##  get the inverse of a
##> abcd$get()
##  [,1]         [,2]          [,3]
##  [1,]  0.008333333 -0.008333333  2.500000e-02
##  [2,] -0.033333333  0.033333333 -2.018587e-18
##  [3,]  0.022916667  0.002083333 -6.250000e-03

## This function creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {

  ## Step 1 save the inverse of matrix x using solve()
  y <<- solve(x)
  
  ## Step 2 create a set function that takes as its argument
  ## matrix x and saves the inverse of it using solve().
  ## ## NOTE: This method is added for completeness and testing
  set <- function(x) {
    y <<- solve(x)
  
  }
  
  ## Step 3 create a get function that will return the value of inverse
  ## of matrix x. 
  get <- function() {
    y
  }
  

  
  ## Step 4, create a list of the objects exposed and return them to be 
  ## used in subsetting the resulting function
  ## we will expose the set, get and the matrix itself
  list(set = set, 
       get = get)

}

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  data <- x$get()
}
