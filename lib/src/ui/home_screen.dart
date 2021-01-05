import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/shoes.dart';
import 'package:flutter_app/src/widgets/item_shose.dart';

class HomePage extends StatelessWidget {
  final shoes = [
    new Shoes(
        sId: "5fa9425e64ac8b0017c73fc7",
        name: "PUMA Men's Tazon 6 FM Running Shoe",
        price: 721,
        images:
            "https://images.unsplash.com/photo-1593620877307-39a5895e4adc?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjE1NjEwNX0",
        shopInfo: "TSIODFO",
        description:
            "A moustache beautifully compliments his hair and cheekbones and leaves a heartbreaking memory of his luck in battles.",
        rating: 1,
        totalRated: 32,
        iV: 0),
    new Shoes(
        sId: "5fa9425e64ac8b0017c73fc7",
        name:
            "Santiro Men's Running Shoes Breathable Knit Slip On Sneakers Lightweight Athletic Shoes Casual Sports Shoes",
        price: 721,
        images:
            "https://images.unsplash.com/photo-1593620877307-39a5895e4adc?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjE1NjEwNX0",
        shopInfo: "TSIODFO",
        description:
            "A moustache beautifully compliments his hair and cheekbones and leaves a heartbreaking memory of his luck in battles.",
        rating: 1,
        totalRated: 32,
        iV: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("HOME SCREEN"),
      ),
      body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (_, index) {
            return ItemShose(title: shoes[index].name,);
          },
          itemCount: shoes.length),
    );
  }
}
