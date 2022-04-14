class User {
  String email;
  String password;

  User({this.email, this.password});

  factory User.fromJson(Map<String, Object> json) => User(email: json['mail'], password: json['password']);

  Map<String,dynamic> toJson() => {
    'mail' : email,
    'password' : password
  };
}
