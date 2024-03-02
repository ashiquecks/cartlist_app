class StockProductModal {
  StockProductModal({
    required this.number,
    required this.userId,
    required this.productName,
    required this.productCategory,
    required this.productImage,
    required this.productId,
    required this.productQuantity,
    required this.cartId,
    required this.quantityCategory,
    required this.stockId,
  });

  String number;
  String userId;
  String productName;
  String productCategory;
  String productImage;
  String productId;
  String productQuantity;
  String cartId;
  String quantityCategory;
  String stockId;

  factory StockProductModal.fromJson(Map<String, dynamic> json) =>
      StockProductModal(
        number: json["number"],
        userId: json["user_id"],
        productName: json["product_name"],
        productCategory: json["product_category"],
        productImage: json["product_image"],
        productId: json["product_id"],
        productQuantity: json["product_quantity"],
        cartId: json["cart_id"],
        quantityCategory: json["quantity_category"],
        stockId: json["stock_id\t"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "user_id": userId,
        "product_name": productName,
        "product_category": productCategory,
        "product_image": productImage,
        "product_id": productId,
        "product_quantity": productQuantity,
        "cart_id": cartId,
        "quantity_category": quantityCategory,
        "stock_id\t": stockId,
      };
}
