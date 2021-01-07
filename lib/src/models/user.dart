class User {
  String name;
  String phone;
  String password;
  String urlAvatar;

  User({this.name, this.phone, this.password, this.urlAvatar});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    urlAvatar = json['urlAvatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['urlAvatar'] = this.urlAvatar;
    return data;
  }
}
