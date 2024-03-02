class FavCategoryNameModal {
  FavCategoryNameModal({
    required this.categoryName,
    required this.categoryId,
  });

  String categoryName;
  String categoryId;

  factory FavCategoryNameModal.fromJson(Map<String, dynamic> json) =>
      FavCategoryNameModal(
        categoryName: json["category_name"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "category_name": categoryName,
        "category_id": categoryId,
      };
}
