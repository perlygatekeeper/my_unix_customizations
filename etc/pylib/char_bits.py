# Here's an example that demonstrates treating characters as bit vectors:

def get_bit(character, index):
    """Get the value of the bit at the specified index in the character's binary representation."""
    ascii_value = ord(character)
    bit_mask = 1 << index
    return (ascii_value & bit_mask) >> index

def set_bit(character, index, value):
    """Set the bit at the specified index in the character's binary representation to the given value."""
    ascii_value = ord(character)
    bit_mask = 1 << index
    if value == 1:
        return chr(ascii_value | bit_mask)
    else:
        return chr(ascii_value & ~bit_mask)

# Example usage
character = 'X'
print(f"Character: {character}")
print("Binary representation:", bin(ord(character))[2:].zfill(8))
print("Bit at index 2:", get_bit(character, 2))

new_character = set_bit(character, 5, 1)
print("Binary representation:", bin(ord(new_character))[2:].zfill(8))
print(f"New character with bit set at index 5: {new_character}")
