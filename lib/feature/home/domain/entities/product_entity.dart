class ProductEntity {
  final List<ProductItemEntity> products;
  final int total;
  final int skip;
  final int limit;

  const ProductEntity({
    this.products = const [],
    this.total = 0,
    this.skip = 0,
    this.limit = 0,
  });
}

class ProductItemEntity {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final int weight;
  final DimensionsEntity dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<ReviewsEntity> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final MetaEntity  meta;
  final List<String> images;
  final String thumbnail;

  const ProductItemEntity({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.category = '',
    this.price = 0.0,
    this.discountPercentage = 0.0,
    this.rating = 0.0,
    this.stock = 0,
    this.tags = const [],
    this.brand = '',
    this.sku = '',
    this.weight = 0,
    this.dimensions = const DimensionsEntity(),
    this.warrantyInformation = '',
    this.shippingInformation = '',
    this.availabilityStatus = '',
    this.reviews = const [],
    this.returnPolicy = '',
    this.minimumOrderQuantity = 0,
    this.meta = const MetaEntity (),
    this.images = const [],
    this.thumbnail = '',
  });
}

class DimensionsEntity  {
  final double width;
  final double height;
  final double depth;

  const DimensionsEntity ({
    this.width = 0.0,
    this.height = 0.0,
    this.depth = 0.0,
  });
}

class ReviewsEntity  {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  const   ReviewsEntity({
    this.rating = 0,
    this.comment = '',
    this.date = '',
    this.reviewerName = '',
    this.reviewerEmail = '',
  });
}

class MetaEntity  {
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  const MetaEntity ({
    this.createdAt = '',
    this.updatedAt = '',
    this.barcode = '',
    this.qrCode = '',
  });
}