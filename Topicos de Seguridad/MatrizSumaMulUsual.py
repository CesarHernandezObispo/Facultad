#!/usr/bin/env python3
# -*- coding: utf-8

isAPrimeNumber=False

print("Please enter a number: ",end=" ")
number=int(input())

for n in range ((number-1), 2,-1):
    if number%n==0:
        isAPrimeNumber=True
        print("It is not a prime number")
        break

if isAPrimeNumber==False:
    print("Fp={ ",end="")
    for n in range (0,number-1,+1):
        print(n,end=", ")
    print(number-1,"}")

    columns=number
    rows=number

    array=[[0] * columns for i in range(rows)]
    array2=[[0] * (columns-1) for i in range(rows-1)]

    print("\nModular Addition")
    for row in range(0,rows,+1):
        for column in range(0,columns,+1):
            array[row][column]=(row+column)%number
    print(array)

    print("\nModular Multiplication")
    for row in range(0,rows-1,+1):
        for column in range(0,columns-1,+1):
            array2[row][column]=((row+1)*(column+1))%number
    print(array2)