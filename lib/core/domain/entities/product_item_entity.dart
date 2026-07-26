// class ProductItemEntity {
//   List<ProductEntity> products;
//   int total;
//   int skip;
//   int limit;
//
//   ProductItemEntity({
//     this.products = const [],
//     this.total = 0,
//     this.skip = 0,
//     this.limit = 0,
//   });
// }
//
// class ProductEntity {
//   int id;
//   String title;
//   String description;
//   String category;
//   double price;
//   double discountPercentage;
//   double rating;
//   int stock;
//   List<String> tags;
//   String brand;
//   String sku;
//   int weight;
//   DimensionsEntity dimensions;
//   String warrantyInformation;
//   String shippingInformation;
//   String availabilityStatus;
//   List<ReviewsEntity> reviews;
//   String returnPolicy;
//   int minimumOrderQuantity;
//   MetaEntity meta;
//   List<String> images;
//   String thumbnail;
//
//   ProductEntity({
//     this.id = 0,
//     this.title = 'no title',
//     this.description = '',
//     this.category = '',
//     this.price = 0,
//     this.discountPercentage = 0,
//     this.rating = 0,
//     this.stock = 0,
//     this.tags = const [],
//     this.brand = '',
//     this.sku = '',
//     this.weight = 0,
//     this.dimensions = const DimensionsEntity(),
//     this.warrantyInformation = '',
//     this.shippingInformation = '',
//     this.availabilityStatus = '',
//     this.reviews = const [],
//     this.returnPolicy = '',
//     this.minimumOrderQuantity = 0,
//     this.meta = const MetaEntity(),
//     this.images = const [],
//     this.thumbnail = '',
//   });
// }
//
// class DimensionsEntity {
//   final double width;
//   final double height;
//   final double depth;
//
//   const DimensionsEntity({this.width = 0, this.height = 0, this.depth = 0});
// }
//
// class ReviewsEntity {
//   int rating;
//   String comment;
//   String date;
//   String reviewerName;
//   String reviewerEmail;
//
//   ReviewsEntity({
//     this.rating = 0,
//     this.comment = '',
//     this.date = '',
//     this.reviewerName = '',
//     this.reviewerEmail = '',
//   });
// }
//
// class MetaEntity {
//   final String createdAt;
//   final String updatedAt;
//   final String barcode;
//   final String qrCode;
//
//   const MetaEntity({
//     this.createdAt = '',
//     this.updatedAt = '',
//     this.barcode = '',
//     this.qrCode = '',
//   });
// }
