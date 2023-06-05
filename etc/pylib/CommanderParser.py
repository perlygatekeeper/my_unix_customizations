class CommandParser:
    def __init__(self, game):
        self.game = game

    def parse_command(self, command):
        words = command.lower().split()
        verb = words[0]
        if len(words) > 1:
            noun = words[1]
        else:
            noun = None

        if verb == "go":
            if noun:
                self.game.go_to_room(noun)
            else:
                print("Go where?")
        elif verb == "look":
            self.game.look_around()
        elif verb == "take":
            if noun:
                self.game.take_item(noun)
            else:
                print("Take what?")
        elif verb == "drop":
            if noun:
                self.game.drop_item(noun)
            else:
                print("Drop what?")
        elif verb == "inventory":
            self.game.show_inventory()
        elif verb == "quit":
            self.game.quit_game()
        else:
            print("I don't understand that command.")
