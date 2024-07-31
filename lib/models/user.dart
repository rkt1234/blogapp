class UserModel {
  late String userName;
  late String password;
  late String email;
  late String imageUrl = "";

  UserModel(
      {required this.userName,
      required this.password,
      required this.email,
      required this.imageUrl});

  Map<String, String> toJson() {
    Map<String, String> userObject = {
      'userName': userName,
      'password': password,
      'email': email,
      'imageUrl': imageUrl
    };
    return userObject;
  }
}
