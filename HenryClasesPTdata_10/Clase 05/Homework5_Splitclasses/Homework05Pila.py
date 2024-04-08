class Baraja50 ():
    
    # Constructor
    def __init__ (self):
        self._list =[]
    #Agregar un elemento a la Pila    
    def push(self, item):
        self._list.append(item)
    #Remueve el ultimo elemento agregado        
    def pop(self):    
        return self._list.pop()
    #Devuelve un valor
    def __getitem__(self, i):
        return self._list[i]
    #Muestra el elemento superior de la pila
    def peek(self):
        return self._list[-1]
    #Indica si esta vacia
    def is_empty(self):
        return len(self._list) == 0
    #Size de la pila
    def size(self):
        return self.size()