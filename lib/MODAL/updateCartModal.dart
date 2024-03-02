class UpdateCartModal {
  UpdateCartModal({
    required this.success,
    required this.message,
  });

  String success;
  String message;

  factory UpdateCartModal.fromJson(Map<String, dynamic> json) =>
      UpdateCartModal(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
