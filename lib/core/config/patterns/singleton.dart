//Early Initialization

class Singleton {
  Singleton._singleton();

  static final Singleton singleton = Singleton._singleton();

  factory Singleton() {
    return singleton;
  }
}

// void main() {
//   print(Singleton() == Singleton());
// }
