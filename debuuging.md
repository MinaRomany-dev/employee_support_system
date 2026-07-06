# bug_printStudents


## identify :-

the function `printBooks`  return unexpected output but return error 

## Reproduce :-

when try alot of inputs  return unexpected output

## analysis :-
the function `printBooks`  return unexpected output because `calculateTotalPrice` access element of list but  out of range and 
 when check `printBooks`  not identify index of array  ("Book:", books.title) , ("Book:", books.price)

## fix :-
prevent function that named `calculateTotalPrice` access element out of range using < lenght instead of <=
and make `printBooks` to identify index of array such as  ("Book:", books[i].title) and ("Book:", books[i].price)

## verify :-





