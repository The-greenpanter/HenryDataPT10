import os
import sys
def limpiar_pantalla() -> None:
    '''
    Limpiar_pantalla: Limpaia la pantalla de la terminal
    '''
    os.system('cls' if os.name == 'nt' else 'clear')
    
    
menu:str = f'''            Prueva en Vivo

1.-Decir Hola
2.-Decir Como estas?
3.- Decir chao

Por favor introduce una opcion
'''
opcion:str
while True:
    print(menu)
    opcion = input()
    if opcion in ['1','2','3']:
        limpiar_pantalla()
        if opcion == "3":
            print("Chao")
            sys.exit(0)
        elif opcion == "2":
            print("Como estas")
            opcion = 0
            # input()
            continue
            # break
        elif opcion == "1":
            print("Hola")
            opcion = 0
            # input()
            continue
    else:
        print("Opción inválida. Por favor elige una opción válida.")
        input("Presiona Enter para continuar...")
        