class Shoes {
  String sId;
  String name;
  int price;
  String images;
  String shopInfo;
  String description;
  int rating;
  int totalRated;
  int iV;

  Shoes(
      {this.sId,
      this.name,
      this.price,
      this.images,
      this.shopInfo,
      this.description,
      this.rating,
      this.totalRated,
      this.iV});

  Shoes.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    images = json['images'];
    shopInfo = json['shop_info'];
    description = json['description'];
    rating = json['rating'];
    totalRated = json['total_rated'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['images'] = this.images;
    data['shop_info'] = this.shopInfo;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['total_rated'] = this.totalRated;
    data['__v'] = this.iV;
    return data;
  }
}
