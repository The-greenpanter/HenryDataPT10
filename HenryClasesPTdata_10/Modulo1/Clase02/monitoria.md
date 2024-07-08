# Extras importantes de los Arrays y Numpy

## Numpy

Repasamos esta libreria para trabajar con arreglos como fue en la **Homework02** que se encuentra en esta misma carpeta, de dicho codigo es importante tener encuenta los temas tratados acontinuacion

### numero primo 

Para esto usamos un metodo donde aplicabamos la raiz cuadrada, para ello usamos la expresion: 

```
for i in range (2, int(numero**0.5)+1)
```


- Donde el doble asterisco ** significa la potencia de un numero y la potencia de numero<sup>0.5</sup>  es la raiz cuadrada que es lo mismo numero<sup>1/2</sup>

Trabajando con listas observamos el caso de tener una lista dentro de otra lista como el codigo de abajo:

```
lista_prueba = [1,2,3]
lista_2 = [lista_prueba,2,3]
print(lista_2[0][2])
````

- Donde el primer indice indica de la primera lista y el segund indice marca el indice de la liesta adentro de la lista

- Para los Arrays es importante no usar el metodo ```` ```` append() ```` ```` en bubles ```` for ````
 > Cuando usas el método ```` append() ```` en un bucle para agregar elementos a una lista en Python, estás agregando elementos uno por uno a la lista en cada iteración del bucle. Cada vez que se agrega un nuevo elemento, Python tiene que realizar una **asignación de memoria adicional** para ese nuevo elemento. Esto puede ser ineficiente, especialmente cuando tienes un bucle grande que agrega muchos elementos a la lista.
 
__Además__, las listas en Python son **estructuras de datos dinámicas**, lo que significa que *pueden crecer y encogerse* dinámicamente según sea necesario. Cuando agregas elementos a una lista con ```` append() ````, Python a menudo **debe asignar más memoria para la lista y luego copiar los elementos existentes a la nueva ubicación de memoria**. Esto puede generar una sobrecarga significativa, especialmente cuando la lista crece en tamaño.
