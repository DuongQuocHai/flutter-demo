import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/ui/shoes_detail_screen.dart';
import 'package:flutter_app/src/widgets/RowIconText.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class ItemShoes extends StatefulWidget {
  String title;
  String urlImage;
  String id;
  String shopInfo;
  String price;
  int sale;
  double rating;

  ItemShoes(
      {Key key,
      this.title,
      this.urlImage,
      this.id,
      this.shopInfo,
      this.price,
      this.rating,
      this.sale})
      : super(key: key);

  @override
  _ItemShoesState createState() => _ItemShoesState();
}

class _ItemShoesState extends State<ItemShoes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ]),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: GestureDetector(
          onTap: _navigateToDetail,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(alignment: AlignmentDirectional.topEnd, children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  child: Image(
                    image: NetworkImage(widget.urlImage),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 30.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 15, right: 15, bottom: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Text(widget.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      Column(
                        children: [
                          RowIconText(
                              text: widget.shopInfo,
                              iconName: Icons.local_mall_outlined),
                          RowIconText(
                            text: widget.price,
                            iconName: Icons.attach_money,
                          )
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SOLD: ${widget.sale} pairs',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: Row(
                                        children: [
                                          RatingBar.builder(
                                            itemSize: 15,
                                            initialRating: widget.rating,
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: null,
                                          ),
                                          Container(
                                              margin:
                                                  EdgeInsets.only(left: 5.0),
                                              child: Text(
                                                '${widget.rating}/5',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            RaisedButton(
                              padding: EdgeInsets.only(
                                  left: 30, right: 30, top: 15, bottom: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              color: Color(0xFF283593),
                              onPressed: _navigateToDetail,
                              child: Row(
                                children: [
                                  Text(
                                    'Add to cart',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ])
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _navigateToDetail() {
  //   Navigator.of(context).push(MaterialPageRoute(
  //       builder: (_) => ShoesModifyScreen(shoesId: widget.id)));
  // }

  void _navigateToDetail() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ShoesDetailScreen(shoesId: widget.id)));
  }
}
