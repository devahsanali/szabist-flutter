class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void greet() {
    print("Hello, my name is $name and I am $age years old.");
  }
}


//Encapsulation
class BankAccount {
  double _balance = 0;

  void deposit(double amount) {
    _balance += amount;
  }

  double get balance => _balance;
}

//Inheritance
class Animal {
  void eat() {
    print("Animal is eating");
  }
}

class Dog extends Animal {
  void bark() {
    print("Dog is barking");
  }
}

//Polymorphism
class Student {
  void study() {
    print("Student studies");
  }
}

class EngineeringStudent extends Student {
  @override
  void study() {
    print("Engineering student studies coding");
  }
}

//Abstraction
abstract class Vehicle {
  void start();
}

class Car extends Vehicle {
  @override
  void start() {
    print("Car started");
  }
}

//access private variables
class Parent {
  String _message = "Hello";
}

class Child extends Parent {
  void show() {
    print(_message);
  }
}
void main() {

  /*var person = Person("Alice", 25);
  person.greet();*/

  //Encapsulation
 /* var account = BankAccount();
  account.deposit(100);
  print(account.balance);*/

  //Inheritance
  /*Dog d = Dog();
  d.eat();
  d.bark();*/


  //Polymorphism
 /* EngineeringStudent es = EngineeringStudent();
  es.study();*/

  //Abstraction
  /*Car c = Car();
  c.start();*/

  //access private variables
  Child child = Child();
  child.show();
}