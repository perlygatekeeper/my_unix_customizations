def rotate_bits(byte, rotation):
    rotation %= 8  # Ensure rotation is within 0-7 range
    
    # Perform left rotation
    left_part = (byte << rotation) & 255
    print(f"Left part: 0b{left_part}")
    right_part = byte >> (8 - rotation)
    print(f"Right part: 0b{right_part}")
    rotated_byte = left_part | right_part
    
    return rotated_byte

# Example usage
byte = 0b10101010  # 170 in decimal
rotation = 3
rotated_byte = rotate_bits(byte, rotation)

print(f"Original byte: {byte}")
print(f"Rotated byte: {rotated_byte}")
print(f"Original byte: 0b{bin(byte)[2:].zfill(8)}")
print(f"Rotated byte:  0b{bin(rotated_byte)[2:].zfill(8)}")
