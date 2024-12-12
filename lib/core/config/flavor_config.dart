class FlavorConfig {
  final String apiUrl;

  static FlavorConfig? _instance;

  FlavorConfig._internal({required this.apiUrl});

  factory FlavorConfig({required String apiUrl}) {
    if (_instance != null) {
      return _instance!;
    }
    _instance = FlavorConfig._internal(apiUrl: apiUrl);
    return _instance!;
  }

  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception(
          "FlavorConfig is not initialized. Call the factory constructor first.");
    }
    return _instance!;
  }
}

void main() {
  FlavorConfig d = FlavorConfig(apiUrl: 'djhj');
  print(d.apiUrl);

  FlavorConfig f = FlavorConfig(apiUrl: 'daaaa');
  FlavorConfig._instance!.apiUrl;
  print(f.apiUrl);
  print(d == f);
}
