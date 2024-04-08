import Homework05Cola as cola
import random
import os
import sys
def limpiar_pantalla() -> None:
    '''
    Limpiar_pantalla: Limpaia la pantalla de la terminal
    '''
    os.system('cls' if os.name == 'nt' else 'clear')
    
def sumatoria(pila):
    suma = 0
    temp_pila = pila.__copy__()  # Hace una copia de la pila para no alterar la original
    while not temp_pila.is_empty():  # Mientras la pila no esté vacía
        suma += temp_pila.pop()  # Agrega el elemento sacado de la pila a la suma
    return suma

    
baraja:int
mano = cola.cola()
    
limpiar_pantalla()
menu:str = f'''            NO te pases de 50

1.-Llenar la jarra de 3 litros
2.-Llenar la jarra de 5 litros
3.-Vaciar la jarra de 3 litros
4.-Vaciar la jarra de 5 litros
5.-Verter el contenido de la jarra de 3 litros en la de 5 litros
6.-Verter el contenido de la jarra de 5 litros en la de 3 litros

7.- Exit
'''
def limpiar_pantalla() -> None:
    '''
    Limpiar_pantalla: Limpaia la pantalla de la terminal
    '''
    os.system('cls' if os.name == 'nt' else 'clear')
limpiar_pantalla()
opcion:int = 0
while True:
    print(menu)
    opcion = input("Selecione una opcion \n")
    if opcion in ['1','2','3','4','5','6','7']:
        if opcion == "3":
            print("\n Chao \n \n ")
            sys.exit(0)
        elif opcion == "2":
            limpiar_pantalla()
            print("\n Tu mano esta en", sumatoria(mano), "puntos, estas a", 50 - sumatoria(mano),"de pasarte \n")
        elif opcion == "1":
            baraja = random.randint(0,20)
            limpiar_pantalla()
            print("\n Hola aqui tu carta", baraja ,"\n")
            mano.push(baraja)
            if (sumatoria(mano) >=50 ):
                print("\n Te pasaste llevas", sumatoria(mano), "total de puntos \n")
                sys.exit()
    else:
        print("\n Opción inválida. Por favor elige una opción válida. \n")
        input("\n Presiona Enter para continuar... \n")
        sys.exit(0)

# print("vuelve a jugar mas tarde")        

