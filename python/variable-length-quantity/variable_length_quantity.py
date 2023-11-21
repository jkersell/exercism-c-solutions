MORE_BITS_MASK = 0b10000000
LAST_SEVEN_BITS_MASK = 0b1111111

def encode(numbers):
    result = []
    for n in numbers:
        encoded = []
        # Get the 7 least significant bits, leaving the most significant bit in the
        # resulting octet as a 0 to indicate that this is the last octet in this value
        encoded.append(n & LAST_SEVEN_BITS_MASK)
        n = n >> 7
        while n > 0:
            # Get the next 7 least significant bits but set the most significant bit in
            # the resulting octet to a 1 to indicate that there are more octets in this
            # value
            encoded.append(n & LAST_SEVEN_BITS_MASK | MORE_BITS_MASK)
            n = n >> 7
        encoded.reverse()
        result.extend(encoded)
    return result


def decode(bytes_):
    result = []
    if not bytes_:
        return result

    num = 0
    for b in bytes_:
        num = num << 7
        # Push the 7 least significant bits from this byte onto the decoded value
        num |= b & LAST_SEVEN_BITS_MASK
        # If this is byte is the last byte in the value, add the value to the final list
        # of decoded numbers and reset the current value being decoded
        if not b & MORE_BITS_MASK:
            result.append(num)
            num = 0
    if not result:
        raise ValueError("incomplete sequence")
    return result
