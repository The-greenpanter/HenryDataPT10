class node:
    #Constructor
    def _init__(self,val): 
        self.data = val 
        self.next = None
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
        self.next = node (new_node)
    # Inserta un nuevo dato despues de {Un dato dado}
    def insertAfter(self, new_node):
        new_node.next = self.next
        self.next = new_node
     #Inser a next data with direction
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
    def remove(self):
        if self.next:  # Check if not the tail node
            self.new = self.next.data  # Copy data from next node
            self.next = self.next.next  # Skip over the next node
        else:  # If tail node
            raise Exception("Cannot remove the tail node in a singly linked list.")