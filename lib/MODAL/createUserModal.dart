import 'package:cartlist/MODAL/loginDataModal.dart';

class CreateUserModal {
  CreateUserModal({
    required this.success,
    required this.message,
    required this.userData,
  });

  String success;
  String message;
  UserData userData;

  factory CreateUserModal.fromJson(Map<String, dynamic> json) =>
      CreateUserModal(
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
