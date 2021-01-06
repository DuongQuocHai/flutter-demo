class ShoeInsert {
  String name;
  int price;
  String images;
  int pricePromotion;
  String shopInfo;
  int orderCount;
  String description;
  int rating;
  int totalRated;

  ShoeInsert(
      {this.name,
      this.price,
      this.images,
      this.pricePromotion,
      this.shopInfo,
      this.orderCount,
      this.description,
      this.rating,
      this.totalRated});

  ShoeInsert.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    images = json['images'];
    pricePromotion = json['price_promotion'];
    shopInfo = json['shop_info'];
    orderCount = json['order_count'];
    description = json['description'];
    rating = json['rating'];
    totalRated = json['total_rated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['images'] = this.images;
    data['price_promotion'] = this.pricePromotion;
    data['shop_info'] = this.shopInfo;
    data['order_count'] = this.orderCount;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['total_rated'] = this.totalRated;
    return data;
  }
}
