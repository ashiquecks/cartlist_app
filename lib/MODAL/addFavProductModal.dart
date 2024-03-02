class AddFavoriteProductModal {
  AddFavoriteProductModal({
    required this.success,
    required this.message,
  });

  String success;
  String message;

  factory AddFavoriteProductModal.fromJson(Map<String, dynamic> json) =>
      AddFavoriteProductModal(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
