ls -l
Muestra todas las carpetas


1. python3 -m venv <nombre del entorno virtual>
2. source <directorio>
3. 
   1. source <nombre del entorno virtual>/bin/activate //Después de ejecutar este comando, se creará una nueva carpeta con el nombre del entorno virtual en el directorio actual, que contendrá todos los archivos necesarios para el entorno virtual, como el intérprete de Python y las bibliotecas estándar.
   2. pipenv shell //Esto creará un nuevo entorno virtual en el directorio actual y automáticamente lo activará.




La principal diferencia entre usar venv y pipenv es que pipenv proporciona una interfaz de línea de comandos más integrada y simplificada para administrar dependencias y entornos virtuales, mientras que venv es una biblioteca estándar de Python que proporciona funcionalidad para crear entornos virtuales, pero deja la gestión de las dependencias al usuario.


pip install pandas
pip freeze
pipenv install pandas

import pandas as pd

casteo -- cambiar el tipo de dato # cast