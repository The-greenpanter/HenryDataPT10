class cola():
    #constructor
    def __init__(self):
        self._list = []
    #agrega un nuevo item
    def enqueue(self, item):
        self.__list.append(item)
    #elimina el primer indice en la lista    
    def dequeue(self):
        self.__list.pop(0)
    #Elemenntos primero agregado
    def first(self):
        if self.__list:
            return self.__list[0]
        else:
            return None
    #si esta vacia
    def is_empty(self):
        return self.__list == []
    #Para saber el numero de elementos en la cola
    def size(self):
        return len(self.__list)
    

    def __copy__(self):
        newcola = self.__class__()
        newcola._list = self._list.copy()
        return newcola
        """Esta es una funcion para poder copiarl la pila a una nueva pila
        """
