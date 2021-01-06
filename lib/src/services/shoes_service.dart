import 'dart:convert' as convert;
import 'package:flutter_app/src/models/api_response.dart';
import 'package:flutter_app/src/models/shoe_insert.dart';
import 'package:flutter_app/src/models/shoes.dart';
import 'package:http/http.dart' as http;

class ShoesService {
  static const API = 'http://footcer-shop.herokuapp.com';

  Future<APIResponse<List<Shoes>>> getShoes() async {
    try {
      var response = await http.get(API + '/shoes');
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var data = jsonResponse['data'];
        final shoes = <Shoes>[];
        for (var item in data) {
          shoes.add(Shoes.fromJson(item));
        }
        return APIResponse<List<Shoes>>(data: shoes);
      } else {
        return APIResponse<List<Shoes>>(
            error: true, errorMessage: 'An error occurred');
      }
    } catch (err) {
      return APIResponse<List<Shoes>>(
          error: true, errorMessage: 'An error occurred');
    }
  }

  Future<APIResponse<Shoes>> getDetailShoe(String id) async {
    try {
      var response = await http.get(API + '/shoes/' + id);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var data = jsonResponse['data'];
        return APIResponse<Shoes>(data: Shoes.fromJson(data));
      } else {
        return APIResponse<Shoes>(
            error: true, errorMessage: 'An error occurred');
      }
    } catch (err) {
      return APIResponse<Shoes>(error: true, errorMessage: 'An error occurred');
    }
  }

  Future<APIResponse<bool>> createShoe(ShoeInsert item) async {
    try {
      var response = await http.post(API + '/shoes/add', body: item.toJson());
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      } else {
        return APIResponse<bool>(
            error: true, errorMessage: 'An error occurred');
      }
    } catch (err) {
      return APIResponse<bool>(error: true, errorMessage: 'An error occurred');
    }
  }
}
