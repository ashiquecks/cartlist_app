// To parse this JSON data, do
//
//     final whatsappListModal = whatsappListModalFromJson(jsonString);

import 'dart:convert';

class WhatsappListModal {
  WhatsappListModal({
    required this.productName,
    required this.productQuantity,
  });

  String productName;
  String productQuantity;

  factory WhatsappListModal.fromJson(Map<String, dynamic> json) =>
      WhatsappListModal(
        productName: json["product_name"],
        productQuantity: json["product_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_name": productName,
        "product_quantity": productQuantity,
      };
}
