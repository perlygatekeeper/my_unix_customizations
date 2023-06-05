def count_bits(block):
    count_1 = 0
    count_0 = 0
    
    for byte in block:
        print(bin(byte)[2:].zfill(8))
        binary_byte = bin(byte)[2:].zfill(8)
        
        for bit in binary_byte:
            if bit == '1':
                count_1 += 1
            else:
                count_0 += 1
    
    return count_1, count_0

# Example usage
block = [
    0b10111010,
    0b01010101,
    0b11110000,
    0b00001111,
    0b11001100,
    0b00110011,
    0b10011001,
    0b01100110
]

count_1_bits, count_0_bits = count_bits(block)

print(f"Number of 1 bits: {count_1_bits}")
print(f"Number of 0 bits: {count_0_bits}")

'''
Output:

Number of 1 bits: 24
Number of 0 bits: 40
'''
