#!/usr/bin/env python3
# -*- coding: utf-8

diccionario=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y',
             'z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X',
             'Y','Z','0','1','2','3','4','5','6','7','8','9','.',',',';',':','-','_','/','\\','(',')','[',']','{',
             '}',' ']

dicLetraTextoPlano=[]

dicNumTextoCifrado=[]
dicLetraTextoCifrado=[]
dicLetraTextoPlanoFinal=[]
n=77
e=7
d=43

textoplano=input("Ingresa un mensaje: ")

for letra in textoplano:
    for dic in diccionario:
        if(letra==dic):
            dicLetraTextoPlano.append(diccionario.index(letra))
            dicNumTextoCifrado.append((pow(diccionario.index(letra),e)%n))
            break

print("Matriz Texto Plano")
print(dicLetraTextoPlano)

print("Matriz Texto Cifrado")
print(dicNumTextoCifrado)


for letra in range (len(dicNumTextoCifrado)):
    
    mpotenciae=pow(diccionario.index(textoplano[letra]),e)
    moduloM=mpotenciae%n
    print("{0}: {1} \tm**e={2} mod {3}={4} \tLetra: {5}".format(textoplano[letra],dicLetraTextoPlano[letra],mpotenciae,n,moduloM,diccionario[moduloM]))

for num in dicNumTextoCifrado:
    dicLetraTextoCifrado.append(diccionario[num])

print("Letras de texto cifrado")
print(dicLetraTextoCifrado)


for letra in dicLetraTextoCifrado:
    for dic in diccionario:
        if(letra==dic):
            dicLetraTextoPlanoFinal.append(diccionario[(pow(diccionario.index(letra),d)%n)])

for letra in range (len(dicNumTextoCifrado)):
    
    mpotenciae=pow(diccionario.index(dicLetraTextoCifrado[letra]),d)
    moduloM=mpotenciae%n
    print("{0}: {1} \tc**d={2} mod {3}={4} \tLetra: {5}".format(dicLetraTextoCifrado[letra],dicNumTextoCifrado[letra],mpotenciae,n,moduloM,diccionario[moduloM]))



print("Texto descifrado")
print(dicLetraTextoPlanoFinal)