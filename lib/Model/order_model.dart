class OrderModel {
  int? count;
  int? pages;
  List<OrderModelItem>? results;

  OrderModel({this.count, this.pages, this.results});

  OrderModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pages = json['pages'];
    if (json['results'] != null) {
      results = <OrderModelItem>[];
      json['results'].forEach((v) {
        results!.add(new OrderModelItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['pages'] = this.pages;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderModelItem {
  int? id;
  String? status;
  String? name;
  String? address;
  String? location;
  String? phone;
  String? notes;
  int? totalQuantity;
  String? subtotal;
  String? shipping;
  String? total;
  int? deliveryId;
  String? createdAt;
  String? updatedAt;
  String? updatedTime;
  int? time;
  int? userId;
  User? user;
  List<CartProducts>? cartProducts;

  OrderModelItem(
      {this.id,
      this.status,
      this.name,
      this.address,
      this.location,
      this.phone,
      this.notes,
      this.totalQuantity,
      this.subtotal,
      this.shipping,
      this.total,
      this.deliveryId,
      this.createdAt,
      this.updatedAt,
      this.updatedTime,
      this.time,
      this.userId,
      this.user,
      this.cartProducts});

  OrderModelItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    address = json['address'];
    location = json['location'];
    phone = json['phone'];
    notes = json['notes'];
    totalQuantity = json['total_quantity'];
    subtotal = json['subtotal'];
    shipping = json['shipping'];
    total = json['total'];
    deliveryId = json['deliveryId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    updatedTime = json['updatedTime'];
    time = json['time'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['cart_products'] != null) {
      cartProducts = <CartProducts>[];
      json['cart_products'].forEach((v) {
        cartProducts!.add(new CartProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['name'] = this.name;
    data['address'] = this.address;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['notes'] = this.notes;
    data['total_quantity'] = this.totalQuantity;
    data['subtotal'] = this.subtotal;
    data['shipping'] = this.shipping;
    data['total'] = this.total;
    data['deliveryId'] = this.deliveryId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.cartProducts != null) {
      data['cart_products'] =
          this.cartProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? phone;
  String? address;

  User({this.id, this.name, this.phone, this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}

class CartProducts {
  int? id;
  int? quantity;
  String? notes;
  String? subtotal;
  String? total;
  bool? ordered;
  String? createdAt;
  String? updatedAt;
  int? cartId;
  int? orderId;
  int? productId;
  Product? product;
  List<Options>? options;

  CartProducts(
      {this.id,
      this.quantity,
      this.notes,
      this.subtotal,
      this.total,
      this.ordered,
      this.createdAt,
      this.updatedAt,
      this.cartId,
      this.orderId,
      this.productId,
      this.product,
      this.options});

  CartProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    notes = json['notes'];
    subtotal = json['subtotal'];
    total = json['total'];
    ordered = json['ordered'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    cartId = json['cartId'];
    orderId = json['orderId'];
    productId = json['productId'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['notes'] = this.notes;
    data['subtotal'] = this.subtotal;
    data['total'] = this.total;
    data['ordered'] = this.ordered;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['cartId'] = this.cartId;
    data['orderId'] = this.orderId;
    data['productId'] = this.productId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  String? title;
  String? description;
  String? price;
  bool? showPrice;
  bool? available;
  bool? featured;
  int? orders;
  String? createdAt;
  String? updatedAt;
  int? vendorId;
  int? categoryId;
  Userr? user;

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.showPrice,
      this.available,
      this.featured,
      this.orders,
      this.createdAt,
      this.updatedAt,
      this.vendorId,
      this.categoryId,
      this.user});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    showPrice = json['show_price'];
    available = json['available'];
    featured = json['featured'];
    orders = json['orders'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    vendorId = json['vendorId'];
    categoryId = json['categoryId'];
    user = json['user'] != null ? new Userr.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['show_price'] = this.showPrice;
    data['available'] = this.available;
    data['featured'] = this.featured;
    data['orders'] = this.orders;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['vendorId'] = this.vendorId;
    data['categoryId'] = this.categoryId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Userr {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  Vendor? vendor;

  Userr(
      {this.id, this.name, this.email, this.phone, this.address, this.vendor});

  Userr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    vendor =
        json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.toJson();
    }
    return data;
  }
}

class Vendor {
  int? id;
  String? direction;
  String? distance;

  Vendor({this.id, this.direction, this.distance});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    direction = json['direction'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['direction'] = this.direction;
    data['distance'] = this.distance;
    return data;
  }
}

class Options {
  int? id;
  String? name;
  String? value;
  String? createdAt;
  String? updatedAt;
  int? optionsGroupId;
  CartProductOption? cartProductOption;

  Options(
      {this.id,
      this.name,
      this.value,
      this.createdAt,
      this.updatedAt,
      this.optionsGroupId,
      this.cartProductOption});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    optionsGroupId = json['optionsGroupId'];
    cartProductOption = json['cart_product_option'] != null
        ? new CartProductOption.fromJson(json['cart_product_option'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['optionsGroupId'] = this.optionsGroupId;
    if (this.cartProductOption != null) {
      data['cart_product_option'] = this.cartProductOption!.toJson();
    }
    return data;
  }
}

class CartProductOption {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? cartProductId;
  int? optionId;

  CartProductOption(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.cartProductId,
      this.optionId});

  CartProductOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    cartProductId = json['cartProductId'];
    optionId = json['optionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['cartProductId'] = this.cartProductId;
    data['optionId'] = this.optionId;
    return data;
  }
}
