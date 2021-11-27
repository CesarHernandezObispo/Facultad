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

'''if isAPrimeNumber==False:
    print("Fp={ ",end="")
    for n in range (0,number-1,+1):
        print(n,end=", ")
    print(number-1,"}")'''
