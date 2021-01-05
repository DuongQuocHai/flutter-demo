import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/models/shoes.dart';

class ItemShose extends StatelessWidget {
  String title;

  ItemShose({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(title),
        ),
      ],
    );
  }
}
