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


estado_de_las_jarra3:str = '''
             Jarra de 3 litros          
            +-----------------+       
            |                 |       
            |                 |       
            |                 |       
            +-----------------+       
                                      
                                      
'''
estado_de_las_jarra5:str = '''
                Jarra de 5 litros
             +-------------------+
             |                   |
             |                   |
             |                   |
             |                   |
             |                   |
             +-------------------+
'''   
baraja:int
mano = cola.cola()
    
limpiar_pantalla()
menu:str = f'''            Las jarras ''', estado_de_las_jarra3, estado_de_las_jarra5, '''

           

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
        if opcion == "1":
            limpiar_pantalla()
            estado_de_las_jarr3= ''' 
             Jarra de 3 litros        
            +-----------------+       
            |+++++++++++++++++|       
            |+++++++++++++++++|       
            |+++++++++++++++++|       
            +-----------------+       
 '''
                                      
            print("Llenaste la jarra de 3 litros",estado_de_las_jarra3,estado_de_las_jarra5)
            # sys.exit(0)
        elif opcion == "2":
            limpiar_pantalla()
            estado_de_las_jarra5 = '''
            Jarra de 5 litros
           +-------------------+
           |+++++++++++++++++++|
           |+++++++++++++++++++|
           |+++++++++++++++++++|
           |+++++++++++++++++++|
           |+++++++++++++++++++|
           +-------------------+
           '''
            print("Llenaste la jarra de 5 litros", estado_de_las_jarra3, estado_de_las_jarra5)
        elif opcion == "3":
            stado_de_las_jarra3 = '''
             Jarra de 3 litros          
            +-----------------+       
            |                 |       
            |                 |       
            |                 |       
            +-----------------+       
                                      
                                      
'''
            limpiar_pantalla()
            print("Vaciaste la jarra de 3 litros", estado_de_las_jarra3, estado_de_las_jarra5)
        elif opcion == "4":
            estado_de_las_jarra5 = '''
                Jarra de 5 litros
             +-------------------+
             |                   |
             |                   |
             |                   |
             |                   |
             |                   |
             +-------------------+
'''   
            limpiar_pantalla()
            print("Vaciaste la jarra de 3 litros", estado_de_las_jarra3, estado_de_las_jarra5)
            if (sumatoria(mano) >=50 ):
                print("\n Te pasaste llevas", sumatoria(mano), "total de puntos \n")
                
    else:
        print("\n Opción inválida. Por favor elige una opción válida. \n")
        input("\n Presiona Enter para continuar... \n")
        sys.exit(0)

# print("vuelve a jugar mas tarde")        

