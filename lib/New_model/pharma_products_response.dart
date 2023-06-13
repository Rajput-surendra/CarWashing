class GetPharmaProducts {
  bool? error;
  String? message;
  String? minPrice;
  String? maxPrice;
  String? search;
  String? total;
  String? offset;
  List<PharmaProducts>? data;

  GetPharmaProducts(
      {this.error,
        this.message,
        this.minPrice,
        this.maxPrice,
        this.search,
        this.total,
        this.offset,
        this.data});

  GetPharmaProducts.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    search = json['search'];


    total = json['total'];
    offset = json['offset'];
    if (json['data'] != null) {
      data = <PharmaProducts>[];
      json['data'].forEach((v) {
        data!.add(new PharmaProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['search'] = this.search;
    data['total'] = this.total;
    data['offset'] = this.offset;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PharmaProducts {
  String? total;
  String? sales;
  String? stockType;
  String? isPricesInclusiveTax;
  String? indication;
  String? rxInfo;
  String? dosage;
  String? type;
  String? attrValueIds;
  String? sellerRating;
  String? sellerSlug;
  String? sellerNoOfRatings;
  String? sellerProfile;
  Null? storeName;
  String? storeDescription;
  String? sellerId;
  String? sellerName;
  String? id;
  String? stock;
  String? name;
  String? categoryId;
  String? shortDescription;
  String? slug;
  Null? description;
  String? totalAllowedQuantity;
  String? status;
  String? deliverableType;
  String? deliverableZipcodes;
  String? minimumOrderQuantity;
  String? sku;
  String? quantityStepSize;
  String? codAllowed;
  String? rowOrder;
  String? rating;
  String? noOfRatings;
  String? image;
  String? isReturnable;
  String? isCancelable;
  String? cancelableTill;
  String? indicator;
  List<String>? otherImages;
  String? videoType;
  String? video;
  List<Null>? tags;
  String? warrantyPeriod;
  String? guaranteePeriod;
  String? madeIn;
  String? hsnCode;
  String? downloadAllowed;
  String? downloadType;
  String? downloadLink;
  String? brand;
  String? availability;
  String? categoryName;
  String? taxPercentage;
  String? taxId;
  List<Null>? reviewImages;
  List<Null>? attributes;
  List<Variants>? variants;
  String? totalStock;
  MinMaxPrice? minMaxPrice;
  String? relativePath;
  List<String>? otherImagesRelativePath;
  String? videoRelativePath;
  String? totalProduct;
  String? deliverableZipcodesIds;
  bool? isDeliverable;
  bool? isPurchased;
  String? isFavorite;
  String? imageMd;
  String? imageSm;
  List<String>? otherImagesMd;
  List<String>? otherImagesSm;
  List<Null>? variantAttributes;

  PharmaProducts(
      {this.total,
        this.sales,
        this.stockType,
        this.isPricesInclusiveTax,
        this.indication,
        this.rxInfo,
        this.dosage,
        this.type,
        this.attrValueIds,
        this.sellerRating,
        this.sellerSlug,
        this.sellerNoOfRatings,
        this.sellerProfile,
        this.storeName,
        this.storeDescription,
        this.sellerId,
        this.sellerName,
        this.id,
        this.stock,
        this.name,
        this.categoryId,
        this.shortDescription,
        this.slug,
        this.description,
        this.totalAllowedQuantity,
        this.status,
        this.deliverableType,
        this.deliverableZipcodes,
        this.minimumOrderQuantity,
        this.sku,
        this.quantityStepSize,
        this.codAllowed,
        this.rowOrder,
        this.rating,
        this.noOfRatings,
        this.image,
        this.isReturnable,
        this.isCancelable,
        this.cancelableTill,
        this.indicator,
        this.otherImages,
        this.videoType,
        this.video,
        this.tags,
        this.warrantyPeriod,
        this.guaranteePeriod,
        this.madeIn,
        this.hsnCode,
        this.downloadAllowed,
        this.downloadType,
        this.downloadLink,
        this.brand,
        this.availability,
        this.categoryName,
        this.taxPercentage,
        this.taxId,
        this.reviewImages,
        this.attributes,
        this.variants,
        this.totalStock,
        this.minMaxPrice,
        this.relativePath,
        this.otherImagesRelativePath,
        this.videoRelativePath,
        this.totalProduct,
        this.deliverableZipcodesIds,
        this.isDeliverable,
        this.isPurchased,
        this.isFavorite,
        this.imageMd,
        this.imageSm,
        this.otherImagesMd,
        this.otherImagesSm,
        this.variantAttributes});

  PharmaProducts.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    sales = json['sales'];
    stockType = json['stock_type'];
    isPricesInclusiveTax = json['is_prices_inclusive_tax'];
    indication = json['indication'];
    rxInfo = json['rx_info'];
    dosage = json['dosage'];
    type = json['type'];
    attrValueIds = json['attr_value_ids'];
    sellerRating = json['seller_rating'];
    sellerSlug = json['seller_slug'];
    sellerNoOfRatings = json['seller_no_of_ratings'];
    sellerProfile = json['seller_profile'];
    storeName = json['store_name'];
    storeDescription = json['store_description'];
    sellerId = json['seller_id'];
    sellerName = json['seller_name'];
    id = json['id'];
    stock = json['stock'];
    name = json['name'];
    categoryId = json['category_id'];
    shortDescription = json['short_description'];
    slug = json['slug'];
    description = json['description'];
    totalAllowedQuantity = json['total_allowed_quantity'];
    status = json['status'];
    deliverableType = json['deliverable_type'];
    deliverableZipcodes = json['deliverable_zipcodes'];
    minimumOrderQuantity = json['minimum_order_quantity'];
    sku = json['sku'];
    quantityStepSize = json['quantity_step_size'];
    codAllowed = json['cod_allowed'];
    rowOrder = json['row_order'];
    rating = json['rating'];
    noOfRatings = json['no_of_ratings'];
    image = json['image'];
    isReturnable = json['is_returnable'];
    isCancelable = json['is_cancelable'];
    cancelableTill = json['cancelable_till'];
    indicator = json['indicator'];
    otherImages = json['other_images'].cast<String>();
    videoType = json['video_type'];
    video = json['video'];
       warrantyPeriod = json['warranty_period'];
    guaranteePeriod = json['guarantee_period'];
    madeIn = json['made_in'];
    hsnCode = json['hsn_code'];
    downloadAllowed = json['download_allowed'];
    downloadType = json['download_type'];
    downloadLink = json['download_link'];
    brand = json['brand'];
    availability = json['availability'];
    categoryName = json['category_name'];
    taxPercentage = json['tax_percentage'];
    taxId = json['tax_id'];


    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    totalStock = json['total_stock'];
    minMaxPrice = json['min_max_price'] != null
        ? new MinMaxPrice.fromJson(json['min_max_price'])
        : null;
    relativePath = json['relative_path'];
    otherImagesRelativePath = json['other_images_relative_path'].cast<String>();
    videoRelativePath = json['video_relative_path'];
    totalProduct = json['total_product'];
    deliverableZipcodesIds = json['deliverable_zipcodes_ids'];
    isDeliverable = json['is_deliverable'];
    isPurchased = json['is_purchased'];
    isFavorite = json['is_favorite'];
    imageMd = json['image_md'];
    imageSm = json['image_sm'];
    otherImagesMd = json['other_images_md'].cast<String>();
    otherImagesSm = json['other_images_sm'].cast<String>();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['sales'] = this.sales;
    data['stock_type'] = this.stockType;
    data['is_prices_inclusive_tax'] = this.isPricesInclusiveTax;
    data['indication'] = this.indication;
    data['rx_info'] = this.rxInfo;
    data['dosage'] = this.dosage;
    data['type'] = this.type;
    data['attr_value_ids'] = this.attrValueIds;
    data['seller_rating'] = this.sellerRating;
    data['seller_slug'] = this.sellerSlug;
    data['seller_no_of_ratings'] = this.sellerNoOfRatings;
    data['seller_profile'] = this.sellerProfile;
    data['store_name'] = this.storeName;
    data['store_description'] = this.storeDescription;
    data['seller_id'] = this.sellerId;
    data['seller_name'] = this.sellerName;
    data['id'] = this.id;
    data['stock'] = this.stock;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['short_description'] = this.shortDescription;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['total_allowed_quantity'] = this.totalAllowedQuantity;
    data['status'] = this.status;
    data['deliverable_type'] = this.deliverableType;
    data['deliverable_zipcodes'] = this.deliverableZipcodes;
    data['minimum_order_quantity'] = this.minimumOrderQuantity;
    data['sku'] = this.sku;
    data['quantity_step_size'] = this.quantityStepSize;
    data['cod_allowed'] = this.codAllowed;
    data['row_order'] = this.rowOrder;
    data['rating'] = this.rating;
    data['no_of_ratings'] = this.noOfRatings;
    data['image'] = this.image;
    data['is_returnable'] = this.isReturnable;
    data['is_cancelable'] = this.isCancelable;
    data['cancelable_till'] = this.cancelableTill;
    data['indicator'] = this.indicator;
    data['other_images'] = this.otherImages;
    data['video_type'] = this.videoType;
    data['video'] = this.video;

    data['warranty_period'] = this.warrantyPeriod;
    data['guarantee_period'] = this.guaranteePeriod;
    data['made_in'] = this.madeIn;
    data['hsn_code'] = this.hsnCode;
    data['download_allowed'] = this.downloadAllowed;
    data['download_type'] = this.downloadType;
    data['download_link'] = this.downloadLink;
    data['brand'] = this.brand;
    data['availability'] = this.availability;
    data['category_name'] = this.categoryName;
    data['tax_percentage'] = this.taxPercentage;
    data['tax_id'] = this.taxId;


    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    data['total_stock'] = this.totalStock;
    if (this.minMaxPrice != null) {
      data['min_max_price'] = this.minMaxPrice!.toJson();
    }
    data['relative_path'] = this.relativePath;
    data['other_images_relative_path'] = this.otherImagesRelativePath;
    data['video_relative_path'] = this.videoRelativePath;
    data['total_product'] = this.totalProduct;
    data['deliverable_zipcodes_ids'] = this.deliverableZipcodesIds;
    data['is_deliverable'] = this.isDeliverable;
    data['is_purchased'] = this.isPurchased;
    data['is_favorite'] = this.isFavorite;
    data['image_md'] = this.imageMd;
    data['image_sm'] = this.imageSm;
    data['other_images_md'] = this.otherImagesMd;
    data['other_images_sm'] = this.otherImagesSm;

    return data;
  }
}

class Variants {
  String? id;
  String? productId;
  String? attributeValueIds;
  String? attributeSet;
  String? price;
  String? specialPrice;
  String? sku;
  String? stock;
  List<Null>? images;
  String? availability;
  String? status;
  String? dateAdded;
  String? variantIds;
  String? attrName;
  String? variantValues;
  String? swatcheType;
  String? swatcheValue;

  String? cartCount;
  int? isPurchased;

  Variants(
      {this.id,
        this.productId,
        this.attributeValueIds,
        this.attributeSet,
        this.price,
        this.specialPrice,
        this.sku,
        this.stock,
        this.images,
        this.availability,
        this.status,
        this.dateAdded,
        this.variantIds,
        this.attrName,
        this.variantValues,
        this.swatcheType,
        this.swatcheValue,

        this.cartCount,
        this.isPurchased});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    attributeValueIds = json['attribute_value_ids'];
    attributeSet = json['attribute_set'];
    price = json['price'];
    specialPrice = json['special_price'];
    sku = json['sku'];
    stock = json['stock'];
       availability = json['availability'];
    status = json['status'];
    dateAdded = json['date_added'];
    variantIds = json['variant_ids'];
    attrName = json['attr_name'];
    variantValues = json['variant_values'];
    swatcheType = json['swatche_type'];
    swatcheValue = json['swatche_value'];
    cartCount = json['cart_count'];
    isPurchased = json['is_purchased'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['attribute_value_ids'] = this.attributeValueIds;
    data['attribute_set'] = this.attributeSet;
    data['price'] = this.price;
    data['special_price'] = this.specialPrice;
    data['sku'] = this.sku;
    data['stock'] = this.stock;
    data['availability'] = this.availability;
    data['status'] = this.status;
    data['date_added'] = this.dateAdded;
    data['variant_ids'] = this.variantIds;
    data['attr_name'] = this.attrName;
    data['variant_values'] = this.variantValues;
    data['swatche_type'] = this.swatcheType;
    data['swatche_value'] = this.swatcheValue;

    data['cart_count'] = this.cartCount;
    data['is_purchased'] = this.isPurchased;
    return data;
  }
}

class MinMaxPrice {
  int? minPrice;
  int? maxPrice;
  int? specialPrice;
  int? maxSpecialPrice;
  int? discountInPercentage;

  MinMaxPrice(
      {this.minPrice,
        this.maxPrice,
        this.specialPrice,
        this.maxSpecialPrice,
        this.discountInPercentage});

  MinMaxPrice.fromJson(Map<String, dynamic> json) {
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    specialPrice = json['special_price'];
    maxSpecialPrice = json['max_special_price'];
    discountInPercentage = json['discount_in_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['special_price'] = this.specialPrice;
    data['max_special_price'] = this.maxSpecialPrice;
    data['discount_in_percentage'] = this.discountInPercentage;
    return data;
  }
}
