import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/ui/shoes_modify_screen.dart';

// ignore: must_be_immutable
class ItemShoes extends StatelessWidget {
  String title;
  String urlImage;
  String id;

  ItemShoes({Key key, this.title, this.urlImage, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: [
          Image(
            image: NetworkImage(urlImage),
            height: 150,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ShoesModifyScreen(shoesId: id)));
            },
            child: Text(title),
          ),
        ],
      ),
    );
  }
}
