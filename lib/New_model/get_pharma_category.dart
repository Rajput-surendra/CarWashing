class GetPharmaCategory {
  bool? error;
  String? message;
  List<PharmaCategory>? data;

  GetPharmaCategory({this.error, this.message, this.data});

  GetPharmaCategory.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PharmaCategory>[];
      json['data'].forEach((v) {
        data!.add( PharmaCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PharmaCategory {
  String? id;
  String? name;
  String? parentId;
  String? slug;
  String? image;
  String? banner;
  String? rowOrder;
  String? status;
  String? catType;
  String? clicks;

  PharmaCategory(
      {this.id,
        this.name,
        this.parentId,
        this.slug,
        this.image,
        this.banner,
        this.rowOrder,
        this.status,
        this.catType,
        this.clicks});

  PharmaCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    slug = json['slug'];
    image = json['image'];
    banner = json['banner'];
    rowOrder = json['row_order'];
    status = json['status'];
    catType = json['cat_type'];
    clicks = json['clicks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['banner'] = this.banner;
    data['row_order'] = this.rowOrder;
    data['status'] = this.status;
    data['cat_type'] = this.catType;
    data['clicks'] = this.clicks;
    return data;
  }
}
