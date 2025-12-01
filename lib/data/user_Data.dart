class UserData {
  UserData._internal();
  static final UserData _instance = UserData._internal();
  factory UserData() {
    return _instance;
  }
  void setUsersfromMap(Map<String, dynamic> data) {
    return UserData().setUsers(
      id: data['UserId'] ?? "",
      firstName: data['Fname'] ?? "",
      lastName: data['Lname'] ?? "",
      phone: data['Phone'] ?? "",
      email: data['Email'] ?? "",
      birthDate: data['Birth_Date'] ?? "",
      imagUrl: data['ImagUrl'] ?? ""
    );
  }

  String? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? birthDate;
  String? imagUrl;

  void setUsers({
    required String id,
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String birthDate,
    required String imagUrl,
  }) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.phone = phone;
    this.email = email;
    this.birthDate = birthDate;
    this.imagUrl = imagUrl;
  }
}
