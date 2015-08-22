## CACHING THE INVERSE OF A MATRIX

## Introduction:

## The following user defined function-pair produce and cache 
## the inverse of an invertible (det != 0) square matrix (n x n). 

## Making the Cache Matrix:

## The following function creates a special 'matrix' object which 
## takes a matrix 'x' as an argument and then creates an environment 
## that enables both caching and retrieving the inverse of the input 
## matrix.  

## The function creates a list of 4 other functions in the global 
## environment/ user's workspace which provies following 
## functionality:

## 1. Set the value of the matrix - `set`
## 2. Get the value of the matrix - `get`
## 3. Set the value of the inverse matrix - `setinv`
## 4. Get the value of the inverse matrix - `getinv`

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

## The `cacheSolve` function solves for the inverse of the matrix 
## returned by `makeCacheMatrix` function above. Using an if-else 
## control structure, it first checks to see if the inverse matrix 
## has already been produced. If so, then, it skips the computation 
## and gets the inverse matrix from the cache via the `getinv`. 
## Otherwise, it computes the inverse of the original matrix 'x' 
## and stores the output in cache memory via the `setinv`.

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

## A Technical Notes:

## The inverse of a singular matrix, a matrix that has a determinant
## of zero (0), cannot be calculated. Inverse of a singular matrix is 
## not defined. R will produce the error, "system is exactly singular." 
## in such cases. It is advisable to use a non-singular matrix for 
## evaluation this assignment.

## Further Reading and Evaluation:

## A detailed write-up on construction and evaluation of this 
## script has been uploaded under the same repository in both PDF 
## and Markdown formats. The document discusses topics like Matrix
## Inversion, 'Solve' Function in R, Implication of Scoping Rules,
## Test Outputs and Evaluation etc. The document is uploaded by 
## the name of "SolutionManual." Please put a star on the repo
## if you like it. THANKS !