/// error : false
/// message : "Data Retrieved From Cart !"
/// total_quantity : "2"
/// sub_total : "200"
/// delivery_charge : "10"
/// tax_percentage : "0"
/// tax_amount : "0"
/// overall_amount : "210"
/// total_arr : 200
/// variant_id : ["27","22"]
/// data : [{"id":"27","user_id":"49","product_variant_id":"27","qty":"1","is_saved_for_later":"0","date_created":"2023-03-30 20:06:08","is_prices_inclusive_tax":"0","name":"test","type":"simple_product","image":"uploads/media/2023/download_(60).jpg","short_description":"test","minimum_order_quantity":"1","quantity_step_size":"1","total_allowed_quantity":"","price":120,"special_price":100,"tax_percentage":"","net_amount":100,"tax_amount":0,"sub_total":100,"product_variants":[],"product_details":[{"total":"1","sales":"1","stock_type":"","is_prices_inclusive_tax":"0","indication":"test","rx_info":"<p>test</p>","dosage":"test","type":"simple_product","attr_value_ids":"","seller_rating":"0.0","seller_slug":"","seller_no_of_ratings":"0","seller_profile":"https://alphawizzserver.com/car_wash/","store_name":null,"store_description":"","seller_id":"98","seller_name":"gautamatul","id":"27","stock":"","name":"test","category_id":"10","short_description":"test","slug":"test-1","description":null,"total_allowed_quantity":"","status":"1","deliverable_type":"1","deliverable_zipcodes":"","minimum_order_quantity":"1","sku":"","quantity_step_size":"1","cod_allowed":"0","row_order":"0","rating":"0.00","no_of_ratings":"0","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(60).jpg","is_returnable":"0","is_cancelable":"0","cancelable_till":"","indicator":"0","other_images":[],"video_type":"","video":"","tags":[],"warranty_period":"","guarantee_period":"","made_in":"","hsn_code":"","download_allowed":"","download_type":"","download_link":"","brand":"","availability":"","category_name":"Decongestants","tax_percentage":"0","tax_id":"0","review_images":[],"attributes":[],"variants":[{"id":"27","product_id":"27","attribute_value_ids":"","attribute_set":"","price":"120","special_price":"100","sku":"","stock":"","images":[],"availability":"","status":"1","date_added":"2023-03-28 17:30:12","variant_ids":"","attr_name":"","variant_values":"","swatche_type":"0","swatche_value":"0","images_md":[],"images_sm":[],"variant_relative_path":[],"cart_count":"1","is_purchased":0}],"total_stock":"","min_max_price":{"min_price":120,"max_price":120,"special_price":100,"max_special_price":100,"discount_in_percentage":16},"relative_path":"uploads/media/2023/download_(60).jpg","other_images_relative_path":[],"video_relative_path":"","total_product":"1","deliverable_zipcodes_ids":"","is_deliverable":true,"is_purchased":false,"is_favorite":0,"image_md":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(60).jpg","image_sm":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(60).jpg","other_images_sm":[],"other_images_md":[],"variant_attributes":[],"net_amount":100}]},{"id":"22","user_id":"49","product_variant_id":"22","qty":"1","is_saved_for_later":"0","date_created":"2023-03-30 20:05:52","is_prices_inclusive_tax":"0","name":"Paracetamol","type":"simple_product","image":"uploads/media/2023/download_(58).jpg","short_description":"Paracetamol for test","minimum_order_quantity":"1","quantity_step_size":"1","total_allowed_quantity":"","price":120,"special_price":100,"tax_percentage":"","net_amount":100,"tax_amount":0,"sub_total":100,"product_variants":[],"product_details":[{"total":"1","sales":"1","stock_type":"","is_prices_inclusive_tax":"0","indication":"test","rx_info":"<p>test Rx Info</p>","dosage":"test","type":"simple_product","attr_value_ids":"","seller_rating":"0.0","seller_slug":"","seller_no_of_ratings":"0","seller_profile":"https://alphawizzserver.com/car_wash/","store_name":null,"store_description":"","seller_id":"89","seller_name":"raman","id":"22","stock":"","name":"Paracetamol","category_id":"9","short_description":"Paracetamol for test","slug":"paracetamol","description":null,"total_allowed_quantity":"","status":"1","deliverable_type":"1","deliverable_zipcodes":"","minimum_order_quantity":"1","sku":"","quantity_step_size":"1","cod_allowed":"0","row_order":"0","rating":"0.00","no_of_ratings":"0","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(58).jpg","is_returnable":"0","is_cancelable":"0","cancelable_till":"","indicator":"0","other_images":["https://alphawizzserver.com/car_wash/uploads/media/2023/download_(59).jpg"],"video_type":"","video":"","tags":[],"warranty_period":"","guarantee_period":"","made_in":"","hsn_code":"","download_allowed":"","download_type":"","download_link":"","brand":"","availability":"","category_name":"Anticonvulsants","tax_percentage":"0","tax_id":"0","review_images":[],"attributes":[],"variants":[{"id":"22","product_id":"22","attribute_value_ids":"","attribute_set":"","price":"120","special_price":"100","sku":"","stock":"","images":[],"availability":"","status":"1","date_added":"2023-03-24 16:15:59","variant_ids":"","attr_name":"","variant_values":"","swatche_type":"0","swatche_value":"0","images_md":[],"images_sm":[],"variant_relative_path":[],"cart_count":"1","is_purchased":1}],"total_stock":"","min_max_price":{"min_price":120,"max_price":120,"special_price":100,"max_special_price":100,"discount_in_percentage":16},"relative_path":"uploads/media/2023/download_(58).jpg","other_images_relative_path":["uploads/media/2023/download_(59).jpg"],"video_relative_path":"","total_product":"1","deliverable_zipcodes_ids":"","is_deliverable":true,"is_purchased":true,"is_favorite":0,"image_md":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(58).jpg","image_sm":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(58).jpg","other_images_md":["https://alphawizzserver.com/car_wash/uploads/media/2023/download_(59).jpg"],"other_images_sm":["https://alphawizzserver.com/car_wash/uploads/media/2023/download_(59).jpg"],"variant_attributes":[],"net_amount":100}]}]
/// promo_codes : []

class GetUserCartModel {
  GetUserCartModel({
      bool? error, 
      String? message, 
      String? totalQuantity, 
      String? subTotal, 
      String? deliveryCharge, 
      String? taxPercentage, 
      String? taxAmount, 
      String? overallAmount, 
      num? totalArr, 
      List<String>? variantId, 
      List<Data>? data, 
      List<dynamic>? promoCodes,}){
    _error = error;
    _message = message;
    _totalQuantity = totalQuantity;
    _subTotal = subTotal;
    _deliveryCharge = deliveryCharge;
    _taxPercentage = taxPercentage;
    _taxAmount = taxAmount;
    _overallAmount = overallAmount;
    _totalArr = totalArr;
    _variantId = variantId;
    _data = data;
    _promoCodes = promoCodes;
}

  GetUserCartModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _totalQuantity = json['total_quantity'];
    _subTotal = json['sub_total'];
    _deliveryCharge = json['delivery_charge'];
    _taxPercentage = json['tax_percentage'];
    _taxAmount = json['tax_amount'];
    _overallAmount = json['overall_amount'];
    _totalArr = json['total_arr'];
    _variantId = json['variant_id'] != null ? json['variant_id'].cast<String>() : [];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    if (json['promo_codes'] != null) {
      _promoCodes = [];
      json['promo_codes'].forEach((v) {
        _promoCodes?.add(v.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  String? _totalQuantity;
  String? _subTotal;
  String? _deliveryCharge;
  String? _taxPercentage;
  String? _taxAmount;
  String? _overallAmount;
  num? _totalArr;
  List<String>? _variantId;
  List<Data>? _data;
  List<dynamic>? _promoCodes;
GetUserCartModel copyWith({  bool? error,
  String? message,
  String? totalQuantity,
  String? subTotal,
  String? deliveryCharge,
  String? taxPercentage,
  String? taxAmount,
  String? overallAmount,
  num? totalArr,
  List<String>? variantId,
  List<Data>? data,
  List<dynamic>? promoCodes,
}) => GetUserCartModel(  error: error ?? _error,
  message: message ?? _message,
  totalQuantity: totalQuantity ?? _totalQuantity,
  subTotal: subTotal ?? _subTotal,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
  taxPercentage: taxPercentage ?? _taxPercentage,
  taxAmount: taxAmount ?? _taxAmount,
  overallAmount: overallAmount ?? _overallAmount,
  totalArr: totalArr ?? _totalArr,
  variantId: variantId ?? _variantId,
  data: data ?? _data,
  promoCodes: promoCodes ?? _promoCodes,
);
  bool? get error => _error;
  String? get message => _message;
  String? get totalQuantity => _totalQuantity;
  String? get subTotal => _subTotal;
  String? get deliveryCharge => _deliveryCharge;
  String? get taxPercentage => _taxPercentage;
  String? get taxAmount => _taxAmount;
  String? get overallAmount => _overallAmount;
  num? get totalArr => _totalArr;
  List<String>? get variantId => _variantId;
  List<Data>? get data => _data;
  List<dynamic>? get promoCodes => _promoCodes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    map['total_quantity'] = _totalQuantity;
    map['sub_total'] = _subTotal;
    map['delivery_charge'] = _deliveryCharge;
    map['tax_percentage'] = _taxPercentage;
    map['tax_amount'] = _taxAmount;
    map['overall_amount'] = _overallAmount;
    map['total_arr'] = _totalArr;
    map['variant_id'] = _variantId;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_promoCodes != null) {
      map['promo_codes'] = _promoCodes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "27"
/// user_id : "49"
/// product_variant_id : "27"
/// qty : "1"
/// is_saved_for_later : "0"
/// date_created : "2023-03-30 20:06:08"
/// is_prices_inclusive_tax : "0"
/// name : "test"
/// type : "simple_product"
/// image : "uploads/media/2023/download_(60).jpg"
/// short_description : "test"
/// minimum_order_quantity : "1"
/// quantity_step_size : "1"
/// total_allowed_quantity : ""
/// price : 120
/// special_price : 100
/// tax_percentage : ""
/// net_amount : 100
/// tax_amount : 0
/// sub_total : 100
/// product_variants : []
/// product_details : [{"total":"1","sales":"1","stock_type":"","is_prices_inclusive_tax":"0","indication":"test","rx_info":"<p>test</p>","dosage":"test","type":"simple_product","attr_value_ids":"","seller_rating":"0.0","seller_slug":"","seller_no_of_ratings":"0","seller_profile":"https://alphawizzserver.com/car_wash/","store_name":null,"store_description":"","seller_id":"98","seller_name":"gautamatul","id":"27","stock":"","name":"test","category_id":"10","short_description":"test","slug":"test-1","description":null,"total_allowed_quantity":"","status":"1","deliverable_type":"1","deliverable_zipcodes":"","minimum_order_quantity":"1","sku":"","quantity_step_size":"1","cod_allowed":"0","row_order":"0","rating":"0.00","no_of_ratings":"0","image":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(60).jpg","is_returnable":"0","is_cancelable":"0","cancelable_till":"","indicator":"0","other_images":[],"video_type":"","video":"","tags":[],"warranty_period":"","guarantee_period":"","made_in":"","hsn_code":"","download_allowed":"","download_type":"","download_link":"","brand":"","availability":"","category_name":"Decongestants","tax_percentage":"0","tax_id":"0","review_images":[],"attributes":[],"variants":[{"id":"27","product_id":"27","attribute_value_ids":"","attribute_set":"","price":"120","special_price":"100","sku":"","stock":"","images":[],"availability":"","status":"1","date_added":"2023-03-28 17:30:12","variant_ids":"","attr_name":"","variant_values":"","swatche_type":"0","swatche_value":"0","images_md":[],"images_sm":[],"variant_relative_path":[],"cart_count":"1","is_purchased":0}],"total_stock":"","min_max_price":{"min_price":120,"max_price":120,"special_price":100,"max_special_price":100,"discount_in_percentage":16},"relative_path":"uploads/media/2023/download_(60).jpg","other_images_relative_path":[],"video_relative_path":"","total_product":"1","deliverable_zipcodes_ids":"","is_deliverable":true,"is_purchased":false,"is_favorite":0,"image_md":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(60).jpg","image_sm":"https://alphawizzserver.com/car_wash/uploads/media/2023/download_(60).jpg","other_images_sm":[],"other_images_md":[],"variant_attributes":[],"net_amount":100}]

class Data {
  Data({
      String? id, 
      String? userId, 
      String? productVariantId, 
      String? qty, 
      String? isSavedForLater, 
      String? dateCreated, 
      String? isPricesInclusiveTax, 
      String? name, 
      String? type, 
      String? image, 
      String? shortDescription, 
      String? minimumOrderQuantity, 
      String? quantityStepSize, 
      String? totalAllowedQuantity, 
      num? price, 
      num? specialPrice, 
      String? taxPercentage, 
      num? netAmount, 
      num? taxAmount, 
      num? subTotal, 
      List<dynamic>? productVariants, 
      List<ProductDetails>? productDetails,}){
    _id = id;
    _userId = userId;
    _productVariantId = productVariantId;
    _qty = qty;
    _isSavedForLater = isSavedForLater;
    _dateCreated = dateCreated;
    _isPricesInclusiveTax = isPricesInclusiveTax;
    _name = name;
    _type = type;
    _image = image;
    _shortDescription = shortDescription;
    _minimumOrderQuantity = minimumOrderQuantity;
    _quantityStepSize = quantityStepSize;
    _totalAllowedQuantity = totalAllowedQuantity;
    _price = price;
    _specialPrice = specialPrice;
    _taxPercentage = taxPercentage;
    _netAmount = netAmount;
    _taxAmount = taxAmount;
    _subTotal = subTotal;
    _productVariants = productVariants;
    _productDetails = productDetails;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _productVariantId = json['product_variant_id'];
    _qty = json['qty'];
    _isSavedForLater = json['is_saved_for_later'];
    _dateCreated = json['date_created'];
    _isPricesInclusiveTax = json['is_prices_inclusive_tax'];
    _name = json['name'];
    _type = json['type'];
    _image = json['image'];
    _shortDescription = json['short_description'];
    _minimumOrderQuantity = json['minimum_order_quantity'];
    _quantityStepSize = json['quantity_step_size'];
    _totalAllowedQuantity = json['total_allowed_quantity'];
    _price = json['price'];
    _specialPrice = json['special_price'];
    _taxPercentage = json['tax_percentage'];
    _netAmount = json['net_amount'];
    _taxAmount = json['tax_amount'];
    _subTotal = json['sub_total'];
    if (json['product_variants'] != null) {
      _productVariants = [];
      json['product_variants'].forEach((v) {
        _productVariants?.add(v.fromJson(v));
      });
    }
    if (json['product_details'] != null) {
      _productDetails = [];
      json['product_details'].forEach((v) {
        _productDetails?.add(ProductDetails.fromJson(v));
      });
    }
  }
  String? _id;
  String? _userId;
  String? _productVariantId;
  String? _qty;
  String? _isSavedForLater;
  String? _dateCreated;
  String? _isPricesInclusiveTax;
  String? _name;
  String? _type;
  String? _image;
  String? _shortDescription;
  String? _minimumOrderQuantity;
  String? _quantityStepSize;
  String? _totalAllowedQuantity;
  num? _price;
  num? _specialPrice;
  String? _taxPercentage;
  num? _netAmount;
  num? _taxAmount;
  num? _subTotal;
  List<dynamic>? _productVariants;
  List<ProductDetails>? _productDetails;
Data copyWith({  String? id,
  String? userId,
  String? productVariantId,
  String? qty,
  String? isSavedForLater,
  String? dateCreated,
  String? isPricesInclusiveTax,
  String? name,
  String? type,
  String? image,
  String? shortDescription,
  String? minimumOrderQuantity,
  String? quantityStepSize,
  String? totalAllowedQuantity,
  num? price,
  num? specialPrice,
  String? taxPercentage,
  num? netAmount,
  num? taxAmount,
  num? subTotal,
  List<dynamic>? productVariants,
  List<ProductDetails>? productDetails,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  productVariantId: productVariantId ?? _productVariantId,
  qty: qty ?? _qty,
  isSavedForLater: isSavedForLater ?? _isSavedForLater,
  dateCreated: dateCreated ?? _dateCreated,
  isPricesInclusiveTax: isPricesInclusiveTax ?? _isPricesInclusiveTax,
  name: name ?? _name,
  type: type ?? _type,
  image: image ?? _image,
  shortDescription: shortDescription ?? _shortDescription,
  minimumOrderQuantity: minimumOrderQuantity ?? _minimumOrderQuantity,
  quantityStepSize: quantityStepSize ?? _quantityStepSize,
  totalAllowedQuantity: totalAllowedQuantity ?? _totalAllowedQuantity,
  price: price ?? _price,
  specialPrice: specialPrice ?? _specialPrice,
  taxPercentage: taxPercentage ?? _taxPercentage,
  netAmount: netAmount ?? _netAmount,
  taxAmount: taxAmount ?? _taxAmount,
  subTotal: subTotal ?? _subTotal,
  productVariants: productVariants ?? _productVariants,
  productDetails: productDetails ?? _productDetails,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get productVariantId => _productVariantId;
  String? get qty => _qty;
  String? get isSavedForLater => _isSavedForLater;
  String? get dateCreated => _dateCreated;
  String? get isPricesInclusiveTax => _isPricesInclusiveTax;
  String? get name => _name;
  String? get type => _type;
  String? get image => _image;
  String? get shortDescription => _shortDescription;
  String? get minimumOrderQuantity => _minimumOrderQuantity;
  String? get quantityStepSize => _quantityStepSize;
  String? get totalAllowedQuantity => _totalAllowedQuantity;
  num? get price => _price;
  num? get specialPrice => _specialPrice;
  String? get taxPercentage => _taxPercentage;
  num? get netAmount => _netAmount;
  num? get taxAmount => _taxAmount;
  num? get subTotal => _subTotal;
  List<dynamic>? get productVariants => _productVariants;
  List<ProductDetails>? get productDetails => _productDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['product_variant_id'] = _productVariantId;
    map['qty'] = _qty;
    map['is_saved_for_later'] = _isSavedForLater;
    map['date_created'] = _dateCreated;
    map['is_prices_inclusive_tax'] = _isPricesInclusiveTax;
    map['name'] = _name;
    map['type'] = _type;
    map['image'] = _image;
    map['short_description'] = _shortDescription;
    map['minimum_order_quantity'] = _minimumOrderQuantity;
    map['quantity_step_size'] = _quantityStepSize;
    map['total_allowed_quantity'] = _totalAllowedQuantity;
    map['price'] = _price;
    map['special_price'] = _specialPrice;
    map['tax_percentage'] = _taxPercentage;
    map['net_amount'] = _netAmount;
    map['tax_amount'] = _taxAmount;
    map['sub_total'] = _subTotal;
    if (_productVariants != null) {
      map['product_variants'] = _productVariants?.map((v) => v.toJson()).toList();
    }
    if (_productDetails != null) {
      map['product_details'] = _productDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// total : "1"
/// sales : "1"
/// stock_type : ""
/// is_prices_inclusive_tax : "0"
/// indication : "test"
/// rx_info : "<p>test</p>"
/// dosage : "test"
/// type : "simple_product"
/// attr_value_ids : ""
/// seller_rating : "0.0"
/// seller_slug : ""
/// seller_no_of_ratings : "0"
/// seller_profile : "https://alphawizzserver.com/car_wash/"
/// store_name : null
/// store_description : ""
/// seller_id : "98"
/// seller_name : "gautamatul"
/// id : "27"
/// stock : ""
/// name : "test"
/// category_id : "10"
/// short_description : "test"
/// slug : "test-1"
/// description : null
/// total_allowed_quantity : ""
/// status : "1"
/// deliverable_type : "1"
/// deliverable_zipcodes : ""
/// minimum_order_quantity : "1"
/// sku : ""
/// quantity_step_size : "1"
/// cod_allowed : "0"
/// row_order : "0"
/// rating : "0.00"
/// no_of_ratings : "0"
/// image : "https://alphawizzserver.com/car_wash/uploads/media/2023/download_(60).jpg"
/// is_returnable : "0"
/// is_cancelable : "0"
/// cancelable_till : ""
/// indicator : "0"
/// other_images : []
/// video_type : ""
/// video : ""
/// tags : []
/// warranty_period : ""
/// guarantee_period : ""
/// made_in : ""
/// hsn_code : ""
/// download_allowed : ""
/// download_type : ""
/// download_link : ""
/// brand : ""
/// availability : ""
/// category_name : "Decongestants"
/// tax_percentage : "0"
/// tax_id : "0"
/// review_images : []
/// attributes : []
/// variants : [{"id":"27","product_id":"27","attribute_value_ids":"","attribute_set":"","price":"120","special_price":"100","sku":"","stock":"","images":[],"availability":"","status":"1","date_added":"2023-03-28 17:30:12","variant_ids":"","attr_name":"","variant_values":"","swatche_type":"0","swatche_value":"0","images_md":[],"images_sm":[],"variant_relative_path":[],"cart_count":"1","is_purchased":0}]
/// total_stock : ""
/// min_max_price : {"min_price":120,"max_price":120,"special_price":100,"max_special_price":100,"discount_in_percentage":16}
/// relative_path : "uploads/media/2023/download_(60).jpg"
/// other_images_relative_path : []
/// video_relative_path : ""
/// total_product : "1"
/// deliverable_zipcodes_ids : ""
/// is_deliverable : true
/// is_purchased : false
/// is_favorite : 0
/// image_md : "https://alphawizzserver.com/car_wash/uploads/media/2023/download_(60).jpg"
/// image_sm : "https://alphawizzserver.com/car_wash/uploads/media/2023/download_(60).jpg"
/// other_images_sm : []
/// other_images_md : []
/// variant_attributes : []
/// net_amount : 100

class ProductDetails {
  ProductDetails({
      String? total, 
      String? sales, 
      String? stockType, 
      String? isPricesInclusiveTax, 
      String? indication, 
      String? rxInfo, 
      String? dosage, 
      String? type, 
      String? attrValueIds, 
      String? sellerRating, 
      String? sellerSlug, 
      String? sellerNoOfRatings, 
      String? sellerProfile, 
      dynamic storeName, 
      String? storeDescription, 
      String? sellerId, 
      String? sellerName, 
      String? id, 
      String? stock, 
      String? name, 
      String? categoryId, 
      String? shortDescription, 
      String? slug, 
      dynamic description, 
      String? totalAllowedQuantity, 
      String? status, 
      String? deliverableType, 
      String? deliverableZipcodes, 
      String? minimumOrderQuantity, 
      String? sku, 
      String? quantityStepSize, 
      String? codAllowed, 
      String? rowOrder, 
      String? rating, 
      String? noOfRatings, 
      String? image, 
      String? isReturnable, 
      String? isCancelable, 
      String? cancelableTill, 
      String? indicator, 
      List<dynamic>? otherImages, 
      String? videoType, 
      String? video, 
      List<dynamic>? tags, 
      String? warrantyPeriod, 
      String? guaranteePeriod, 
      String? madeIn, 
      String? hsnCode, 
      String? downloadAllowed, 
      String? downloadType, 
      String? downloadLink, 
      String? brand, 
      String? availability, 
      String? categoryName, 
      String? taxPercentage, 
      String? taxId, 
      List<dynamic>? reviewImages, 
      List<dynamic>? attributes, 
      List<Variants>? variants, 
      String? totalStock, 
      MinMaxPrice? minMaxPrice, 
      String? relativePath, 
      List<dynamic>? otherImagesRelativePath, 
      String? videoRelativePath, 
      String? totalProduct, 
      String? deliverableZipcodesIds, 
      bool? isDeliverable, 
      bool? isPurchased, 
      num? isFavorite, 
      String? imageMd, 
      String? imageSm, 
      List<dynamic>? otherImagesSm, 
      List<dynamic>? otherImagesMd, 
      List<dynamic>? variantAttributes, 
      num? netAmount,}){
    _total = total;
    _sales = sales;
    _stockType = stockType;
    _isPricesInclusiveTax = isPricesInclusiveTax;
    _indication = indication;
    _rxInfo = rxInfo;
    _dosage = dosage;
    _type = type;
    _attrValueIds = attrValueIds;
    _sellerRating = sellerRating;
    _sellerSlug = sellerSlug;
    _sellerNoOfRatings = sellerNoOfRatings;
    _sellerProfile = sellerProfile;
    _storeName = storeName;
    _storeDescription = storeDescription;
    _sellerId = sellerId;
    _sellerName = sellerName;
    _id = id;
    _stock = stock;
    _name = name;
    _categoryId = categoryId;
    _shortDescription = shortDescription;
    _slug = slug;
    _description = description;
    _totalAllowedQuantity = totalAllowedQuantity;
    _status = status;
    _deliverableType = deliverableType;
    _deliverableZipcodes = deliverableZipcodes;
    _minimumOrderQuantity = minimumOrderQuantity;
    _sku = sku;
    _quantityStepSize = quantityStepSize;
    _codAllowed = codAllowed;
    _rowOrder = rowOrder;
    _rating = rating;
    _noOfRatings = noOfRatings;
    _image = image;
    _isReturnable = isReturnable;
    _isCancelable = isCancelable;
    _cancelableTill = cancelableTill;
    _indicator = indicator;
    _otherImages = otherImages;
    _videoType = videoType;
    _video = video;
    _tags = tags;
    _warrantyPeriod = warrantyPeriod;
    _guaranteePeriod = guaranteePeriod;
    _madeIn = madeIn;
    _hsnCode = hsnCode;
    _downloadAllowed = downloadAllowed;
    _downloadType = downloadType;
    _downloadLink = downloadLink;
    _brand = brand;
    _availability = availability;
    _categoryName = categoryName;
    _taxPercentage = taxPercentage;
    _taxId = taxId;
    _reviewImages = reviewImages;
    _attributes = attributes;
    _variants = variants;
    _totalStock = totalStock;
    _minMaxPrice = minMaxPrice;
    _relativePath = relativePath;
    _otherImagesRelativePath = otherImagesRelativePath;
    _videoRelativePath = videoRelativePath;
    _totalProduct = totalProduct;
    _deliverableZipcodesIds = deliverableZipcodesIds;
    _isDeliverable = isDeliverable;
    _isPurchased = isPurchased;
    _isFavorite = isFavorite;
    _imageMd = imageMd;
    _imageSm = imageSm;
    _otherImagesSm = otherImagesSm;
    _otherImagesMd = otherImagesMd;
    _variantAttributes = variantAttributes;
    _netAmount = netAmount;
}

  ProductDetails.fromJson(dynamic json) {
    _total = json['total'];
    _sales = json['sales'];
    _stockType = json['stock_type'];
    _isPricesInclusiveTax = json['is_prices_inclusive_tax'];
    _indication = json['indication'];
    _rxInfo = json['rx_info'];
    _dosage = json['dosage'];
    _type = json['type'];
    _attrValueIds = json['attr_value_ids'];
    _sellerRating = json['seller_rating'];
    _sellerSlug = json['seller_slug'];
    _sellerNoOfRatings = json['seller_no_of_ratings'];
    _sellerProfile = json['seller_profile'];
    _storeName = json['store_name'];
    _storeDescription = json['store_description'];
    _sellerId = json['seller_id'];
    _sellerName = json['seller_name'];
    _id = json['id'];
    _stock = json['stock'];
    _name = json['name'];
    _categoryId = json['category_id'];
    _shortDescription = json['short_description'];
    _slug = json['slug'];
    _description = json['description'];
    _totalAllowedQuantity = json['total_allowed_quantity'];
    _status = json['status'];
    _deliverableType = json['deliverable_type'];
    _deliverableZipcodes = json['deliverable_zipcodes'];
    _minimumOrderQuantity = json['minimum_order_quantity'];
    _sku = json['sku'];
    _quantityStepSize = json['quantity_step_size'];
    _codAllowed = json['cod_allowed'];
    _rowOrder = json['row_order'];
    _rating = json['rating'];
    _noOfRatings = json['no_of_ratings'];
    _image = json['image'];
    _isReturnable = json['is_returnable'];
    _isCancelable = json['is_cancelable'];
    _cancelableTill = json['cancelable_till'];
    _indicator = json['indicator'];
    // if (json['other_images'] != null) {
    //   _otherImages = [];
    //   json['other_images'].forEach((v) {
    //     _otherImages?.add(v.fromJson(v));
    //   });
    // }
    _videoType = json['video_type'];
    _video = json['video'];
    if (json['tags'] != null) {
      _tags = [];
      json['tags'].forEach((v) {
        _tags?.add(v.fromJson(v));
      });
    }
    _warrantyPeriod = json['warranty_period'];
    _guaranteePeriod = json['guarantee_period'];
    _madeIn = json['made_in'];
    _hsnCode = json['hsn_code'];
    _downloadAllowed = json['download_allowed'];
    _downloadType = json['download_type'];
    _downloadLink = json['download_link'];
    _brand = json['brand'];
    _availability = json['availability'];
    _categoryName = json['category_name'];
    _taxPercentage = json['tax_percentage'];
    _taxId = json['tax_id'];
    if (json['review_images'] != null) {
      _reviewImages = [];
      json['review_images'].forEach((v) {
        _reviewImages?.add(v.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      _attributes = [];
      json['attributes'].forEach((v) {
        _attributes?.add(v.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      _variants = [];
      json['variants'].forEach((v) {
        _variants?.add(Variants.fromJson(v));
      });
    }
    _totalStock = json['total_stock'];
    _minMaxPrice = json['min_max_price'] != null ? MinMaxPrice.fromJson(json['min_max_price']) : null;
    _relativePath = json['relative_path'];
    if (json['other_images_relative_path'] != null) {
      _otherImagesRelativePath = [];
      // json['other_images_relative_path'].forEach((v) {
      //   _otherImagesRelativePath?.add(v.fromJson(v));
      // });
    }
    _videoRelativePath = json['video_relative_path'];
    _totalProduct = json['total_product'];
    _deliverableZipcodesIds = json['deliverable_zipcodes_ids'];
    _isDeliverable = json['is_deliverable'];
    _isPurchased = json['is_purchased'];
    _isFavorite = json['is_favorite'];
    _imageMd = json['image_md'];
    _imageSm = json['image_sm'];
    if (json['other_images_sm'] != null) {
      _otherImagesSm = [];
      // json['other_images_sm'].forEach((v) {
      //   _otherImagesSm?.add(v.fromJson(v));
      // });
    }
    if (json['other_images_md'] != null) {
      _otherImagesMd = [];
      // json['other_images_md'].forEach((v) {
      //   _otherImagesMd?.add(v.fromJson(v));
      // });
    }
    if (json['variant_attributes'] != null) {
      _variantAttributes = [];
      json['variant_attributes'].forEach((v) {
        _variantAttributes?.add(v.fromJson(v));
      });
    }
    _netAmount = json['net_amount'];
  }
  String? _total;
  String? _sales;
  String? _stockType;
  String? _isPricesInclusiveTax;
  String? _indication;
  String? _rxInfo;
  String? _dosage;
  String? _type;
  String? _attrValueIds;
  String? _sellerRating;
  String? _sellerSlug;
  String? _sellerNoOfRatings;
  String? _sellerProfile;
  dynamic _storeName;
  String? _storeDescription;
  String? _sellerId;
  String? _sellerName;
  String? _id;
  String? _stock;
  String? _name;
  String? _categoryId;
  String? _shortDescription;
  String? _slug;
  dynamic _description;
  String? _totalAllowedQuantity;
  String? _status;
  String? _deliverableType;
  String? _deliverableZipcodes;
  String? _minimumOrderQuantity;
  String? _sku;
  String? _quantityStepSize;
  String? _codAllowed;
  String? _rowOrder;
  String? _rating;
  String? _noOfRatings;
  String? _image;
  String? _isReturnable;
  String? _isCancelable;
  String? _cancelableTill;
  String? _indicator;
  List<dynamic>? _otherImages;
  String? _videoType;
  String? _video;
  List<dynamic>? _tags;
  String? _warrantyPeriod;
  String? _guaranteePeriod;
  String? _madeIn;
  String? _hsnCode;
  String? _downloadAllowed;
  String? _downloadType;
  String? _downloadLink;
  String? _brand;
  String? _availability;
  String? _categoryName;
  String? _taxPercentage;
  String? _taxId;
  List<dynamic>? _reviewImages;
  List<dynamic>? _attributes;
  List<Variants>? _variants;
  String? _totalStock;
  MinMaxPrice? _minMaxPrice;
  String? _relativePath;
  List<dynamic>? _otherImagesRelativePath;
  String? _videoRelativePath;
  String? _totalProduct;
  String? _deliverableZipcodesIds;
  bool? _isDeliverable;
  bool? _isPurchased;
  num? _isFavorite;
  String? _imageMd;
  String? _imageSm;
  List<dynamic>? _otherImagesSm;
  List<dynamic>? _otherImagesMd;
  List<dynamic>? _variantAttributes;
  num? _netAmount;
ProductDetails copyWith({  String? total,
  String? sales,
  String? stockType,
  String? isPricesInclusiveTax,
  String? indication,
  String? rxInfo,
  String? dosage,
  String? type,
  String? attrValueIds,
  String? sellerRating,
  String? sellerSlug,
  String? sellerNoOfRatings,
  String? sellerProfile,
  dynamic storeName,
  String? storeDescription,
  String? sellerId,
  String? sellerName,
  String? id,
  String? stock,
  String? name,
  String? categoryId,
  String? shortDescription,
  String? slug,
  dynamic description,
  String? totalAllowedQuantity,
  String? status,
  String? deliverableType,
  String? deliverableZipcodes,
  String? minimumOrderQuantity,
  String? sku,
  String? quantityStepSize,
  String? codAllowed,
  String? rowOrder,
  String? rating,
  String? noOfRatings,
  String? image,
  String? isReturnable,
  String? isCancelable,
  String? cancelableTill,
  String? indicator,
  List<dynamic>? otherImages,
  String? videoType,
  String? video,
  List<dynamic>? tags,
  String? warrantyPeriod,
  String? guaranteePeriod,
  String? madeIn,
  String? hsnCode,
  String? downloadAllowed,
  String? downloadType,
  String? downloadLink,
  String? brand,
  String? availability,
  String? categoryName,
  String? taxPercentage,
  String? taxId,
  List<dynamic>? reviewImages,
  List<dynamic>? attributes,
  List<Variants>? variants,
  String? totalStock,
  MinMaxPrice? minMaxPrice,
  String? relativePath,
  List<dynamic>? otherImagesRelativePath,
  String? videoRelativePath,
  String? totalProduct,
  String? deliverableZipcodesIds,
  bool? isDeliverable,
  bool? isPurchased,
  num? isFavorite,
  String? imageMd,
  String? imageSm,
  List<dynamic>? otherImagesSm,
  List<dynamic>? otherImagesMd,
  List<dynamic>? variantAttributes,
  num? netAmount,
}) => ProductDetails(  total: total ?? _total,
  sales: sales ?? _sales,
  stockType: stockType ?? _stockType,
  isPricesInclusiveTax: isPricesInclusiveTax ?? _isPricesInclusiveTax,
  indication: indication ?? _indication,
  rxInfo: rxInfo ?? _rxInfo,
  dosage: dosage ?? _dosage,
  type: type ?? _type,
  attrValueIds: attrValueIds ?? _attrValueIds,
  sellerRating: sellerRating ?? _sellerRating,
  sellerSlug: sellerSlug ?? _sellerSlug,
  sellerNoOfRatings: sellerNoOfRatings ?? _sellerNoOfRatings,
  sellerProfile: sellerProfile ?? _sellerProfile,
  storeName: storeName ?? _storeName,
  storeDescription: storeDescription ?? _storeDescription,
  sellerId: sellerId ?? _sellerId,
  sellerName: sellerName ?? _sellerName,
  id: id ?? _id,
  stock: stock ?? _stock,
  name: name ?? _name,
  categoryId: categoryId ?? _categoryId,
  shortDescription: shortDescription ?? _shortDescription,
  slug: slug ?? _slug,
  description: description ?? _description,
  totalAllowedQuantity: totalAllowedQuantity ?? _totalAllowedQuantity,
  status: status ?? _status,
  deliverableType: deliverableType ?? _deliverableType,
  deliverableZipcodes: deliverableZipcodes ?? _deliverableZipcodes,
  minimumOrderQuantity: minimumOrderQuantity ?? _minimumOrderQuantity,
  sku: sku ?? _sku,
  quantityStepSize: quantityStepSize ?? _quantityStepSize,
  codAllowed: codAllowed ?? _codAllowed,
  rowOrder: rowOrder ?? _rowOrder,
  rating: rating ?? _rating,
  noOfRatings: noOfRatings ?? _noOfRatings,
  image: image ?? _image,
  isReturnable: isReturnable ?? _isReturnable,
  isCancelable: isCancelable ?? _isCancelable,
  cancelableTill: cancelableTill ?? _cancelableTill,
  indicator: indicator ?? _indicator,
  otherImages: otherImages ?? _otherImages,
  videoType: videoType ?? _videoType,
  video: video ?? _video,
  tags: tags ?? _tags,
  warrantyPeriod: warrantyPeriod ?? _warrantyPeriod,
  guaranteePeriod: guaranteePeriod ?? _guaranteePeriod,
  madeIn: madeIn ?? _madeIn,
  hsnCode: hsnCode ?? _hsnCode,
  downloadAllowed: downloadAllowed ?? _downloadAllowed,
  downloadType: downloadType ?? _downloadType,
  downloadLink: downloadLink ?? _downloadLink,
  brand: brand ?? _brand,
  availability: availability ?? _availability,
  categoryName: categoryName ?? _categoryName,
  taxPercentage: taxPercentage ?? _taxPercentage,
  taxId: taxId ?? _taxId,
  reviewImages: reviewImages ?? _reviewImages,
  attributes: attributes ?? _attributes,
  variants: variants ?? _variants,
  totalStock: totalStock ?? _totalStock,
  minMaxPrice: minMaxPrice ?? _minMaxPrice,
  relativePath: relativePath ?? _relativePath,
  otherImagesRelativePath: otherImagesRelativePath ?? _otherImagesRelativePath,
  videoRelativePath: videoRelativePath ?? _videoRelativePath,
  totalProduct: totalProduct ?? _totalProduct,
  deliverableZipcodesIds: deliverableZipcodesIds ?? _deliverableZipcodesIds,
  isDeliverable: isDeliverable ?? _isDeliverable,
  isPurchased: isPurchased ?? _isPurchased,
  isFavorite: isFavorite ?? _isFavorite,
  imageMd: imageMd ?? _imageMd,
  imageSm: imageSm ?? _imageSm,
  otherImagesSm: otherImagesSm ?? _otherImagesSm,
  otherImagesMd: otherImagesMd ?? _otherImagesMd,
  variantAttributes: variantAttributes ?? _variantAttributes,
  netAmount: netAmount ?? _netAmount,
);
  String? get total => _total;
  String? get sales => _sales;
  String? get stockType => _stockType;
  String? get isPricesInclusiveTax => _isPricesInclusiveTax;
  String? get indication => _indication;
  String? get rxInfo => _rxInfo;
  String? get dosage => _dosage;
  String? get type => _type;
  String? get attrValueIds => _attrValueIds;
  String? get sellerRating => _sellerRating;
  String? get sellerSlug => _sellerSlug;
  String? get sellerNoOfRatings => _sellerNoOfRatings;
  String? get sellerProfile => _sellerProfile;
  dynamic get storeName => _storeName;
  String? get storeDescription => _storeDescription;
  String? get sellerId => _sellerId;
  String? get sellerName => _sellerName;
  String? get id => _id;
  String? get stock => _stock;
  String? get name => _name;
  String? get categoryId => _categoryId;
  String? get shortDescription => _shortDescription;
  String? get slug => _slug;
  dynamic get description => _description;
  String? get totalAllowedQuantity => _totalAllowedQuantity;
  String? get status => _status;
  String? get deliverableType => _deliverableType;
  String? get deliverableZipcodes => _deliverableZipcodes;
  String? get minimumOrderQuantity => _minimumOrderQuantity;
  String? get sku => _sku;
  String? get quantityStepSize => _quantityStepSize;
  String? get codAllowed => _codAllowed;
  String? get rowOrder => _rowOrder;
  String? get rating => _rating;
  String? get noOfRatings => _noOfRatings;
  String? get image => _image;
  String? get isReturnable => _isReturnable;
  String? get isCancelable => _isCancelable;
  String? get cancelableTill => _cancelableTill;
  String? get indicator => _indicator;
  List<dynamic>? get otherImages => _otherImages;
  String? get videoType => _videoType;
  String? get video => _video;
  List<dynamic>? get tags => _tags;
  String? get warrantyPeriod => _warrantyPeriod;
  String? get guaranteePeriod => _guaranteePeriod;
  String? get madeIn => _madeIn;
  String? get hsnCode => _hsnCode;
  String? get downloadAllowed => _downloadAllowed;
  String? get downloadType => _downloadType;
  String? get downloadLink => _downloadLink;
  String? get brand => _brand;
  String? get availability => _availability;
  String? get categoryName => _categoryName;
  String? get taxPercentage => _taxPercentage;
  String? get taxId => _taxId;
  List<dynamic>? get reviewImages => _reviewImages;
  List<dynamic>? get attributes => _attributes;
  List<Variants>? get variants => _variants;
  String? get totalStock => _totalStock;
  MinMaxPrice? get minMaxPrice => _minMaxPrice;
  String? get relativePath => _relativePath;
  List<dynamic>? get otherImagesRelativePath => _otherImagesRelativePath;
  String? get videoRelativePath => _videoRelativePath;
  String? get totalProduct => _totalProduct;
  String? get deliverableZipcodesIds => _deliverableZipcodesIds;
  bool? get isDeliverable => _isDeliverable;
  bool? get isPurchased => _isPurchased;
  num? get isFavorite => _isFavorite;
  String? get imageMd => _imageMd;
  String? get imageSm => _imageSm;
  List<dynamic>? get otherImagesSm => _otherImagesSm;
  List<dynamic>? get otherImagesMd => _otherImagesMd;
  List<dynamic>? get variantAttributes => _variantAttributes;
  num? get netAmount => _netAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['sales'] = _sales;
    map['stock_type'] = _stockType;
    map['is_prices_inclusive_tax'] = _isPricesInclusiveTax;
    map['indication'] = _indication;
    map['rx_info'] = _rxInfo;
    map['dosage'] = _dosage;
    map['type'] = _type;
    map['attr_value_ids'] = _attrValueIds;
    map['seller_rating'] = _sellerRating;
    map['seller_slug'] = _sellerSlug;
    map['seller_no_of_ratings'] = _sellerNoOfRatings;
    map['seller_profile'] = _sellerProfile;
    map['store_name'] = _storeName;
    map['store_description'] = _storeDescription;
    map['seller_id'] = _sellerId;
    map['seller_name'] = _sellerName;
    map['id'] = _id;
    map['stock'] = _stock;
    map['name'] = _name;
    map['category_id'] = _categoryId;
    map['short_description'] = _shortDescription;
    map['slug'] = _slug;
    map['description'] = _description;
    map['total_allowed_quantity'] = _totalAllowedQuantity;
    map['status'] = _status;
    map['deliverable_type'] = _deliverableType;
    map['deliverable_zipcodes'] = _deliverableZipcodes;
    map['minimum_order_quantity'] = _minimumOrderQuantity;
    map['sku'] = _sku;
    map['quantity_step_size'] = _quantityStepSize;
    map['cod_allowed'] = _codAllowed;
    map['row_order'] = _rowOrder;
    map['rating'] = _rating;
    map['no_of_ratings'] = _noOfRatings;
    map['image'] = _image;
    map['is_returnable'] = _isReturnable;
    map['is_cancelable'] = _isCancelable;
    map['cancelable_till'] = _cancelableTill;
    map['indicator'] = _indicator;
    if (_otherImages != null) {
      map['other_images'] = _otherImages?.map((v) => v.toJson()).toList();
    }
    map['video_type'] = _videoType;
    map['video'] = _video;
    if (_tags != null) {
      map['tags'] = _tags?.map((v) => v.toJson()).toList();
    }
    map['warranty_period'] = _warrantyPeriod;
    map['guarantee_period'] = _guaranteePeriod;
    map['made_in'] = _madeIn;
    map['hsn_code'] = _hsnCode;
    map['download_allowed'] = _downloadAllowed;
    map['download_type'] = _downloadType;
    map['download_link'] = _downloadLink;
    map['brand'] = _brand;
    map['availability'] = _availability;
    map['category_name'] = _categoryName;
    map['tax_percentage'] = _taxPercentage;
    map['tax_id'] = _taxId;
    if (_reviewImages != null) {
      map['review_images'] = _reviewImages?.map((v) => v.toJson()).toList();
    }
    if (_attributes != null) {
      map['attributes'] = _attributes?.map((v) => v.toJson()).toList();
    }
    if (_variants != null) {
      map['variants'] = _variants?.map((v) => v.toJson()).toList();
    }
    map['total_stock'] = _totalStock;
    if (_minMaxPrice != null) {
      map['min_max_price'] = _minMaxPrice?.toJson();
    }
    map['relative_path'] = _relativePath;
    if (_otherImagesRelativePath != null) {
      map['other_images_relative_path'] = _otherImagesRelativePath?.map((v) => v.toJson()).toList();
    }
    map['video_relative_path'] = _videoRelativePath;
    map['total_product'] = _totalProduct;
    map['deliverable_zipcodes_ids'] = _deliverableZipcodesIds;
    map['is_deliverable'] = _isDeliverable;
    map['is_purchased'] = _isPurchased;
    map['is_favorite'] = _isFavorite;
    map['image_md'] = _imageMd;
    map['image_sm'] = _imageSm;
    if (_otherImagesSm != null) {
      map['other_images_sm'] = _otherImagesSm?.map((v) => v.toJson()).toList();
    }
    if (_otherImagesMd != null) {
      map['other_images_md'] = _otherImagesMd?.map((v) => v.toJson()).toList();
    }
    if (_variantAttributes != null) {
      map['variant_attributes'] = _variantAttributes?.map((v) => v.toJson()).toList();
    }
    map['net_amount'] = _netAmount;
    return map;
  }

}

/// min_price : 120
/// max_price : 120
/// special_price : 100
/// max_special_price : 100
/// discount_in_percentage : 16

class MinMaxPrice {
  MinMaxPrice({
      num? minPrice, 
      num? maxPrice, 
      num? specialPrice, 
      num? maxSpecialPrice, 
      num? discountInPercentage,}){
    _minPrice = minPrice;
    _maxPrice = maxPrice;
    _specialPrice = specialPrice;
    _maxSpecialPrice = maxSpecialPrice;
    _discountInPercentage = discountInPercentage;
}

  MinMaxPrice.fromJson(dynamic json) {
    _minPrice = json['min_price'];
    _maxPrice = json['max_price'];
    _specialPrice = json['special_price'];
    _maxSpecialPrice = json['max_special_price'];
    _discountInPercentage = json['discount_in_percentage'];
  }
  num? _minPrice;
  num? _maxPrice;
  num? _specialPrice;
  num? _maxSpecialPrice;
  num? _discountInPercentage;
MinMaxPrice copyWith({  num? minPrice,
  num? maxPrice,
  num? specialPrice,
  num? maxSpecialPrice,
  num? discountInPercentage,
}) => MinMaxPrice(  minPrice: minPrice ?? _minPrice,
  maxPrice: maxPrice ?? _maxPrice,
  specialPrice: specialPrice ?? _specialPrice,
  maxSpecialPrice: maxSpecialPrice ?? _maxSpecialPrice,
  discountInPercentage: discountInPercentage ?? _discountInPercentage,
);
  num? get minPrice => _minPrice;
  num? get maxPrice => _maxPrice;
  num? get specialPrice => _specialPrice;
  num? get maxSpecialPrice => _maxSpecialPrice;
  num? get discountInPercentage => _discountInPercentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['min_price'] = _minPrice;
    map['max_price'] = _maxPrice;
    map['special_price'] = _specialPrice;
    map['max_special_price'] = _maxSpecialPrice;
    map['discount_in_percentage'] = _discountInPercentage;
    return map;
  }

}

/// id : "27"
/// product_id : "27"
/// attribute_value_ids : ""
/// attribute_set : ""
/// price : "120"
/// special_price : "100"
/// sku : ""
/// stock : ""
/// images : []
/// availability : ""
/// status : "1"
/// date_added : "2023-03-28 17:30:12"
/// variant_ids : ""
/// attr_name : ""
/// variant_values : ""
/// swatche_type : "0"
/// swatche_value : "0"
/// images_md : []
/// images_sm : []
/// variant_relative_path : []
/// cart_count : "1"
/// is_purchased : 0

class Variants {
  Variants({
      String? id, 
      String? productId, 
      String? attributeValueIds, 
      String? attributeSet, 
      String? price, 
      String? specialPrice, 
      String? sku, 
      String? stock, 
      List<dynamic>? images, 
      String? availability, 
      String? status, 
      String? dateAdded, 
      String? variantIds, 
      String? attrName, 
      String? variantValues, 
      String? swatcheType, 
      String? swatcheValue, 
      List<dynamic>? imagesMd, 
      List<dynamic>? imagesSm, 
      List<dynamic>? variantRelativePath, 
      String? cartCount, 
      num? isPurchased,}){
    _id = id;
    _productId = productId;
    _attributeValueIds = attributeValueIds;
    _attributeSet = attributeSet;
    _price = price;
    _specialPrice = specialPrice;
    _sku = sku;
    _stock = stock;
    _images = images;
    _availability = availability;
    _status = status;
    _dateAdded = dateAdded;
    _variantIds = variantIds;
    _attrName = attrName;
    _variantValues = variantValues;
    _swatcheType = swatcheType;
    _swatcheValue = swatcheValue;
    _imagesMd = imagesMd;
    _imagesSm = imagesSm;
    _variantRelativePath = variantRelativePath;
    _cartCount = cartCount;
    _isPurchased = isPurchased;
}

  Variants.fromJson(dynamic json) {
    _id = json['id'];
    _productId = json['product_id'];
    _attributeValueIds = json['attribute_value_ids'];
    _attributeSet = json['attribute_set'];
    _price = json['price'];
    _specialPrice = json['special_price'];
    _sku = json['sku'];
    _stock = json['stock'];
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(v.fromJson(v));
      });
    }
    _availability = json['availability'];
    _status = json['status'];
    _dateAdded = json['date_added'];
    _variantIds = json['variant_ids'];
    _attrName = json['attr_name'];
    _variantValues = json['variant_values'];
    _swatcheType = json['swatche_type'];
    _swatcheValue = json['swatche_value'];
    if (json['images_md'] != null) {
      _imagesMd = [];
      json['images_md'].forEach((v) {
        _imagesMd?.add(v.fromJson(v));
      });
    }
    if (json['images_sm'] != null) {
      _imagesSm = [];
      json['images_sm'].forEach((v) {
        _imagesSm?.add(v.fromJson(v));
      });
    }
    if (json['variant_relative_path'] != null) {
      _variantRelativePath = [];
      json['variant_relative_path'].forEach((v) {
        _variantRelativePath?.add(v.fromJson(v));
      });
    }
    _cartCount = json['cart_count'];
    _isPurchased = json['is_purchased'];
  }
  String? _id;
  String? _productId;
  String? _attributeValueIds;
  String? _attributeSet;
  String? _price;
  String? _specialPrice;
  String? _sku;
  String? _stock;
  List<dynamic>? _images;
  String? _availability;
  String? _status;
  String? _dateAdded;
  String? _variantIds;
  String? _attrName;
  String? _variantValues;
  String? _swatcheType;
  String? _swatcheValue;
  List<dynamic>? _imagesMd;
  List<dynamic>? _imagesSm;
  List<dynamic>? _variantRelativePath;
  String? _cartCount;
  num? _isPurchased;
Variants copyWith({  String? id,
  String? productId,
  String? attributeValueIds,
  String? attributeSet,
  String? price,
  String? specialPrice,
  String? sku,
  String? stock,
  List<dynamic>? images,
  String? availability,
  String? status,
  String? dateAdded,
  String? variantIds,
  String? attrName,
  String? variantValues,
  String? swatcheType,
  String? swatcheValue,
  List<dynamic>? imagesMd,
  List<dynamic>? imagesSm,
  List<dynamic>? variantRelativePath,
  String? cartCount,
  num? isPurchased,
}) => Variants(  id: id ?? _id,
  productId: productId ?? _productId,
  attributeValueIds: attributeValueIds ?? _attributeValueIds,
  attributeSet: attributeSet ?? _attributeSet,
  price: price ?? _price,
  specialPrice: specialPrice ?? _specialPrice,
  sku: sku ?? _sku,
  stock: stock ?? _stock,
  images: images ?? _images,
  availability: availability ?? _availability,
  status: status ?? _status,
  dateAdded: dateAdded ?? _dateAdded,
  variantIds: variantIds ?? _variantIds,
  attrName: attrName ?? _attrName,
  variantValues: variantValues ?? _variantValues,
  swatcheType: swatcheType ?? _swatcheType,
  swatcheValue: swatcheValue ?? _swatcheValue,
  imagesMd: imagesMd ?? _imagesMd,
  imagesSm: imagesSm ?? _imagesSm,
  variantRelativePath: variantRelativePath ?? _variantRelativePath,
  cartCount: cartCount ?? _cartCount,
  isPurchased: isPurchased ?? _isPurchased,
);
  String? get id => _id;
  String? get productId => _productId;
  String? get attributeValueIds => _attributeValueIds;
  String? get attributeSet => _attributeSet;
  String? get price => _price;
  String? get specialPrice => _specialPrice;
  String? get sku => _sku;
  String? get stock => _stock;
  List<dynamic>? get images => _images;
  String? get availability => _availability;
  String? get status => _status;
  String? get dateAdded => _dateAdded;
  String? get variantIds => _variantIds;
  String? get attrName => _attrName;
  String? get variantValues => _variantValues;
  String? get swatcheType => _swatcheType;
  String? get swatcheValue => _swatcheValue;
  List<dynamic>? get imagesMd => _imagesMd;
  List<dynamic>? get imagesSm => _imagesSm;
  List<dynamic>? get variantRelativePath => _variantRelativePath;
  String? get cartCount => _cartCount;
  num? get isPurchased => _isPurchased;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['product_id'] = _productId;
    map['attribute_value_ids'] = _attributeValueIds;
    map['attribute_set'] = _attributeSet;
    map['price'] = _price;
    map['special_price'] = _specialPrice;
    map['sku'] = _sku;
    map['stock'] = _stock;
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    map['availability'] = _availability;
    map['status'] = _status;
    map['date_added'] = _dateAdded;
    map['variant_ids'] = _variantIds;
    map['attr_name'] = _attrName;
    map['variant_values'] = _variantValues;
    map['swatche_type'] = _swatcheType;
    map['swatche_value'] = _swatcheValue;
    if (_imagesMd != null) {
      map['images_md'] = _imagesMd?.map((v) => v.toJson()).toList();
    }
    if (_imagesSm != null) {
      map['images_sm'] = _imagesSm?.map((v) => v.toJson()).toList();
    }
    if (_variantRelativePath != null) {
      map['variant_relative_path'] = _variantRelativePath?.map((v) => v.toJson()).toList();
    }
    map['cart_count'] = _cartCount;
    map['is_purchased'] = _isPurchased;
    return map;
  }

}