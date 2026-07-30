import '../../domain/entities/product_details_entity.dart';

class ProductDetailsDto {
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
  List<ReviewsDto>? reviews;
  String? returnPolicy;
  int? minimumOrderQuantity;
  MetaDto? meta;
  List<String>? images;
  String? thumbnail;

  ProductDetailsDto({
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

  ProductDetailsDto.fromJson(Map<String, dynamic> json) {
    id = (json['id'] as num?)?.toInt();
    title = json['title'] as String?;
    description = json['description'] as String?;
    category = json['category'] as String?;

    // ✅ تحويل آمن للأرقام لضمان عدم حدوث Type Error
    price = (json['price'] as num?)?.toDouble();
    discountPercentage = (json['discountPercentage'] as num?)?.toDouble();
    rating = (json['rating'] as num?)?.toDouble();
    stock = (json['stock'] as num?)?.toInt();

    // ✅ تحويل آمن للقوائم
    tags = (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList();

    brand = json['brand'] as String?;
    sku = json['sku'] as String?;
    weight = (json['weight'] as num?)?.toInt();

    dimensions = json['dimensions'] != null
        ? DimensionsDto.fromJson(json['dimensions'])
        : null;

    warrantyInformation = json['warrantyInformation'] as String?;
    shippingInformation = json['shippingInformation'] as String?;
    availabilityStatus = json['availabilityStatus'] as String?;

    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews!.add(ReviewsDto.fromJson(v));
      });
    }

    returnPolicy = json['returnPolicy'] as String?;
    minimumOrderQuantity = (json['minimumOrderQuantity'] as num?)?.toInt();

    meta = json['meta'] != null ? MetaDto.fromJson(json['meta']) : null;

    images = (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList();
    thumbnail = json['thumbnail'] as String?;
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
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
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

  ProductDetailsEntity toEntity() {
    return ProductDetailsEntity(
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
      dimensions: dimensions?.toEntity() ?? DimensionsEntity(width: 0.0, height: 0.0, depth: 0.0),
      warrantyInformation: warrantyInformation ?? '',
      shippingInformation: shippingInformation ?? '',
      availabilityStatus: availabilityStatus ?? '',
      reviews: reviews?.map((e) => e.toEntity()).toList() ?? [],
      returnPolicy: returnPolicy ?? '',
      minimumOrderQuantity: minimumOrderQuantity ?? 0,
      meta: meta?.toEntity() ?? MetaEntity(createdAt: '', updatedAt: '', barcode: '', qrCode: ''),
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
    return {
      'width': width,
      'height': height,
      'depth': depth,
    };
  }

  DimensionsEntity toEntity() {
    return DimensionsEntity(
      width: width ?? 0.0,
      height: height ?? 0.0,
      depth: depth ?? 0.0,
    );
  }
}

class ReviewsDto {
  int? rating;
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;

  ReviewsDto({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  ReviewsDto.fromJson(Map<String, dynamic> json) {
    rating = (json['rating'] as num?)?.toInt();
    comment = json['comment'] as String?;
    date = json['date'] as String?;
    reviewerName = json['reviewerName'] as String?;
    reviewerEmail = json['reviewerEmail'] as String?;
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
      comment: comment ?? "",
      date: date ?? "",
      reviewerName: reviewerName ?? "",
      reviewerEmail: reviewerEmail ?? "",
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
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    barcode = json['barcode'] as String?;
    qrCode = json['qrCode'] as String?;
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'barcode': barcode,
      'qrCode': qrCode,
    };
  }

  MetaEntity toEntity() {
    return MetaEntity(
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
      barcode: barcode ?? '',
      qrCode: qrCode ?? '',
    );
  }
}