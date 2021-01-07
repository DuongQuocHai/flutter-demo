import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/shoes.dart';
import 'package:flutter_app/src/services/shoes_service.dart';
import 'package:get_it/get_it.dart';

// ignore: must_be_immutable
class ShoesModifyScreen extends StatefulWidget {
  String shoesId;

  ShoesModifyScreen({Key key, this.shoesId}) : super(key: key);

  @override
  _ShoesModifyScreenState createState() => _ShoesModifyScreenState();
}

class _ShoesModifyScreenState extends State<ShoesModifyScreen> {
  bool get isEditing => widget.shoesId != null;
  ShoesService get service => GetIt.I<ShoesService>();
  String errMess;
  Shoes shoe;

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();

  bool _isLoading = false;
  @override
  void initState() {
    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      service.getDetailShoe(widget.shoesId).then((res) {
        setState(() {
          _isLoading = false;
        });
        if (res.error) {
          errMess = res.errorMessage ?? 'An err occurred';
        }
        shoe = res.data;
        _nameController.text = shoe.name;
        _priceController.text = shoe.price.toString();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit shoes' : "Create shoes"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    child: Image(
                      image: NetworkImage(shoe.images),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  TextField(
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    controller: _nameController,
                    decoration: InputDecoration(
                        labelText: "NAME",
                        labelStyle:
                            TextStyle(color: Colors.black38, fontSize: 13)),
                  ),
                  TextField(
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    controller: _priceController,
                    decoration: InputDecoration(
                        labelText: "PRICE",
                        labelStyle:
                            TextStyle(color: Colors.black38, fontSize: 13)),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: RaisedButton(
                      color: isEditing ? Colors.deepOrange : Colors.blue,
                      onPressed: () {
                        if (isEditing) Navigator.of(context).pop();
                      },
                      child: Text(
                        isEditing ? 'Edit' : "Create",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
