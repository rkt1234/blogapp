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

  Map<String, String> toJsonRegister() {
    Map<String, String> userObject = {
      'userName': userName,
      'password': password,
      'email': email,
      'imageUrl': imageUrl
    };
    return userObject;
  }

  Map<String, String> toJsonLogin() {
    print("hello hre");
    Map<String, String> userObject = {
      'password': password,
      'email': email,
    };
    return userObject;
  }
}
