#!/usr/bin/env python3
# -*- coding: utf-8 

def unicode_exp(exp):
    if exp == 1:
       return chr(0xB9)
    if exp == 2 or exp == 3:
       return chr(0xB0 + exp)
    else:
       return chr(0x2070 + exp)

print("Enter the polynomial order: ",end="")
orderOfThePolynomial=int(input())

numberOfElements=pow(2,orderOfThePolynomial)
arr=[]
number=""

for n in range (0,numberOfElements,+1):
    for p in range (0,((len(bin(numberOfElements)[2:]))-(len(bin(n)[2:])))-1,+1):
        number+="0"                                                   
    number+=(bin(n)[2:])
    arr.append(number)
    number=""

for n in range (1,numberOfElements,+1):
    for p in range (0,len(bin(numberOfElements-1)[2:]),+1):
        if str(arr[n][p])=="1" and p!=len(arr[n])-1:
            print("Z{}".format(unicode_exp((orderOfThePolynomial-p)-1)),sep="",end="")
            for j in range (p+1,len(bin(numberOfElements-1)[2:]),+1):
                if arr[n][j]=="1":
                    print(end="+")
                    break
        elif str(arr[n][p])=="1":
            print("1",end="")
    print()