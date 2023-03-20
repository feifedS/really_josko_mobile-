class User {
  late int id;
  late String username;
  late String email;
  late String token;
  late String password1;
  late String password2;
  late String firstname;
  late String lastname;
  late String age;
  late String genderId;
  late String phoneNumber;

  User({required this.id, required this.username, required this.token});

  User.registration(
    this.username,
    this.email,
    this.password1,
    this.password2,
    this.firstname,
    this.lastname,
    this.age,
    this.genderId,
    this.phoneNumber,
  );

  factory User.fromDatabaseJson(Map<dynamic, dynamic> data) => User(
        id: data['id'],
        username: data['username'],
        token: data['token'],
      );

  Map<String, dynamic> toDatabaseJson() =>
      {"id": this.id, "username": this.username, "token": this.token};

  Map<String, dynamic> toRegisterJson() => {
        'username': this.username,
        'email': this.email,
        'password1': this.password1,
        'password2': this.password2,
        'first_name': this.firstname,
        'last_name': this.lastname,
        'age': this.age,
        'gender_id': this.genderId,
        'phone_number': this.phoneNumber,
      };
}
