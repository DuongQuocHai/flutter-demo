import 'dart:convert';

import 'package:flutter_app/src/models/api_response.dart';
import 'package:flutter_app/src/models/shoes.dart';
import 'package:http/http.dart' as http;

class ShoesService {
  static const API = 'http://footcer-shop.herokuapp.com';

  Future<APIResponse<List<Shoes>>> getShoes() {
    return http.get(API + '/shoes', headers: {}).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final shoes = <Shoes>[];
        for (var item in jsonData) {
          final shoe = Shoes(
            sId: item['_id'],
            name: item['name'],
            price: item['price'],
            images: item['images'],
            shopInfo: item['shop_info'],
            description: item['description'],
            rating: item['rating'],
            totalRated: item['total_rated'],
          );
          shoes.add(shoe);
        }
        return APIResponse<List<Shoes>>(data: shoes);
      }
      return APIResponse<List<Shoes>>(
          error: true, errorMessage: 'An error occurred');
    }).catchError((_) =>
        APIResponse<List<Shoes>>(
            error: true, errorMessage: 'An error occurred'));
  }
}
