class LoginDataModal {
  LoginDataModal({
    required this.success,
    required this.message,
    required this.userData,
  });

  String success;
  String message;
  UserData userData;

  factory LoginDataModal.fromJson(Map<String, dynamic> json) => LoginDataModal(
        success: json["success"],
        message: json["message"],
        userData: UserData.fromJson(json["user data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "user data": userData.toJson(),
      };
}

class UserData {
  UserData({
    required this.number,
    required this.userName,
    required this.phoneNumber,
    required this.password,
    required this.userId,
    required this.userPincode,
  });
  String number;
  String userName;
  String phoneNumber;
  String password;
  String userId;
  String userPincode;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        number: json["number"],
        userName: json["user_name"],
        phoneNumber: json["phone_number"],
        password: json["password"],
        userId: json["user_id"],
        userPincode: json["user_pincode"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "user_name": userName,
        "phone_number": phoneNumber,
        "password": password,
        "user_id": userId,
        "user_pincode": userPincode,
      };
}
