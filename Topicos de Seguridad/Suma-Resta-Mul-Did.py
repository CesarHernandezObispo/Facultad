#! /usr/bin/env python3
# -*- coding: utf-8

print("Ingresa el primer numero")
numero1=int(input())

print("Ingresa el segundo numero")
numero2=int(input())

print("Ingresa el modulo de la operacion")
modulo=int(input())

print("Que operacion desea realizar")
operacion=input()

if operacion=="+":
    resultado=numero1+numero2
elif operacion=="-":
    resultado=numero1-numero2
elif operacion=="*":
    resultado=numero1*numero2
elif operacion=="/":
    while True:
        if numero1%numero2==0:
            break;
        print("(",numero1,"+",modulo,")/",numero2,end="\t")
        numero1=numero1+modulo
        resultado=int(numero1/numero2)

if resultado>modulo:
    while True:
        print(resultado,"-",modulo,"=",end="\t")
        resultado=resultado-modulo
        if resultado<modulo:
            break
elif resultado<0:
    while True:
        print(resultado,"+",modulo,"=",end="\t")
        resultado=resultado+modulo
        if resultado>0:       
            break

print("El resultado es:", (resultado%modulo))