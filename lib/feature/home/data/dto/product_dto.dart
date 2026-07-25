import 'package:shopping_app/feature/home/domain/entities/product_entity.dart';

class ProductDto {
  List<ProductItemDto>? products;
  int? total;
  int? skip;
  int? limit;

  ProductDto({this.products, this.total, this.skip, this.limit});

  ProductDto.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(ProductItemDto.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (products != null) {
      data['products'] = products!.map((e) => e.toJson()).toList();
    }

    data['total'] = total;
    data['skip'] = skip;
    data['limit'] = limit;

    return data;
  }

  ProductEntity toEntity() => ProductEntity(dimensions: DimensionsEntity(), meta: MetaEntity());
}

class ProductItemDto {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  List<String>? tags;
  String? brand;
  String? sku;
  int? weight;
  DimensionsDto? dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  List<ReviewDto>? reviews;
  String? returnPolicy;
  int? minimumOrderQuantity;
  MetaDto? meta;
  List<String>? images;
  String? thumbnail;

  ProductItemDto({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  });

  ProductItemDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];

    price = (json['price'] as num?)?.toDouble();
    discountPercentage = (json['discountPercentage'] as num?)?.toDouble();
    rating = (json['rating'] as num?)?.toDouble();

    stock = json['stock'];

    tags = (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList();

    brand = json['brand'];
    sku = json['sku'];
    weight = json['weight'];

    dimensions = json['dimensions'] != null
        ? DimensionsDto.fromJson(json['dimensions'])
        : null;

    warrantyInformation = json['warrantyInformation'];
    shippingInformation = json['shippingInformation'];
    availabilityStatus = json['availabilityStatus'];

    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews!.add(ReviewDto.fromJson(v));
      });
    }

    returnPolicy = json['returnPolicy'];
    minimumOrderQuantity = json['minimumOrderQuantity'];

    meta = json['meta'] != null ? MetaDto.fromJson(json['meta']) : null;

    images = (json['images'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList();

    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['price'] = price;
    data['discountPercentage'] = discountPercentage;
    data['rating'] = rating;
    data['stock'] = stock;
    data['tags'] = tags;
    data['brand'] = brand;
    data['sku'] = sku;
    data['weight'] = weight;

    if (dimensions != null) {
      data['dimensions'] = dimensions!.toJson();
    }

    data['warrantyInformation'] = warrantyInformation;
    data['shippingInformation'] = shippingInformation;
    data['availabilityStatus'] = availabilityStatus;

    if (reviews != null) {
      data['reviews'] = reviews!.map((e) => e.toJson()).toList();
    }

    data['returnPolicy'] = returnPolicy;
    data['minimumOrderQuantity'] = minimumOrderQuantity;

    if (meta != null) {
      data['meta'] = meta!.toJson();
    }

    data['images'] = images;
    data['thumbnail'] = thumbnail;

    return data;
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? 0,
      title: title ?? '',
      description: description ?? '',
      category: category ?? '',
      price: price ?? 0.0,
      discountPercentage: discountPercentage ?? 0.0,
      rating: rating ?? 0.0,
      stock: stock ?? 0,
      tags: tags ?? [],
      brand: brand ?? '',
      sku: sku ?? '',
      weight: weight ?? 0,
      dimensions: dimensions?.toEntity() ?? const DimensionsEntity(),
      warrantyInformation: warrantyInformation ?? '',
      shippingInformation: shippingInformation ?? '',
      availabilityStatus: availabilityStatus ?? '',
      reviews: reviews?.map((e) => e.toEntity()).toList() ?? [],
      returnPolicy: returnPolicy ?? '',
      minimumOrderQuantity: minimumOrderQuantity ?? 0,
      meta: meta?.toEntity() ?? const MetaEntity(),
      images: images ?? [],
      thumbnail: thumbnail ?? '',
    );
  }
}

class DimensionsDto {
  double? width;
  double? height;
  double? depth;

  DimensionsDto({this.width, this.height, this.depth});

  DimensionsDto.fromJson(Map<String, dynamic> json) {
    width = (json['width'] as num?)?.toDouble();
    height = (json['height'] as num?)?.toDouble();
    depth = (json['depth'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    return {'width': width, 'height': height, 'depth': depth};
  }

  DimensionsEntity toEntity() {
    return DimensionsEntity(
      width: width ?? 0.0,
      height: height ?? 0.0,
      depth: depth ?? 0.0,
    );
  }
}

class ReviewDto {
  int? rating;
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;

  ReviewDto({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  ReviewDto.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    comment = json['comment'];
    date = json['date'];
    reviewerName = json['reviewerName'];
    reviewerEmail = json['reviewerEmail'];
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date,
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }

  ReviewsEntity toEntity() {
    return ReviewsEntity(
      rating: rating ?? 0,
      comment: comment ?? '',
      date: date ?? '',
      reviewerName: reviewerName ?? '',
      reviewerEmail: reviewerEmail ?? '',
    );
  }
}

class MetaDto {
  String? createdAt;
  String? updatedAt;
  String? barcode;
  String? qrCode;

  MetaDto({this.createdAt, this.updatedAt, this.barcode, this.qrCode});

  MetaDto.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    barcode = json['barcode'];
    qrCode = json['qrCode'];
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'barcode': barcode,
      'qrCode': qrCode,
    };
  }

  MetaEntity  toEntity() {
    return MetaEntity (
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
      barcode: barcode ?? '',
      qrCode: qrCode ?? '',
    );
  }
}
