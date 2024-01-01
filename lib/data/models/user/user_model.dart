class UserModal {
  String? sId;
  String? fullName;
  String? email;
  String? password;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  int? progressNumber;
  String? id;
  String? createdOn;
  String? updatedOn;

  UserModal(
      {this.sId,
      this.fullName,
      this.email,
      this.password,
      this.phoneNumber,
      this.address,
      this.city,
      this.state,
      this.progressNumber,
      this.id,
      this.createdOn,
      this.updatedOn});

  UserModal.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    progressNumber = json['progressNumber'];
    id = json['id'];
    createdOn = json['createdOn'];
    updatedOn = json['updatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['progressNumber'] = this.progressNumber;
    data['id'] = this.id;
    data['createdOn'] = this.createdOn;
    data['updatedOn'] = this.updatedOn;
    return data;
  }
}
