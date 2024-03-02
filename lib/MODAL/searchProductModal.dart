import 'dart:convert';

List<SearchAllProduct> searchAllProductFromJson(String str) =>
    List<SearchAllProduct>.from(
        json.decode(str).map((x) => SearchAllProduct.fromJson(x)));

String searchAllProductToJson(List<SearchAllProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchAllProduct {
  SearchAllProduct({
    required this.number,
    required this.productName,
    required this.productBrand,
    required this.productCategory,
    required this.countCategory,
    required this.productId,
    required this.productImg,
    required this.productRating,
    required this.productPincode,
  });

  String number;
  String productName;
  String productBrand;
  String productCategory;
  String countCategory;
  String productId;
  String productImg;
  String productRating;
  String productPincode;

  factory SearchAllProduct.fromJson(Map<String, dynamic> json) =>
      SearchAllProduct(
        number: json["number"],
        productName: json["product_name"],
        productBrand: json["product_brand"],
        productCategory: json["product_category"],
        countCategory: json["count_category"],
        productId: json["product_id"],
        productImg: json["product_img"],
        productRating: json["product_rating"],
        productPincode: json["product_pincode"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "product_name": productName,
        "product_brand": productBrand,
        "product_category": productCategory,
        "count_category": countCategory,
        "product_id": productId,
        "product_img": productImg,
        "product_rating": productRating,
        "product_pincode": productPincode,
      };
}
