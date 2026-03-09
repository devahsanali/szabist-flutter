void main() {
  String name = 'John';
  int age = 20;
  double height = 5.9;
  bool isStudent = false;


  String? nullableName = null;
  int? nullableAge = null;


  print("Name: $name");
  print("Age: $age");
  print("Height: $height");
  print("Is Student: $isStudent");
  print("Nullable Name: $nullableName");
  print("Nullable Age: $nullableAge");


  int addNumbers(int a, int b) {
    return a + b;
  }

  int multiplyNumbers(int a, int b) => a * b;

  print("Addition: ${addNumbers(5, 7)}");
  print("Multiplication: ${multiplyNumbers(5, 7)}");


  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    return 'Data fetched!';
  }

  fetchData().then((result) {
    print(result);
  });

}