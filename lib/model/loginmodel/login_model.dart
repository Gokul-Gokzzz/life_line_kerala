class LoginModel {
  String? userName;
  String? password;

  LoginModel({
    this.userName,
    this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(userName: json['userName'], password: json['password']);
  }
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
    };
  }
}
