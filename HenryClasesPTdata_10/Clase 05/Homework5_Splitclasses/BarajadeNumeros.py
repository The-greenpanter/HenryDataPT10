import Homework05Pila as pila
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

    
baraja = random.randint(0,20)
mano = pila.pila()
    
limpiar_pantalla()
menu:str = f'''            NO te pases de 50

1.-Pedir numeros
2.-Revisar mi mano
3.-Terminar chao

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
    opcion = input("Selecione una opcion")
    if opcion in ['1','2','3']:
        if opcion == "3":
            print("Chao")
            sys.exit(0)
        elif opcion == "2":
            print(sumatoria(mano))
        elif opcion == "1":
            print("Hola aqui tu carta", baraja)
            mano.push(baraja)
    else:
        print("Opción inválida. Por favor elige una opción válida.")
        input("Presiona Enter para continuar...")
        sys.exit(0)

# print("vuelve a jugar mas tarde")        

