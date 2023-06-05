import math

class Polygon:
    def __init__(self, sides):
        self.sides = sides

    def perimeter(self):
        return sum(self.sides)

    def area(self):
        raise NotImplementedError("Area calculation not implemented for generic polygon")

class Triangle(Polygon):
    def __init__(self, sides):
        if len(sides) != 3:
            raise ValueError("A triangle must have exactly 3 sides")
        super().__init__(sides)

        # Check if the sides satisfy the triangle inequality rule
        a, b, c = sides
        if a + b <= c or b + c <= a or c + a <= b:
            raise ValueError("Invalid triangle: does not satisfy the triangle inequality rule")

    def area(self):
        a, b, c = self.sides
        s = (a + b + c) / 2
        return math.sqrt(s * (s - a) * (s - b) * (s - c))

class Rectangle(Polygon):
    def __init__(self, sides):
        if len(sides) != 4:
            raise ValueError("A rectangle must have exactly 4 sides")
        super().__init__(sides)

    def area(self):
        length, width = self.sides[0], self.sides[1]
        return length * width

class Circle:
    def __init__(self, radius):
        self.radius = radius

    def perimeter(self):
        return 2 * math.pi * self.radius

    def area(self):
        return math.pi * self.radius ** 2
