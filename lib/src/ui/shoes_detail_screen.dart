import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/shoes.dart';
import 'package:flutter_app/src/services/shoes_service.dart';
import 'package:flutter_app/src/test.dart';
import 'package:flutter_app/src/test.dart';
import 'package:flutter_app/src/ui/shoes_modify_screen.dart';
import 'package:flutter_app/src/widgets/RowIconText.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';

class ShoesDetailScreen extends StatefulWidget {
  final String shoesId;
  ShoesDetailScreen({Key key, this.shoesId}) : super(key: key);
  @override
  _ShoesDetailScreenState createState() => _ShoesDetailScreenState();
}

class _ShoesDetailScreenState extends State<ShoesDetailScreen> {
  ShoesService get service => GetIt.I<ShoesService>();
  String errMess;
  Shoes shoe;

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();

  bool _isLoading = false;
  bool _isFavorite = false;
  bool _showTooltip = false;

  @override
  void initState() {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SHOES DETAIL"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                  Container(
                    width: double.infinity,
                    height: 350,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                      child: Image(
                        image: NetworkImage(shoe.images),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.white38,
                            ),
                            child: Icon(
                              Icons.favorite,
                              color: !_isFavorite ? Colors.white : Colors.red,
                              size: 22.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) =>
                                    ShoesModifyScreen(shoesId: shoe.sId)));
                            // setState(() {
                            //   _showTooltip = !_showTooltip;
                            // });
                          },
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.white38,
                            ),
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 22.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0, top: 10.0),
                        child: Text(shoe.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      Text(shoe.price.toString() + " USD",
                          style: TextStyle(fontSize: 18, color: Colors.red)),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: RowIconText(
                            text:
                                "Sold " + shoe.totalRated.toString() + " pairs",
                            iconName: Icons.label,
                            textStyle:
                                TextStyle(color: Colors.green, fontSize: 15),
                            colorIcon: Colors.green[900]),
                      ),
                      Container(
                          width: double.infinity,
                          height: 300,
                          padding: EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 10.0),
                          child: DefaultTabController(
                            length: 2,
                            child: Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: TabBar(
                                    labelPadding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    indicatorWeight: 3,
                                    indicatorColor: Colors.blue[200],
                                    labelColor: Colors.black,
                                    unselectedLabelColor: Colors.black12,
                                    labelStyle: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                    tabs: [
                                      Tab(text: 'Descriptioin'),
                                      Tab(text: 'Star'),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(top: 8.0),
                                        child: TabBarView(
                                          children: [
                                            Container(
                                                child: Text(shoe.description)),
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      shoe.rating.toString(),
                                                      style: TextStyle(
                                                          color: Colors.pink,
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text("/5")
                                                  ],
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  child: RatingBar.builder(
                                                    itemSize: 40,
                                                    initialRating:
                                                        shoe.rating.toDouble(),
                                                    minRating: 0,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: null,
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  child: Text(
                                                    '( ' +
                                                        shoe.totalRated
                                                            .toString() +
                                                        ' votes )',
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        )))
                              ],
                            )),
                          ))
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
