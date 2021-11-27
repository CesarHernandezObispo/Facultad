#!/usr/bin/env python3

# -*- coding: utf-8


pmenos1=0

vectorValoresQ=[]

dicAlfabeto=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s']

dicNumPosMensaje=[]
DicC2=[]

dicNumPosMensajeDescifrado=[]

p=int(input("Ingresa el valor de p: "))

pmenos1=p-1


i=2

while i<=p-1:

    if pmenos1%i==0:

        vectorValoresQ.append(i)

        pmenos1=pmenos1/i

        i=i-1

    i=i+1


print("Valores posibles para q ",vectorValoresQ)


q=int(input("Ingresa el valor de q: "))


h=int(input(("Ingresa un valor de h que se encuentre entre [1,{0}]: ".format((p-1)))))


g=(pow(h,((p-1)/q)))%p


print("Valores p={0}, q={1}, g={2}".format(p,q,g))


print("Generacion de llaves")


print("Posibles valores de para la llave privada [1,{0}]: ".format(q-1))

x=int(input("Ingresa el valor de la llave privada: "))

y=(pow(g, x))%p


print("Llave privada X: ",x)

print("Llave publica Y: ",y)

mensaje=input("Ingresa el mensaje a cifrar: ")

k=int(input("Ingresa el valor de k [1,{0}]".format(q-1)))

for letraMensaje in mensaje:

    for letra in dicAlfabeto:

        if(letra==letraMensaje):
            dicNumPosMensaje.append(dicAlfabeto.index(letraMensaje))
            break


C1=(pow(g,k))%p


print(dicNumPosMensaje)


for m in dicNumPosMensaje:
    DicC2.append(int((m*pow(y,k))%p))

print(DicC2)

for C2 in DicC2:
    #dicNumPosMensajeDescifrado.append((C2*(C1**(-X)))%p)
    m=int((C2*pow(C1,((-x)%q)))%p)
    dicNumPosMensajeDescifrado.append(m)

print(dicNumPosMensajeDescifrado)

for posletra in dicNumPosMensaje:
    print(dicAlfabeto[posletra])