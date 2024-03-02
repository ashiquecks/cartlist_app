class AddFavoriteNameModal {
  AddFavoriteNameModal({
    required this.success,
    required this.message,
  });

  String success;
  String message;

  factory AddFavoriteNameModal.fromJson(Map<String, dynamic> json) =>
      AddFavoriteNameModal(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
