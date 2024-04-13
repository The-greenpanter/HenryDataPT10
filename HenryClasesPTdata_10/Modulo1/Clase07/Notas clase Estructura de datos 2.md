# Notas clase Estructura de datos 2

## Arboles y Grafos 

### Basado en los nodos, podemos generar mas estructuras

Un conjunto de objetos y algunos pares de objetos que están conectados por enlaces. Los vértices (nodos) representan los objetos interconectados y los enlaces que unen los vértices se conocen como aristas.


> Nota de buenas practicas: Clases en tiene mayusuclas, funciones y metodos en minusculas.

Asi como en redes neuronales que se conectan y entrelaza permiten manejar la informacion. 
LLM

Para volver un dato privado se usa *_ _* doble guion bajo.

```class TreeNode:
    def __init__(self, data):
        self.__data = data
        self.left = None
        self.right = None         
```
Vamo a observar ahora una metodo recursiva al ejecutarse a ella misma dentro de ella

```
def insertaVal(self, dato):
        if self.dato:
            if dato < self.dato:
                if self.izq == None:
                    self.izq = Nodo(dato)
                else:
                    **self.izq.insertaVal(dato)**
            elif dato > self.dato:
                if self.der == None:
                    self.der = Nodo(dato)
                else:
                    **self.der.insertaVal(dato)**
        else:
            self.dato = dato
```

Para manejar **BigData** se usan librerias como: **_PySpark y Polars_**