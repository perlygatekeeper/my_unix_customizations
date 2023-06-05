class Node:
    def __init__(self, data=None):
        self.data = data
        self.next = None
        self.prev = None

class DoublyLinkedList:
    def __init__(self):
        self.head = None

    def is_empty(self):
        return self.head is None

    def insert_at_start(self, data):
        new_node = Node(data)
        if self.is_empty():
            self.head = new_node
        else:
            new_node.next = self.head
            self.head.prev = new_node
            self.head = new_node

    def insert_at_end(self, data):
        new_node = Node(data)
        if self.is_empty():
            self.head = new_node
        else:
            current = self.head
            while current.next:
                current = current.next
            current.next = new_node
            new_node.prev = current

    def delete_at_start(self):
        if self.is_empty():
            print("Linked list is empty. Nothing to delete.")
        elif self.head.next is None:
            self.head = None
        else:
            self.head = self.head.next
            self.head.prev = None

    def delete_at_end(self):
        if self.is_empty():
            print("Linked list is empty. Nothing to delete.")
        elif self.head.next is None:
            self.head = None
        else:
            current = self.head
            while current.next:
                current = current.next
            current.prev.next = None

    def display_forward(self):
        if self.is_empty():
            print("Linked list is empty.")
        else:
            current = self.head
            while current:
                print(current.data, end=" -> ")
                current = current.next
            print("None")

    def display_backward(self):
        if self.is_empty():
            print("Linked list is empty.")
        else:
            current = self.head
            while current.next:
                current = current.next
            while current:
                print(current.data, end=" -> ")
                current = current.prev
            print("None")

# Here's an example usage of the double-linked list module:

# python
# Copy code
# Create a new double-linked list
my_list = DoublyLinkedList()

# Insert elements
my_list.insert_at_start(3)
my_list.insert_at_start(2)
my_list.insert_at_end(4)
my_list.insert_at_end(5)

# Display the linked list forward
my_list.display_forward()  # Output: 2 -> 3 -> 4 -> 5 -> None

# Display the linked list backward
my_list.display_backward()  # Output: 5 -> 4 -> 3 -> 2 -> None

# Delete elements
my_list.delete_at_start()
my_list.delete_at_end()

# Display the modified linked list forward
my_list.display_forward()  # Output: 3 -> 4 -> None
