//Early Initialization

class NamedControlledObject {
  static final Map<String, NamedControlledObject> _cache = {};

  final String name;

  // Private constructor
  NamedControlledObject._internal(this.name);

  // Factory constructor
  factory NamedControlledObject(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name]!; // Return the existing instance
    } else {
      final newInstance = NamedControlledObject._internal(name);
      _cache[name] = newInstance; // Cache the new instance
      return newInstance;
    }
  }

  void log(String message) {
    print('$name: $message');
  }
}

// void main() {
//   var logger1 = NamedControlledObject('MainLogger');
//   var logger2 = NamedControlledObject('MainLogger');
//   var logger3 = NamedControlledObject('AnotherLogger');
//
//   print(logger1 == logger2); // true (same instance)
//   print(logger1 == logger3); // false (different instance)
// }
