class ProductDetailsEntity {
  int id;
  String title;
  String description;
  String category;
  double price;
  double discountPercentage;
  double rating;
  int stock;
  List<String> tags;
  String brand;
  String sku;
  int weight;
  DimensionsEntity dimensions;
  String warrantyInformation;
  String shippingInformation;
  String availabilityStatus;
  List<ReviewsEntity> reviews;
  String returnPolicy;
  int minimumOrderQuantity;
  MetaEntity meta;
  List<String> images;
  String thumbnail;

  ProductDetailsEntity({required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail});


}
class DimensionsEntity {
  double width;
  double height;
  double depth;

  DimensionsEntity({required this.width,required this.height,required this.depth});
}

class ReviewsEntity {
  int? rating;
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;

  ReviewsEntity(
      {this.rating,
        this.comment,
        this.date,
        this.reviewerName,
        this.reviewerEmail});
}

class MetaEntity {
  String createdAt;
  String updatedAt;
  String barcode;
  String qrCode;

  MetaEntity({required this.createdAt,required this.updatedAt,required this.barcode,required this.qrCode});

}