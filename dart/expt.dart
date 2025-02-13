import '../dart/user.dart';

void main() {
  var humanBeing = User("humanBeing", 78);
  humanBeing.describe();

  var happyPerson = User.unborn("Unborn");
  happyPerson.describe();

  print("Hello World");

  var name = "hello there";
  print(name);
  var randomNumber = fibonacci(33);
  print(randomNumber);

  flybyObjects.where((name) => name.contains("turn")).forEach(print);
}

int fibonacci(int hallo) {
  if (hallo > 12 || hallo == 6) {
    const fibValue = 200;
    return fibValue;
  } else {
    const fibValue = 50;
    return fibValue;
  }
}

const List<String> flybyObjects = ["Jupiter", "Saturn", "Neptune"];
