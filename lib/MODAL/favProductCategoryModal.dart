class FavProductCategoryModal {
  FavProductCategoryModal({
    required this.number,
    required this.productName,
    required this.productImage,
    required this.productId,
    required this.countCategory,
    required this.favCategoryname,
    required this.favCategoryid,
    required this.userId,
    required this.favoriteId,
  });

  String number;
  String productName;
  String productImage;
  String productId;
  String countCategory;
  String favCategoryname;
  String favCategoryid;
  String userId;
  String favoriteId;

  factory FavProductCategoryModal.fromJson(Map<String, dynamic> json) =>
      FavProductCategoryModal(
        number: json["number"],
        productName: json["product_name"],
        productImage: json["product_image"],
        productId: json["product_id"],
        countCategory: json["count_category"],
        favCategoryname: json["fav_categoryname"],
        favCategoryid: json["fav_categoryid"],
        userId: json["user_id"],
        favoriteId: json["favorite_id"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "product_name": productName,
        "product_image": productImage,
        "product_id": productId,
        "count_category": countCategory,
        "fav_categoryname": favCategoryname,
        "fav_categoryid": favCategoryid,
        "user_id": userId,
        "favorite_id": favoriteId,
      };
}
