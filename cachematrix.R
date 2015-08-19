## CACHING THE INVERSE OF A MATRIX

## Introduction:

## The following user defined functions produce and cache the inverse of a 
## square matrix (invertible by definition). 

## Making the Cache Matrix:

## The following function creates a special "matrix' object that can cache
## its own "inverse matrix." The function takes a matrix input 'x' as an 
## argument and then creates an environment that can cache the inverse of 
## that matrix.

makeCacheMatrix <- function(x = matrix()) {
       
        IM <- NULL
        set <- function(y) {
                x <<- y
                IM <<- NULL
        }
        
        get <- function() x
        setinv <- function(inv) IM <<- inv
        getinv <- function() IM
        list(set = set, get = get, setinv = setinv, getinv = getinv)
}

## Solving for the Inverse Matrix:

## The following function computes the inverse of the special "matrix" 
## returned by 'makeCacheMatrix' function above. It first checks to see 
## if the inverse natrix has already been produced. If so, then, it skips 
## the computation  and gets the inverse matrix from the cache. Otherwise, 
## it calculates the inverse of the original matrix and sets the output
## in the cache via the 'setinv' function.

cacheSolve <- function(x, ...) {
        
        ## Return a matrix that is the inverse of 'x'
        
        IM <- x$getinv()
        
        if(!is.null(IM)) {
                message("getting cached data (inverse matrix)")
                return (IM)
        }
        
        data <- x$get()
        IM <- solve(data, ...)
        x$setinv(IM)
        IM
}

## Technical Notes:

## 1.
## The inverse of a singular matrix, a matrix that incurs a determinant
## of zero (0), cannot be calculated. Inverse of a singular matrix is not 
## defined. R will produce the error, "system is exactly singular." in
## such cases. It is adviceable to use a non-singular matrix for evaluating 
## this excercise.

## 2.
## A seperate markdown file describing the functionality and test results
## for this script has been uploaded to the repository for further reference.