void main() {
  @override
  const String hello = "hello";

//changable types
  dynamic gender = "female";

  gender = greeting();
  int age = getAge();
  User userOne = User("Mario", 390);

  //LIST TYPE IN DART: it works just like an array, and you can add generic types like in typescript
  List<String> hobbies = ["chess", "gym", "boxing"];

  hobbies.add("sex");

  print(hello);
  print(gender);
  print(age);
  print(hobbies);
  print(userOne.age);
  userOne.isLoggedIn();
}

String greeting() {
  const String salutation = "Mr Masuku Sir";

  return salutation;
}

//one line arrow function
int getAge() => 30;

//CLASSES
class User {
 late String userName;
 late int age;

//how to initialize a constructor function
  User(String userName, int age) {
    this.userName = userName;
    this.age = age;
  }

  void isLoggedIn() {
    print("is logged in");
  }
}
