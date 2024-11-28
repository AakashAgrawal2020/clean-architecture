abstract class Animal1 {
  void display();

  void log() {
    print('running');
  }
}

abstract class Animal2 {
  void display();

  void log() {
    print('running');
  }
}

class Dog implements Animal1 {
  @override
  void display() {
    print('display dog');
  }

  @override
  void log() {
    print('Log in dog');
  }
}

class Cat extends Animal1 {
  @override
  void display() {
    print('display cat');
  }

  @override
  void log() {
    super.log();
  }
}

void main() {
  Dog dog = Dog();
  dog.display();
  dog.log();

  Cat cat = Cat();
  cat.display();
  cat.log();
}
