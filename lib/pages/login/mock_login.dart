class LoginInput {
  static const String URL = 'https://reqres.in/api/login';
  final String email;
  final String password;

  LoginInput(this.email, this.password);

  LoginInput.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        password = json["password"];

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

class LoginOutput {
  final String token;

  LoginOutput(this.token);

  factory LoginOutput.fromJson(Map<String, dynamic> json) {
    return LoginOutput(
      json["token"],
    );
  }
}
