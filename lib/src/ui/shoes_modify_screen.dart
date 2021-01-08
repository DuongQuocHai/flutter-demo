import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/shoes.dart';
import 'package:flutter_app/src/services/shoes_service.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

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
  TextEditingController _desciptionController = new TextEditingController();

  bool _isLoading = false;

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
        _desciptionController.text = shoe.description;
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
                  isEditing
                      ? Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                              Container(
                                width: double.infinity,
                                height: 250,
                                child: ClipRRect(
                                  child: _image == null
                                      ? Image(
                                          image: NetworkImage(shoe.images),
                                          fit: BoxFit.fitWidth,
                                        )
                                      : Image.file(
                                          _image,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20.0, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: getImage,
                                      child: Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          color: Colors.white38,
                                        ),
                                        child: Icon(
                                          Icons.camera,
                                          color: Colors.white,
                                          size: 22.0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ])
                      : Container(
                          width: double.infinity,
                          height: 250,
                          child: RaisedButton(
                            onPressed: getImage,
                            child: _image == null
                                ? Icon(
                                    Icons.camera,
                                    color: Colors.black,
                                    size: 50.0,
                                  )
                                : Container(
                                    width: double.infinity,
                                    height: 250,
                                    child: Image.file(
                                      _image,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
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
                  TextField(
                    maxLines: 5,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    controller: _desciptionController,
                    decoration: InputDecoration(
                        labelText: "DESCRIPTION",
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
