class AddStockProductModal {
  AddStockProductModal({
    required this.success,
    required this.message,
  });

  String success;
  String message;

  factory AddStockProductModal.fromJson(Map<String, dynamic> json) =>
      AddStockProductModal(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
