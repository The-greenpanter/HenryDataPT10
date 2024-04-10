class nodeDoublyLinked:
    '''
    Descripcion: Clase nodo doble enlazada 
    que permite buscar antes y despues los datos.
    '''
    
    def __init__(self, cargo):
        self.cargo = cargo
        self.next = None
        self.previous = None
    #Metodo get
    def getData(self): 
        return self.data
    #Next item
    def getNext(self): 
        return self.next
    #Metodo set
    def setData(self,new): 
        self.data = new
    # Nuevo nodo
    def setNext(self, new_node): 
        self.next = Node (new_node)
    # Inserta un nuevo dato despues de {Un dato dado}
    def insertAfter(self, new_node):
        new_node.next = self.next
        self.next = new_node
    # Busca un dato
    def search(self, value):
        current_node = self
        while current_node:
            if current_node.data == value:
                return current_node
            current_node = current_node.next
        return None  # Value not found
    #Dato anterior 
    def hasPrevious(self):
        return self.previous is not None
    #Optine el dato anterior
    def getPrevious(self):
        return self.previous
    #Configura la direcion previa de un dato
    def setPrevious(self, new_node):
        self.previous = new_node
    #Inser a next data with direction
    def insertAfter(self, new_node):
        new_node.next = self.next
        self.next = new_node