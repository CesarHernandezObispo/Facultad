#!/usr/bin/env python3
# -*- coding: utf-8 
import sympy

#.as_expr()
# Funcion para imprimir Potencias en la consola.
def unicode_exp(exp):
    if exp == 1:
       return chr(0xB9)
    if exp == 2 or exp == 3:
       return chr(0xB0 + exp)
    else:
       return chr(0x2070 + exp)

#Funcion que aplica modulo 2
def moduloDos(polinomio):
    # Obtiene el coeficiente maximo de entre todos los coeficientes del polinomio
    t = (max(polinomio.coeffs()))
    # Calcula si el coeficiente mayor tiene modulo 2 o no. Sino tiene lo hace modulo 2.
    t= t if t%2==0 else t+1
    # Cambia los modulos 2 por 0
    varr=sympy.Poly(polinomio.subs(2*Z,0),Z)
    # Cambia los modulos 2 que den 1 por Z solamente
    for n in range(1,t+1,+2):
        varr=sympy.Poly(varr.subs(n*Z,Z),Z)
    # Recorre todos los coeficientes del polinomio 
    # Valida los terminos independientes 
    for coeficiente in (varr.coeffs()):
    # Si alguno es igual a 2
        #if coeficiente==2:
        if coeficiente%2==0:
    # Le resta el valor de la variable polyDos 
            varr=varr-(sympy.Poly(coeficiente,Z))
        if coeficiente%2==1 and coeficiente>2:
            varr=varr-(sympy.Poly(coeficiente-1,Z))
    return varr

#Creacion de la estructura base de polinomios para sympy
def crearPolinomioSympy(polinomioBinario):
    polinomioResultante=""
    if polinomioBinario==0:
        polinomioResultante="0"
    elif polinomioBinario==1:
        polinomioResultante="1"
    else:
        for posicion in range(0,(len(bin(polinomioBinario)[2:])),+1):
            if str(bin(polinomioBinario)[2:])[posicion]=="1" and posicion!=len(bin(polinomioBinario)[2:])-1:
                polinomioResultante +="Z**{}".format((len(bin(polinomioBinario)[2:])-posicion-1))
                for j in range(posicion+1,len(bin(polinomioBinario)[2:]),+1):
                    if (bin(polinomioBinario)[2:])[j]=="1":
                        polinomioResultante +=" + "
                        break
            elif posicion==(len(bin(polinomioBinario)[2:]))-1 and str(bin(polinomioBinario)[2:])[len(bin(polinomioBinario)[2:])-1]=="1":
                polinomioResultante +="1"
    return polinomioResultante

#Funcion que aplica modulo Irreducible a polinomios que no se encuentren en el campo definido Z
def moduloPolinomioIrreducible(polinomio,polinomioIrreducibleSympy):
    validacion=False
    # Recorre todo el campo Zp
    for zx in ZpSympy:
        # Si el polinomio al que deseamos aplicar modulo el polinomio Irreducible 
        # Se encuentra en el campo Z no se le aplicara modulo
        if polinomio==zx:
            polyResultante=sympy.Poly(polinomio,Z)
            validacion=True
    # Sino esta en Zp si se le aplica el modulo.
    if validacion==False:
        polyResultante=sympy.Poly(moduloDos((polinomio%polinomioIrreducibleSympy))).abs()
    return polyResultante

#Sympy
sympy.init_printing()
Z=sympy.symbols('Z')
ZpSympy=[]

#Construir el campo Zp
cantidadDeElementosCampoZ=0
Zp=[]

# Curva Eliptica
tipoDeCurvaE=0
validacionA=False
validacionB=False
validacionC=False
validacionDiscriminante=False
validacionY2=False
validacionX=False
arregloPolinomioY2=[]
arregloPolinomiosX=[]
validaOrden=False

#Contadores
contadorX=0
contadorY=0

gradoPolinomio=int(input("Ingresa el grado del polinomio: "))
cantidadDeElementosCampoZ=pow(2,gradoPolinomio)
paresOrdenados=[[],[]]
puntosP=[[],[]]
Zp=[bin(z)[2:] for z in range(cantidadDeElementosCampoZ)]

for z in Zp:
    ZpSympy.append(sympy.Poly(crearPolinomioSympy(int(z,2)),Z))
print(ZpSympy)

# Polinomio Irreducible E 
while True:
    polinomioIrreducible=int(input("\nPolinomio Irreducible Formato[1101] -> X{}+X{}+1: ".format(unicode_exp(3),unicode_exp(2))),2)
    polinomioIrreducibleSympy=sympy.Poly(crearPolinomioSympy(polinomioIrreducible))
    print(crearPolinomioSympy(polinomioIrreducible))

    print("Polinomio evaluado en 0: ",(int(polinomioIrreducibleSympy.subs(Z,0))%2))
    print("Polinomio evaluado en 1: ",(int(polinomioIrreducibleSympy.subs(Z,1))%2))
    print("Orden del Polinomio Irreducible ",len(bin(polinomioIrreducible)[2:])," orden del campo",gradoPolinomio)
    if len(bin(polinomioIrreducible)[2:])>gradoPolinomio and (int(polinomioIrreducibleSympy.subs(Z,0))%2)!=0 and (int(polinomioIrreducibleSympy.subs(Z,1))%2)!=0:
        break
    else:
        print("El polinomio ingresado no es un polinomio Irreducible")

# Curve Eliptica
while True:
    print("\n1) y{0}+xy=x{1}+ax{2}+b".format(unicode_exp(2),unicode_exp(3),unicode_exp(2)))
    print("2) y{0}+cy=x{1}+ax+b".format(unicode_exp(2),unicode_exp(3),unicode_exp(2)))
    tipoDeCurvaE=int(input("¿Que tipo de curva eliptica desea utilizar?: "))
    if tipoDeCurvaE==1 or tipoDeCurvaE==2:
        break

if tipoDeCurvaE==1:
    while validacionA==False:
        a=sympy.Poly(crearPolinomioSympy(int(input("\nIngresa el valor de a: "),2)),Z)
        print(a.as_expr())
        for z in ZpSympy:
            if a==z:
                validacionA=True
    while validacionB==False:
        b=sympy.Poly(crearPolinomioSympy(int(input("\nIngresa el valor de b: "),2)),Z)
        print(b.as_expr())
        for z in ZpSympy:
            if b==z:
                validacionB=True
    discriminante=b
    print("\n")
    contadorZ=1
    for z in ZpSympy:
        print("{0}.- {1}".format(contadorZ,z.as_expr()))
        contadorZ=contadorZ+1

    while True:
        valorX=int(input("Ingresa la posicion de el X que desea utilizar: "))
        if valorX>0 and valorX<=len(ZpSympy):
            break
    print(ZpSympy[valorX-1])
    for z in ZpSympy:
        y2=sympy.Poly(moduloDos(pow(z,2)+(ZpSympy[valorX-1]*z)),Z)
        y2=sympy.Poly(moduloPolinomioIrreducible(y2,polinomioIrreducibleSympy))
        arregloPolinomioY2.append(y2)
    print(arregloPolinomioY2)
    for z in ZpSympy:
        x=sympy.Poly(moduloDos(((pow(z,3))+(a*(pow(z,2)))+b)),Z)
        x=sympy.Poly(moduloPolinomioIrreducible(x,polinomioIrreducibleSympy))
        arregloPolinomiosX.append(x)
    print(arregloPolinomiosX)

    for j in arregloPolinomiosX:
        contadorY=0
        for z in arregloPolinomioY2:
            if j==z:
                paresOrdenados[0].append(ZpSympy[contadorX])
                paresOrdenados[1].append(ZpSympy[contadorY])
            contadorY=contadorY+1
        contadorX=contadorX+1

    while True:
        print("\n\nQue procedimiento desea realizar")
        print("1) 2P")
        print("2) P+Q")
        print("3) nP")
        procedimiento=int(input())

        if procedimiento==1 or procedimiento==2 or procedimiento==3:
            break
    print("Pares Ordenados")
    for fila in range(len(paresOrdenados[0])):
        print("{0}: ({1},{2})".format((fila+1),paresOrdenados[0][fila].as_expr(),paresOrdenados[1][fila].as_expr()))
    
    if procedimiento==1:
        while True:
            p=int(input("Ingresa la posicion del punto P que desea utilizar: "))
            if p>0 and p<=len(paresOrdenados[0]):
                break
        Px=paresOrdenados[0][p-1]
        Py=paresOrdenados[1][p-1]
        if Py%Px==0:
            lamd=sympy.polys.polytools.pdiv(Py,Px)
            lam=lamd[0]
        else:
            for z in ZpSympy:
                divisor=moduloPolinomioIrreducible(moduloDos(Px*z),polinomioIrreducibleSympy)
                if divisor==1:
                    dividendo=sympy.Poly(moduloDos(Py*z))
                    lam=moduloPolinomioIrreducible(dividendo, polinomioIrreducibleSympy)
                    break
        lam=lam+Px
        X3=moduloPolinomioIrreducible(moduloDos(pow(lam,2)),polinomioIrreducibleSympy)+lam+a
        X3=moduloPolinomioIrreducible(moduloDos(X3),polinomioIrreducibleSympy)
        Y3=pow(Px,2)+(X3*lam)+X3
        Y3=moduloPolinomioIrreducible(moduloDos(Y3),polinomioIrreducibleSympy)
        print("2P=({0},{1})".format(X3.as_expr(),Y3.as_expr()))
    
    if procedimiento==2:
        while True:
            p=int(input("Ingresa la posicion del punto P que desea utilizar:  "))
            if p>0 and p<=len(paresOrdenados[0]):
                break
        Px=paresOrdenados[0][p-1]
        Py=paresOrdenados[1][p-1]
        while True:
            q=int(input("Ingresa la posicion del punto Q que desea utilizar:  "))
            if q>0 and p<=len(paresOrdenados[0]) and Px!=paresOrdenados[0][q-1]:
                break
        Qx=paresOrdenados[0][q-1]
        Qy=paresOrdenados[1][q-1]
        print("Punto P=({0},{1})".format(Px.as_expr(),Py.as_expr()))
        print("Punto Q=({0},{1})".format(Qx.as_expr(),Qy.as_expr()))

        dividendolam=moduloPolinomioIrreducible(moduloDos(Py+Qy),polinomioIrreducibleSympy)
        divisorlam=moduloPolinomioIrreducible(moduloDos(Px+Qx),polinomioIrreducibleSympy)
        if dividendolam%divisorlam==0:
            lamd=sympy.polys.polytools.pdiv(dividendolam,divisorlam)
            lam=lamd[0]
        else:
            for z in ZpSympy:
                divisor=moduloPolinomioIrreducible(moduloDos(divisorlam*z),polinomioIrreducibleSympy)
                if divisor==1:
                    print("Valor x:",z.as_expr())
                    dividendo=sympy.Poly(moduloDos(Py*z))
                    lam=moduloPolinomioIrreducible(dividendo, polinomioIrreducibleSympy)
                    break
        
        X3=sympy.Poly(pow(lam,2)+lam+Px+Qx+a)
        X3=moduloPolinomioIrreducible((moduloDos(X3)), polinomioIrreducibleSympy)
        Y3=sympy.Poly(lam*(Px+X3)+X3+Py)
        Y3=moduloPolinomioIrreducible((moduloDos(Y3)), polinomioIrreducibleSympy)
        print("P+Q=({0},{1})".format(X3.as_expr(),Y3.as_expr()))

    if procedimiento==3:
        while True:
            p=int(input("Ingresa la posicion del punto P que desea utilizar: "))
            if p>=0 and p<=len(paresOrdenados[0]):
                break
        Px=paresOrdenados[0][p-1]
        Py=paresOrdenados[1][p-1]
        while True:
            N=int(input("¿Cuantas veces desea sumar el punto? "))
            if N>=3:
                break
        contadorN=2
        while contadorN!=(N+1):
            if contadorN==2:
                if Py%Px==0:
                    lamd=sympy.polys.polytools.pdiv(Py,Px)
                    lam=lamd[0]
                else:
                    for z in ZpSympy:
                        divisor=moduloPolinomioIrreducible(moduloDos(Px*z),polinomioIrreducibleSympy)
                        if divisor==1:
                            dividendo=sympy.Poly(moduloDos(Py*z))
                            lam=moduloPolinomioIrreducible(dividendo, polinomioIrreducibleSympy)
                            break
                lam=lam+Px
                X3=moduloPolinomioIrreducible(moduloDos(pow(lam,2)),polinomioIrreducibleSympy)+lam+a
                X3=moduloPolinomioIrreducible(moduloDos(X3),polinomioIrreducibleSympy)
                Y3=pow(Px,2)+(X3*lam)+X3
                Y3=moduloPolinomioIrreducible(moduloDos(Y3),polinomioIrreducibleSympy)
                print("{0}P=({1},{2})".format(contadorN,X3.as_expr(),Y3.as_expr()))
                puntosP[0].append(X3)
                puntosP[1].append(Y3)
            else:
                Px=Px
                Py=Py
                Qx=X3
                Qy=Y3
                
                dividendolam=moduloPolinomioIrreducible(moduloDos(Py+Qy),polinomioIrreducibleSympy)
                divisorlam=moduloPolinomioIrreducible(moduloDos(Px+Qx),polinomioIrreducibleSympy)
                if Px==Qx:
                    print("El orden de P es: {0}".format(contadorN))
                    break
                else:
                    if dividendolam%divisorlam==0:
                        lamd=sympy.polys.polytools.pdiv(dividendolam,divisorlam)
                        lam=lamd[0]
                    else:
                        for z in ZpSympy:
                            divisor=moduloPolinomioIrreducible(moduloDos(divisorlam*z),polinomioIrreducibleSympy)
                            if divisor==1:
                                dividendo=sympy.Poly(moduloDos(Py*z))
                                lam=moduloPolinomioIrreducible(dividendo, polinomioIrreducibleSympy)
                                break
                    
                    print("lamda: {0}".format(lam.as_expr()))
                    X3=sympy.Poly(moduloDos(pow(lam,2)+lam+Px+Qx+a))
                    X3=moduloPolinomioIrreducible(X3, polinomioIrreducibleSympy)
                    Y3=sympy.Poly(moduloDos(lam*(Px+X3)+X3+Py))
                    Y3=moduloPolinomioIrreducible(Y3, polinomioIrreducibleSympy)
                    
                    for p in range(len(puntosP[0])):
                        if puntosP[0][p]==X3 and puntosP[1][p]==Y3:
                            print("El orden de P es: {0}".format(contadorN))
                            validaOrden=True
                    if validaOrden:
                        break
                    puntosP[0].append(X3)
                    puntosP[1].append(Y3)
                    print("{0}P=({1},{2})".format(contadorN,X3.as_expr(),Y3.as_expr()))
            contadorN=contadorN+1

elif tipoDeCurvaE==2:
    while validacionA==False:
        a=sympy.Poly(crearPolinomioSympy(int(input("Ingresa el valor de a: "),2)),Z)
        print(a.as_expr())
        for z in ZpSympy:
            if a==z:
                validacionA=True

    while validacionB==False:
        b=sympy.Poly(crearPolinomioSympy(int(input("Ingresa el valor de b: "),2)),Z)
        print(b.as_expr())
        for z in ZpSympy:
            if b==z:
                validacionB=True

    while validacionC==False:
        c=sympy.Poly(crearPolinomioSympy(int(input("Ingresa el valor de c: "),2)),Z)
        print(c.as_expr())
        for z in ZpSympy:
            if c==z:
                discriminante=moduloDos(sympy.Poly(pow(c,4)))
                discriminante=moduloPolinomioIrreducible(discriminante, polinomioIrreducibleSympy)
                if (discriminante.subs(Z,0)%2)==1 and (discriminante.subs(Z,1)%2)==1:
                    validacionC=True
                print("Valor discriminante\n{0}\n\n".format(discriminante.as_expr()))

    for z in ZpSympy:
        y2=sympy.Poly(moduloDos(pow(z,2)+(c*z)),Z)
        y2=sympy.Poly(moduloPolinomioIrreducible(y2,polinomioIrreducibleSympy))
        arregloPolinomioY2.append(y2)

    for z in ZpSympy:

        x=sympy.Poly(moduloDos(((pow(z,3))+(a*z)+b)),Z)
        x=sympy.Poly(moduloPolinomioIrreducible(x,polinomioIrreducibleSympy))
        arregloPolinomiosX.append(x)

    for j in arregloPolinomiosX:
        contadorY=0
        for z in arregloPolinomioY2:
            if j==z:
                paresOrdenados[0].append(ZpSympy[contadorX])
                paresOrdenados[1].append(ZpSympy[contadorY])
            contadorY=contadorY+1
        contadorX=contadorX+1

    while True:
        print("1) 2P")
        print("2) P+Q")
        print("3) nP")
        procedimiento=int(input("¿Que procedimiento desea realizar?: "))

        if procedimiento==1 or procedimiento==2 or procedimiento==3:
            break
    
    print("Pares Ordenados")
    for fila in range(len(paresOrdenados[0])):
        print("{0}: ({1},{2})".format((fila+1),paresOrdenados[0][fila].as_expr(),paresOrdenados[1][fila].as_expr()))
    
    if procedimiento==1:
        while True:
            p=int(input("Ingresa el par ordenado: "))
            if p>0 and p<=len(paresOrdenados[0]):
                break
        Px=paresOrdenados[0][p-1]
        Py=paresOrdenados[1][p-1]

        M=sympy.Poly(moduloDos(pow(Px,2)+a),Z)
        M=moduloPolinomioIrreducible(M, polinomioIrreducibleSympy)
        
        if M%c==0:
            Md=sympy.polys.polytools.pdiv(M,c)
            M=Md[0]
        else:
            for z in ZpSympy:
                divisor=moduloPolinomioIrreducible(moduloDos(c*z),polinomioIrreducibleSympy)
                if divisor==1:
                    dividendo=sympy.Poly(moduloDos(M*z),Z)
                    M=moduloPolinomioIrreducible(dividendo, polinomioIrreducibleSympy)
                    break

        X3=moduloPolinomioIrreducible(moduloDos(sympy.Poly(pow(M,2),Z)),polinomioIrreducibleSympy)
        Y3=moduloPolinomioIrreducible(moduloDos(sympy.Poly((M*(Px+X3)+Py+c),Z)),polinomioIrreducibleSympy)
        print("2P=({0},{1})".format(X3.as_expr(),Y3.as_expr()))

    elif procedimiento==2:
        while True:
            p=int(input("Ingresa el primer par ordenado: "))
            if p>0 and p<=len(paresOrdenados[0]):
                break
        Px=paresOrdenados[0][p-1]
        Py=paresOrdenados[1][p-1]
        while True:
            q=int(input("Ingresa el segundo par ordenado: "))
            if q>0 and p<=len(paresOrdenados[0]) and Px!=paresOrdenados[0][q-1]:
                break
        Qx=paresOrdenados[0][q-1]
        Qy=paresOrdenados[1][q-1]
        print("Punto P=({0},{1})".format(Px.as_expr(),Py.as_expr()))
        print("Punto Q=({0},{1})".format(Qx.as_expr(),Qy.as_expr()))
        
        dividendo=moduloPolinomioIrreducible((moduloDos(Py+Qy)), polinomioIrreducibleSympy)
        divisor=moduloPolinomioIrreducible((moduloDos(Px+Qx)), polinomioIrreducibleSympy)

        if dividendo%divisor==0:
            Md=sympy.polys.polytools.pdiv(dividendo,divisor)
            M=Md[0]
        else:
            for z in ZpSympy:
                divisor2=sympy.Poly(moduloPolinomioIrreducible(moduloDos(divisor*z),polinomioIrreducibleSympy),Z)
                if divisor2==1:
                    dividendo=sympy.Poly(moduloDos(dividendo*z),Z)
                    M=moduloPolinomioIrreducible(dividendo, polinomioIrreducibleSympy)
                    break

        X3=sympy.Poly(moduloDos(pow(M,2)+Px+Qx),Z)
        X3=moduloPolinomioIrreducible(X3,polinomioIrreducibleSympy)

        Y3=sympy.Poly(moduloDos(M*(Px+X3)+Py+c),Z)
        Y3=moduloPolinomioIrreducible(Y3,polinomioIrreducibleSympy)
        print("P+Q=({0},{1})".format(X3.as_expr(),Y3.as_expr()))

    elif procedimiento==3:
        while True:
            p=int(input("Ingresa el par ordenado: "))
            if p>=0 and p<=len(paresOrdenados[0]):
                break
        Px=paresOrdenados[0][p-1]
        Py=paresOrdenados[1][p-1]
        while True:
            N=int(input("¿Cuantas veces desea sumar el punto? "))
            if N>=3:
                break
        contadorN=2
        while contadorN!=(N+1):
            if contadorN==2:
                
                M=sympy.Poly(moduloDos(pow(Px,2)+a),Z)
                M=moduloPolinomioIrreducible(M, polinomioIrreducibleSympy)
                dividendo=0
                if M%c==0:
                    Md=sympy.polys.polytools.pdiv(M,c)
                    M=Md[0]
                   
                else:
                    for z in ZpSympy:
                        divisor=moduloPolinomioIrreducible(moduloDos(c*z),polinomioIrreducibleSympy)
                        if divisor==1:
                            dividendo=sympy.Poly(moduloDos(M*z),Z)
                            M=moduloPolinomioIrreducible(dividendo, polinomioIrreducibleSympy)
                            break
                X3=moduloPolinomioIrreducible(moduloDos(sympy.Poly(pow(M,2),Z)),polinomioIrreducibleSympy)
                Y3=moduloPolinomioIrreducible(moduloDos(sympy.Poly((M*(Px+X3)+Py+c),Z)),polinomioIrreducibleSympy)
                print("{0}P=({1},{2})".format(contadorN,X3.as_expr(),Y3.as_expr()))
                puntosP[0].append(X3)
                puntosP[1].append(Y3)
            else:
                Px=Px
                Py=Py
                Qx=X3
                Qy=Y3
                
                dividendo=moduloPolinomioIrreducible((moduloDos(Py+Qy)), polinomioIrreducibleSympy)
                divisor=moduloPolinomioIrreducible((moduloDos(Px+Qx)), polinomioIrreducibleSympy)

                if Px==Qx:
                    print("El orden de P es: {0}".format(contadorN))
                    break
                else:
                    if dividendo%divisor==0:
                        Md=sympy.polys.polytools.pdiv(dividendo,divisor)
                        M=Md[0]
                    else:
                        for z in ZpSympy:
                            divisor2=sympy.Poly(moduloPolinomioIrreducible(moduloDos(divisor*z),polinomioIrreducibleSympy),Z)
                            if divisor2==1:
                                dividendo=sympy.Poly(moduloDos(dividendo*z),Z)
                                M=moduloPolinomioIrreducible(dividendo, polinomioIrreducibleSympy)
                                break
                    X3=sympy.Poly(moduloDos(pow(M,2)+Px+Qx),Z)
                    X3=moduloPolinomioIrreducible(X3,polinomioIrreducibleSympy)
                    
                    Y3=sympy.Poly(moduloDos((M*(Px+X3))+Py+c),Z)
                    Y3=moduloPolinomioIrreducible(Y3,polinomioIrreducibleSympy)

                    
                    for p in range(len(puntosP[0])):
                        if puntosP[0][p]==X3 and puntosP[1][p]==Y3:
                            print("El orden de P es: {0}".format(contadorN))
                            validaOrden=True
                    if validaOrden:
                        break
                    puntosP[0].append(X3)
                    puntosP[1].append(Y3)
                    print("{0}P=({1},{2})".format(contadorN,X3.as_expr(),Y3.as_expr()))
            contadorN=contadorN+1