import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/shoes.dart';
import 'package:flutter_app/src/services/shoes_service.dart';
import 'package:flutter_app/src/ui/shoes_modify_screen.dart';
import 'package:flutter_app/src/widgets/dialog_delete_shoes.dart';
import 'package:flutter_app/src/widgets/item_shoes.dart';
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

  @override
  void initState() {
    _fectchShoes();
    super.initState();
  }

  _fectchShoes() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getShoes();
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
      body: _isLoading
          ? CircularProgressIndicator()
          : ListView.separated(
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
                  child: ItemShose(
                    title: _apiResponse.data[index].name,
                    urlImage: _apiResponse.data[index].images,
                    id: _apiResponse.data[index].sId,
                  ),
                );
              },
              itemCount: _apiResponse.data.length),
    );
  }
}
