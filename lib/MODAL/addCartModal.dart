class AddCartModal {
  AddCartModal({
    required this.success,
    required this.message,
  });

  String success;
  String message;

  factory AddCartModal.fromJson(Map<String, dynamic> json) => AddCartModal(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
