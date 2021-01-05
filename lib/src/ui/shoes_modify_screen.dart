import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShoesModifyScreen extends StatelessWidget {
  String shoesId;

  bool get isEditing => shoesId != null;

  ShoesModifyScreen({Key key, this.shoesId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Create shoes' : "Edit shoes"),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 45,
            child: RaisedButton(
              color: isEditing ? Colors.deepOrange : Colors.blue,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                isEditing ? 'Create' : "Edit",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
