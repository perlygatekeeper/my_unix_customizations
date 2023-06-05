import time

class Tamagotchi:
    def __init__(self, name):
        self.name = name
        self.hunger = 0
        self.boredom = 0
        self.energy = 100
        self.is_sleeping = False

    def feed(self):
        self.hunger -= 10
        if self.hunger < 0:
            self.hunger = 0

    def play(self):
        self.boredom -= 10
        if self.boredom < 0:
            self.boredom = 0

    def sleep(self):
        self.is_sleeping = True
        self.energy = 100
        print("Zzzz...")

    def wake_up(self):
        self.is_sleeping = False
        print("Good morning!")

    def check_status(self):
        print("Name:", self.name)
        print("Hunger:", self.hunger)
        print("Boredom:", self.boredom)
        print("Energy:", self.energy)
        if self.is_sleeping:
            print("Tamagotchi is sleeping.")
        else:
            print("Tamagotchi is awake.")

    def update(self):
        if not self.is_sleeping:
            self.hunger += 5
            self.boredom += 5
            self.energy -= 10
            if self.hunger >= 100 or self.boredom >= 100 or self.energy <= 0:
                print("Oh no! Your Tamagotchi has passed away...")
                exit()

# Creating a new Tamagotchi instance
name = input("Enter a name for your Tamagotchi: ")
tamagotchi = Tamagotchi(name)

# Game loop
while True:
    print("\n1. Feed")
    print("2. Play")
    print("3. Sleep")
    print("4. Wake up")
    print("5. Check status")
    print("6. Exit")
    choice = input("Select an option: ")

    if choice == '1':
        tamagotchi.feed()
    elif choice == '2':
        tamagotchi.play()
    elif choice == '3':
        tamagotchi.sleep()
    elif choice == '4':
        tamagotchi.wake_up()
    elif choice == '5':
        tamagotchi.check_status()
    elif choice == '6':
        print("Goodbye!")
        break
    else:
        print("Invalid choice. Please try again.")

    tamagotchi.update()
    time.sleep(1)
