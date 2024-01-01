class ProductModal {
  String? sId;
  String? category;
  String? title;
  String? description;
  int? price;
  List<String>? images;
  String? createdOn;
  String? updatedOn;

  ProductModal(
      {this.sId,
      this.category,
      this.title,
      this.description,
      this.price,
      this.images,
      this.createdOn,
      this.updatedOn});

  ProductModal.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    images = json['images'].cast<String>();
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['category'] = this.category;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['images'] = this.images;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    return data;
  }
}
