class GetCartModal {
  GetCartModal({
    required this.number,
    required this.userId,
    required this.productName,
    required this.productBrand,
    required this.productCategory,
    required this.productImage,
    required this.productId,
    required this.productQuantity,
    required this.cartId,
    required this.quantityCategory,
  });

  String number;
  String userId;
  String productName;
  String productBrand;
  String productCategory;
  String productImage;
  String productId;
  String productQuantity;
  String cartId;
  String quantityCategory;

  factory GetCartModal.fromJson(Map<String, dynamic> json) => GetCartModal(
        number: json["number"],
        userId: json["user_id"],
        productName: json["product_name"],
        productBrand: json["product_brand"],
        productCategory: json["product_category"],
        productImage: json["product_image"],
        productId: json["product_id"],
        productQuantity: json["product_quantity"],
        cartId: json["cart_id"],
        quantityCategory: json["quantity_category"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "user_id": userId,
        "product_name": productName,
        "product_brand": productBrand,
        "product_category": productCategory,
        "product_image": productImage,
        "product_id": productId,
        "product_quantity": productQuantity,
        "cart_id": cartId,
        "quantity_category": quantityCategory,
      };
}
