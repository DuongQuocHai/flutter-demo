import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/shoes.dart';
import 'package:flutter_app/src/services/shoes_service.dart';
import 'package:flutter_app/src/ui/shoes_modify_screen.dart';
import 'package:flutter_app/src/widgets/dialog_delete_shoes.dart';
import 'package:flutter_app/src/widgets/ItemShoes.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_app/src/models/api_response.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ShoesService get service => GetIt.I<ShoesService>();
  APIResponse<List<Shoes>> _apiResponse;
  bool _isLoading = false;
  List<int> arrRandom = [];
  var data = [];

  @override
  void initState() {
    _fectchShoes();
    var rng = new Random();
    for (var i = 0; i < 10; i++) {
      arrRandom.add(rng.nextInt(100));
    }
    super.initState();
  }

  _fectchShoes() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getShoes();
    data = _apiResponse.data;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ShoesModifyScreen()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("HOME SCREEN"),
        ),
        body: Builder(builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (_apiResponse.error) {
            return Center(child: Text(_apiResponse.errorMessage));
          }
          return ListView.separated(
              padding: EdgeInsets.all(20.0),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (_, index) {
                return Dismissible(
                  key: ValueKey(_apiResponse.data[index].name),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: context, builder: (_) => DialogDeleteShoes());
                    return result;
                  },
                  child: ItemShoes(
                      title: data[index].name,
                      urlImage: data[index].images,
                      shopInfo: data[index].shopInfo,
                      price: data[index].price.toString(),
                      id: data[index].sId,
                      rating: data[index].rating.toDouble(),
                      sale: arrRandom[index]),
                );
              },
              itemCount: data.length);
        }));
  }
}
