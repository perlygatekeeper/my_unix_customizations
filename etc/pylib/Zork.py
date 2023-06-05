class Game:
    def go_to_room(self, room):
        print("You go to", room)

    def look_around(self):
        print("You look around the room")

    def take_item(self, item):
        print("You take", item)

    def drop_item(self, item):
        print("You drop", item)

    def show_inventory(self):
        print("You have the following items in your inventory")

    def quit_game(self):
        print("Game over")
        exit()

game = Game()
parser = CommandParser(game)

while True:
    command = input("Enter a command: ")
    parser.parse_command(command)
