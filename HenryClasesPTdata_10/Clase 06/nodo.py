class Node:
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
        self.next = Node (new_node)