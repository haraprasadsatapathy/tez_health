class PopularServiceResponse {
  int? statusCode;
  String? message;
  List<PopularServiceData>? data;

  PopularServiceResponse({this.statusCode, this.message, this.data});

  PopularServiceResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PopularServiceData>[];
      json['data'].forEach((v) {
        data!.add(new PopularServiceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PopularServiceData {
  String? productId;
  String? name;
  String? description;
  String? longDescription;
  String? categoryId;
  String? imageUrl;
  Null? image;
  String? seoSlug;
  List<Variants>? variants;

  PopularServiceData(
      {this.productId,
        this.name,
        this.description,
        this.longDescription,
        this.categoryId,
        this.imageUrl,
        this.image,
        this.seoSlug,
        this.variants});

  PopularServiceData.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    name = json['name'];
    description = json['description'];
    longDescription = json['longDescription'];
    categoryId = json['categoryId'];
    imageUrl = json['imageUrl'];
    image = json['image'];
    seoSlug = json['seoSlug'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['longDescription'] = this.longDescription;
    data['categoryId'] = this.categoryId;
    data['imageUrl'] = this.imageUrl;
    data['image'] = this.image;
    data['seoSlug'] = this.seoSlug;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variants {
  String? variantId;
  String? productId;
  String? variantName;
  int? price;
  int? discountPrice;

  Variants(
      {this.variantId,
        this.productId,
        this.variantName,
        this.price,
        this.discountPrice});

  Variants.fromJson(Map<String, dynamic> json) {
    variantId = json['variantId'];
    productId = json['productId'];
    variantName = json['variantName'];
    price = (json['price'] as num?)?.toInt();
    discountPrice = (json['discountPrice'] as num?)?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variantId'] = this.variantId;
    data['productId'] = this.productId;
    data['variantName'] = this.variantName;
    data['price'] = this.price;
    data['discountPrice'] = this.discountPrice;
    return data;
  }
}