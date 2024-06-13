class UserModel {
  int? id;
  String? name;
  String? image;
  String? email;
  String? address;
  String? phone;
  String? fcm;
  String? role;

  UserModel(
      {this.id,
        this.name,
        this.email,
        this.address,
        this.phone,
        this.image,
        this.fcm,
        this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    address = json['address'];
    phone = json['phone'];
    fcm = json['fcm'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['fcm'] = this.fcm;
    data['role'] = this.role;
    return data;
  }
}
