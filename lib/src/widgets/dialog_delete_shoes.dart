import 'package:flutter/material.dart';

class DialogDeleteShoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text('Are you sure you want to delete this shoes?'),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('NO')),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('YES')),
      ],
    );
  }
}
