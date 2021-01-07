import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/shoes.dart';
import 'package:flutter_app/src/services/shoes_service.dart';
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
                        Container(
                          padding: EdgeInsets.all(5.0),
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            color: Colors.white38,
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 22.0,
                          ),
                        ),
                        Container(
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
                      ],
                    ),
                  ),
                ]),
              ],
            ),
    );
  }
}
