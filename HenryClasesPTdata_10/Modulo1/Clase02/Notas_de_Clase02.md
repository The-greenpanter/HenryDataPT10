# Entornos virtuales de Python

Un **entorno virtual en Python**: Es una herramienta que permite aislar las dependencias de un proyecto específico del sistema global de Python. Esto significa que puedes tener diferentes versiones de paquetes instaladas para diferentes proyectos sin que interfieran entre sí.

Al installar paquetes en un entorno virtual, estos paquetes solo están disponibles para el proyecto asociado con ese entorno. Esto es útil para evitar conflictos entre versiones de paquetes y garantizar la portabilidad y la consistencia de tu proyecto en diferentes entornos de desarrollo y producción.


## Instalacion de entornos vituales

Primero no hubicamos en el _WorkSpace_ o _sitio de trabajo_ usando el comando `CD` para **change directory** cambiar de directorio y
`ls -l` de **list** de listar los archivos con la esxtencion `-l` muestra todas las carpetas


1. python3 -m venv <nombre del entorno virtual>
2. source <directorio>
3. 
   1. source <nombre del entorno virtual>/bin/activate //Después de ejecutar este comando, se creará una nueva carpeta con el nombre del entorno virtual en el directorio actual, que contendrá todos los archivos necesarios para el entorno virtual, como el intérprete de Python y las bibliotecas estándar.
   2. pipenv shell //Esto creará un nuevo entorno virtual en el directorio actual y automáticamente lo activará.

### Diferencias en los metodos

La principal diferencia entre usar venv y pipenv es que pipenv proporciona una interfaz de línea de comandos más integrada y simplificada para administrar dependencias y entornos virtuales, mientras que venv es una biblioteca estándar de Python que proporciona funcionalidad para crear entornos virtuales, pero deja la gestión de las dependencias al usuario.

### Installando paquetes en un entorno vitual

A continuacion al installacion de la libreria Pandas usada para el tratamiento de grandes paquetes de datos con _Dataframes_ y _Series_
herra,oemtas que permiten manejar objetos de organizacion de datos parecidos a las tablas.

```
pip install pandas
pip freeze
pipenv install pandas
import pandas as pd
```

### Nota final
```
String a = "3";
a.parseint();
```
Por ultimo un dato de referencia es una palabra traida del ingles `Casting` o `casteo` en español, esto es el cambio de valor de una variable, tambien aplica para el cambio de tipo de variable.

> El "casting" o "cásting" en programación se refiere a la conversión explícita de un tipo de dato a otro. En muchos lenguajes de programación, incluido Java, puede ser necesario convertir variables de un tipo a otro en ciertas situaciones, como cuando se desea asignar un valor de un tipo de dato a una variable de otro tipo, o cuando se llama a una función que espera un tipo de dato diferente al que se tiene.