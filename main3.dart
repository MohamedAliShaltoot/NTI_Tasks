class Singleton {
  static final Singleton _instance = Singleton._internal();

  int value = 0; // Shared state

  // Private constructor
  Singleton._internal();

  // Factory constructor to return the same instance
  factory Singleton() {
    return _instance;
  }
}

void main() {
  Singleton obj1 = Singleton();
  Singleton obj2 = Singleton();

  // Modify obj1
  obj1.value = 42;

  // Since obj2 is the same instance as obj1, changes reflect
  print("Object 1 Value: ${obj1.value}"); // Output: 42
  print("Object 2 Value: ${obj2.value}"); // Output: 42

  // Modify obj2
  obj2.value = 99;

  print("Object 1 Value after modifying obj2: ${obj1.value}"); // Output: 99
  print("Object 2 Value after modifying obj2: ${obj2.value}"); // Output: 99
}
