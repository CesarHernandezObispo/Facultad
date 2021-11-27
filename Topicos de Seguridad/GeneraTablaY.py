#!/usr/bin/env python3
# -*- coding: utf-8 


print("Ingresa el valor del campo ")
campo=int(input())

tabla=[0]*campo
array=[0]*campo

print()

for i in range (0,(campo),+1):
    #print(i,"\t",(pow(i,2)%campo))
    tabla[i]=(pow(i,2)%campo)

print()

for j in range (0,(campo),+1):
    #print("X=",j," :",(((pow(j,3))+(2*(j))+4)%campo))
    array[j]=(((pow(j,3))+((j))+27)%campo)
    print("X=",j)
    print("y**2 = ",pow(j,3),"+",j,"27")
    print("=",((pow(j,3))+((j))+27))
    print("=",((pow(j,3))+((j))+27)%campo)
    print("\n\n")
#y
print(tabla)

# y2
print(array)



