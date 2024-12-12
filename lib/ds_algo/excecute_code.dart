// abstract class Animal1 {
//   void display();
//
//   void log() {
//     print('running');
//   }
// }
//
// abstract class Animal2 {
//   void display();
//
//   void log() {
//     print('running');
//   }
// }
//
// class Dog implements Animal1 {
//   @override
//   void display() {
//     print('display dog');
//   }
//
//   @override
//   void log() {
//     print('Log in dog');
//   }
// }
//
// class Cat extends Animal1 {
//   @override
//   void display() {
//     print('display cat');
//   }
//
//   @override
//   void log() {
//     super.log();
//   }
// }
//
// void main() {
//   Dog dog = Dog();
//   dog.display();
//   dog.log();
//
//   Cat cat = Cat();
//   cat.display();
//   cat.log();
// }

// class Animal {
//   void log() {
//     print('running');
//   }
// }
//
// class Dog extends Animal {
//   @override
//   void log() {
//     print('Log in dog');
//   }
// }
//
// class Cat extends Animal {
//   @override
//   void log() {
//     print('Log in Cat');
//   }
// }
//
// void main() {
//   Animal dog = Dog();
//   dog.log();
//
//   Animal cat = Cat();
//   cat.log();
// }

// abstract class Printer {
//   void printDocument() {
//     print("Printing document...");
//   }
// }
//
// class PDFPrinter extends Printer {
//   @override
//   void printDocument() {
//     print("Printing PDF document...");
//   }
// }
//
// class ImagePrinter implements Printer {
//   @override
//   void printDocument() {
//     print("Printing Image document...");
//   }
// }
//
// void main() {
//   Printer printer1 = PDFPrinter();
//   Printer printer2 = ImagePrinter();
//
//   printer1.printDocument(); // Outputs: Printing PDF document...
//   printer2.printDocument(); // Outputs: Printing Image document...
// }

// abstract class Vehicle {
//   void start();
// }
//
// abstract class Vehicle1 {
//   void start();
// }
//
// class Car implements Vehicle, Vehicle1 {
//   @override
//   void start() {
//     print('Car is starting');
//   }
//
//   void drive() {
//     print('Car is driving');
//   }
// }
//
// void main() {
//   Car car = Car();
//   car.start();
//   car.drive();
// }

// class Shape {
//   String type;
//
//   // Factory constructor
//   factory Shape(String shapeType) {
//     if (shapeType == 'circle') {
//       return Circle();
//     } else if (shapeType == 'square') {
//       return Square();
//     } else {
//       throw Exception('Shape not recognized');
//     }
//   }
//
//   Shape._internal(this.type);
//
//   @override
//   String toString() => 'Shape type: $type';
// }
//
// class Circle extends Shape {
//   Circle() : super._internal('circle');
// }
//
// class Square extends Shape {
//   Square() : super._internal('square');
// }
//
// void main() {
//   Shape circle = Shape('circle');
//   print(circle is Circle);
//   Shape square = Shape('square');
//   print(square is Square); // Shape type: square
// }

class Person {
  String name;
  int age;

  // Default Constructor
  Person(this.name, this.age);

  // Named Constructor
  Person.teenager(this.name) : age = 13 {
    print('$name, $age');
  }
}

void main() {
  var p1 = Person.teenager('Alice'); // Default constructor
  print('${p1.name}, ${p1.age}'); // Output: Alice, 30
}

// class Example {
//   static int counter = 0;
//   int aiseHi = 0;
//
//   Example() {
//     counter++;
//     print('Instance created. Counter is now $counter');
//   }
//
//   void resetCounter() {
//     counter = 0;
//     aiseHi = 10;
//   }
// }
//
// void main() {
//   var e1 = Example();
//   var e2 = Example();
//
//   e1.resetCounter();
//   e2.resetCounter();
//
//   print(Example.counter);
// }

// class Rectangle {
//   int width, height;
//
//   Rectangle(this.width, this.height);
//   Rectangle.square(int size) : this(size, size); // Redirecting Constructor
// }
//
