def rotate_bits(byte, rotation):
    rotation %= 8  # Ensure rotation is within 0-7 range
    character = chr(byte)
    if rotation == 0:
        return byte
    # Perform left rotation
    left_part = (byte << rotation) & 255
    right_part = byte >> (8 - rotation)
#   print(f"Char: {character} 0b{bin(left_part)[2:].zfill(8)} rotated by {rotation} Left:  0b{bin(left_part)[2:].zfill(8)} Right: 0b{bin(right_part)[2:].zfill(8)}")
    rotated_byte = left_part | right_part
    return rotated_byte

# Example usage
word = 'Examples'
rotation = 0
for character in word:
    rotation += 1
    byte = ord(character)
    rotated_byte = rotate_bits(byte, rotation)
    print(f"Char: {character} 0b{bin(rotated_byte)[2:].zfill(8)} rotated by {rotation}")

print("\n\nRotating a single chacter by amounts from 0 to 9")
for rotation in range(9):
    byte = ord('A')
    rotated_byte = rotate_bits(byte, rotation)
    print(f"Char: {character} 0b{bin(rotated_byte)[2:].zfill(8)} rotated by {rotation}")
