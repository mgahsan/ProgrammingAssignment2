## PROGRAMMING ASSIGNMENT 2: LEXICAL SCOPING ##
## CACHING THE INVERSE OF A MATRIX ##

## Introduction:

## This programming exercise is useful to address time
## consuming computations in R. Computing inverse of a matrix
## can be costly when it needs to be done mutliple times when
## solving for a linear system or even when using it in a loop.
## The following user defined function-pair produces the inverse 
## of an invertible (det != 0) square matrix (n x n) and then
## caches it in memory for future use.

## The Cache Matrix:

## The following function creates a special 'matrix' object which 
## takes an invertible matrix 'x' as an argument and then creates an 
## environment that enables both caching and retrieving the inverse 
## of the input matrix.  

## The function `makeCacheMatrix' is defined in the global environment 
## (workspace). A list of 4 other functions has been created inside it
## for which the defining environment is the inside of the host function.
## The parent for this child environment is the global environment. 
## These 4 functions provide the following functionality:

## 1. Set the value of the matrix - `set`
## 2. Get the value of the matrix - `get`
## 3. Set the value of the inverse matrix - `setinv`
## 4. Get the value of the inverse matrix - `getinv`

makeCacheMatrix <- function(x = matrix()) {
       
        IM <- NULL
        
        ## Creating the subfunctions
        
        set <- function(y) {
                x <<- y
                IM <<- NULL
        }
        get <- function() x
        setinv <- function(inv) IM <<- inv
        getinv <- function() IM
        
        ## Storing the functions into a list

        list(set = set, get = get, setinv = setinv, getinv = getinv)
}

## Solving for the Inverse Matrix:

## The `cacheSolve` function solves for the inverse of the matrix 
## returned by `makeCacheMatrix` function above. Using an if-else 
## control structure, it first checks to see if the inverse matrix 
## has already been produced. If so, then, it skips the computation 
## and returns the inverse matrix from the cache via `getinv` function. 
## Otherwise, it gets the data on the original matrix 'x' via 'get', 
## computes the inverse of 'x' using 'solve' function, stores the 
## output in cache memory via `setinv` function, and then prints 
## the output.

##`cachesolve` is also defined in the global environment (workspace).

cacheSolve <- function(x, ...) {
        
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

## Scoping Rules:

## R will create a temporary environment inside of 'makeCacheMatrix'
## function everytime the function will be called. For any function
## or a free variable inside that environment, R will first try to
## find a value inside the environment itself and then step up to its
## parent environment which, in this case, is the global environment.
## For this script under discussion, everything other than the `solve`
## function is defined within the above two enviroments. For the solve
## function the defining environment (top-level) is the base package.
## Generally, if the search reaches the global environment and a value 
## could not be found, R will then search through its search list until
## it reaches the empty environment. Each item in the search list is 
## an environment. The search list is designed in a way that each item
## is followed by its parent environment. The base environment is the
## last item in R search list and its parent is the empty environment. 
## Empty environment does not have a parent. Global, Base and Empty 
## are system environments in R.

## Use the following R functions to check for environments:

## ls(), ls.str() - lists objects inside an environment
## environment() - returns the name of the environment 
## parent.env() - returns the parent environment of an environment

## Example: if a special matrix 'M' is created by the makeCacheMatrix` 
## function then:

## ls(environment(makeCacheMatrix)): "makeCacheMatrix","cacheSolve","M"
## ls(environment(M$get)): "set", "get", "setinv", "getinv", "IM", "x"
## environment(makeCacheMatrix): <environment: R_GlobalEnv>
## environment(M$get): <environment: 0x0000000007658c40> 
## parent.env(environment(M$get)): <environment: R_GlobalEnv>
## Parent.env(baseenv()): <environment: R_EmptyEnv>

## Evaluation Algorithm:

## 1. Run a matrix input though 'makeCacheMatrix' and store the
##    special matrix in an R object
## 2. Run the R object through 'cacheSolve' to cache and print
##    the inverse matrix
## 3. Retrieve the cached data using 'cacheSolve' again

## A Technical Notes:

## The inverse of a singular matrix, a matrix that has a determinant
## of zero (0), is not defined and cannot be computed. R will produce
## the error, "system is exactly singular" in such cases. It is 
## advisable to use a non-singular matrix for evaluation this assignment.

## Further Reading and Evaluation:

## A detailed write-up on construction and evaluation of this 
## script has been uploaded under the same repository in both PDF 
## and Markdown formats. The document discusses topics like Matrix
## Inversion, 'Solve' Function in R, Implication of Scoping Rules,
## How the system of functions work, Test Outputs and Evaluation etc. 
## The document is uploaded by the name of "SolutionManual." Please 
## put a star on the repo if you like it. THANKS !