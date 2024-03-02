class MainBannerModal {
  MainBannerModal({
    required this.number,
    required this.bannerImage,
    required this.bannerName,
    required this.bannerId,
  });

  String number;
  String bannerImage;
  String bannerName;
  String bannerId;

  factory MainBannerModal.fromJson(Map<String, dynamic> json) =>
      MainBannerModal(
        number: json["number"],
        bannerImage: json["banner_image"],
        bannerName: json["banner_name"],
        bannerId: json["banner_id"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "banner_image": bannerImage,
        "banner_name": bannerName,
        "banner_id": bannerId,
      };
}
