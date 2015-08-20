<head>
    <script type="text/javascript"
            src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
    </script>
</head>

# Solution Manual: R-Programming Assignment 2
## Caching the Inverse of a Matrix

###Keywords
Control Structure, Lexical scoping, R-Environment, Inverse Matrix, Square Matrix, Singular Matrix

### Introduction:
The following user defined functions produce and cache the inverse of a square matrix (invertible by definition).

--in progress--

### Inverse Matrix

If $A$ is a square ($n * n$) and non-singular ($\det(A) \ne 0$) matrix then an inverse matrix of $A$ is denoted by $A^{-1}$ such that $AA^{-1}=A^{-1}A=I$; where $I$ is the identity matrix.

As only non-zero real numbers can have an inverse, in matrix algebra only non-singular square matrices have an inverse. Therefore, for $A$ to be invertible a matrix $A^{-1}$ must exist.

#####Example:

Consider the following 2 by 2 matrix:

$$\eqalign{
  & X = \left[ {\matrix{
   a & b  \cr 
   c & d  \cr 

 } } \right]  \cr 
  & {X^{ - 1}} = {\left[ {\matrix{
   a & b  \cr 
   c & d  \cr 

 } } \right]^{ - 1}} = {1 \over {ad - bc}}\left[ {\matrix{
   d & { - b}  \cr 
   { - c} & a  \cr 

 } } \right] \cr} $$

For the above square matrix $X$, an inverse $X^{-1}$ exists, only if $ad - bc \ne 0$. Also note that $(ad - bc)$ is the determinant of $X$.

One simple but necessary point to consider for this particular assignment is that the inverse of an invertible numatic matrix is as simple as dividing the identity matrix with the matrix itself, i.e., $X^{-1} X = I$ or, $X^{-1}$ $=$ $I \over X$.

### Inverse Matrix in R

There are several methods that can be used to calculate inverse of a matrix in R. For this assignment though the scope is confined to the `solve` function.

The `solve` function in R is typically used to solve a linear system. Following are the default arguments used:

```
solve(a, b, ...)

a : A square numeric or complex matrix containing the coefficients of the linear system.
b : A numeric or complex vector or matrix giving the right-hand side of the linear system.
... : Further arguments passed to or from other methods
```
This function basically solves the linear equation $a * x = b$ for $x$; where $b$ can be a matrix or a vector. The argument $b$ is also defined such that if it is not included as an argument in the function, it is assumed to be an identity matrix by R. This characteristic of $b$ allows the calculation on an inverse of $a$ by using the `solve(a)` function.

When $b$ is missing in the function the generic equation becomes $a*x=I$ or, $x =$ $I \over a$ $=a^{-1}$. Therefore, given that $a$ is an invertible square matrix, $x$ is simply the inverse of that matrix.


### Making the Cache Matrix

The following function creates a special "matrix' object that can cache its own "inverse matrix." The function takes a matrix input 'x' as an  argument and then creates an environment that can cache the inverse of that matrix.

--steps in progress--


```r
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
```

### Solving for the Inverse Matrix

The following function computes the inverse of the special "matrix" returned by `makeCacheMatrix` function above. It first checks to see if the inverse matrix has already been produced. If so, then, it skips the computation  and gets the inverse matrix from the cache. Otherwise, it calculates the inverse of the original matrix and sets the output in the cache via the `setinv` function.

--details on solve function in progress--


```r
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
```

### Test Outputs

#####1. 2 x 2 matrix


```r
source("cachematrix.R")
M <- makeCacheMatrix(matrix(10:13, 2, 2))
M$get()
```

```
##      [,1] [,2]
## [1,]   10   12
## [2,]   11   13
```

```r
M$getinv() # no data on inverse matrix is cached yet
```

```
## NULL
```

```r
cacheSolve(M)
```

```
##      [,1] [,2]
## [1,] -6.5    6
## [2,]  5.5   -5
```

```r
cacheSolve(M) # the data on inverse matrix is cached already
```

```
## getting cached data (inverse matrix)

##      [,1] [,2]
## [1,] -6.5    6
## [2,]  5.5   -5
```


#####2. 3 x 3 matrix


```r
source("cachematrix.R")
M <- makeCacheMatrix(matrix(c(20, 13, 9, 51, 18, 33, 9, 101, 47), 3, 3))
M$get()
```

```
##      [,1] [,2] [,3]
## [1,]   20   51    9
## [2,]   13   18  101
## [3,]    9   33   47
```

```r
M$getinv() # no data on inverse matrix is cached yet 
```

```
## NULL
```

```r
cacheSolve(M)
```

```
##              [,1]         [,2]         [,3]
## [1,]  0.077382619  0.065341174 -0.155231961
## [2,] -0.009272224 -0.026727652  0.059211550
## [3,] -0.008307664  0.006254084  0.009427798
```

```r
cacheSolve(M) # the data on inverse matrix is cached already
```

```
## getting cached data (inverse matrix)

##              [,1]         [,2]         [,3]
## [1,]  0.077382619  0.065341174 -0.155231961
## [2,] -0.009272224 -0.026727652  0.059211550
## [3,] -0.008307664  0.006254084  0.009427798
```


#####3. 4 x 4 matrix


```r
source("cachematrix.R")
M <- makeCacheMatrix(matrix(c(15, 11, 34, 50, 19, 68, 44, 12, 30, 11, 56, 98, 88, 1, 26, 10), 4, 4))
M$get()
```

```
##      [,1] [,2] [,3] [,4]
## [1,]   15   19   30   88
## [2,]   11   68   11    1
## [3,]   34   44   56   26
## [4,]   50   12   98   10
```

```r
M$getinv() # no data on inverse matrix is cached yet 
```

```
## NULL
```

```r
cacheSolve(M)
```

```
##              [,1]         [,2]         [,3]         [,4]
## [1,] -0.085666715 -0.179583600  0.357613044 -0.157968463
## [2,]  0.006943442  0.029508340 -0.028894926  0.011073682
## [3,]  0.041815295  0.088620384 -0.179581022  0.090074022
## [4,]  0.010211551 -0.005971773  0.006502711 -0.006171519
```

```r
cacheSolve(M) # the data on inverse matrix is cached already
```

```
## getting cached data (inverse matrix)

##              [,1]         [,2]         [,3]         [,4]
## [1,] -0.085666715 -0.179583600  0.357613044 -0.157968463
## [2,]  0.006943442  0.029508340 -0.028894926  0.011073682
## [3,]  0.041815295  0.088620384 -0.179581022  0.090074022
## [4,]  0.010211551 -0.005971773  0.006502711 -0.006171519
```


### A Technical Note:

The inverse of a singular matrix, a matrix that incurs a determinant of zero (0), cannot be calculated. Inverse of a singular matrix is not defined. R will produce the error, "system is exactly singular." in such cases. It is advisable to use a non-singular matrix for evaluating this exercise.

Example:


```r
source("cachematrix.R")
M <- makeCacheMatrix(matrix(1:16, 4, 4))
M$get()
```

```
##      [,1] [,2] [,3] [,4]
## [1,]    1    5    9   13
## [2,]    2    6   10   14
## [3,]    3    7   11   15
## [4,]    4    8   12   16
```

```r
det(M$get()) # determinant of the singular matrix
```

```
## [1] 0
```

The `cacheSolve` function will produce the following error message:

```
> cacheSolve(M)

 Error in solve.default(data, ...) : 
  Lapack routine dgesv: system is exactly singular: U[3,3] = 0 
```
