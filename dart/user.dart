class User {
  late String userName;
  late dynamic age;
  late DateTime birthday;

   int? get birthYear => birthday.year;

  User(String userName, dynamic age) {
    this.userName = userName;
    this.age = age;
  }

  User.unborn(String userName) : this(userName, null);
  void isLoggedIn() {
    print("is logged in");
  }

  void describe() {
    print("Person: $userName");
    var birthday = this.birthday;
    int years = DateTime.now().difference(birthday).inDays ~/ 365;
    print("Was born: $birthYear ($years years ago)");
    }
}
