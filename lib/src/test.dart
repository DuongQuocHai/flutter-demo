// import 'package:ecsa/models/FileTab.dart';
// import 'package:ecsa/screens/main/loadfile/LoadFileController.dart';
// import 'package:ecsa/widgets/loadfile/TabFileData.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class TabFile extends StatelessWidget {
//   TabFile({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LoadFileController>(builder: (controller) {
//       if (controller.statePageLeft.value == 'full') {
//         return Container(
//             width: controller.heightPageLeft.value,
//             child: DefaultTabController(
//               length: controller.listFileTab.length,
//               child: Container(
//                   child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     child: TabBar(
//                       onTap: (int index) {
//                         controller.changeCurrentFileTab(index);
//                       },
//                       labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
//                       isScrollable: true,
//                       indicatorWeight: 3,
//                       indicatorColor: Colors.blue[200],
//                       labelColor: Colors.blue[400],
//                       unselectedLabelColor: Colors.black,
//                       tabs: getListTab(controller.listFileTab),
//                     ),
//                   ),
//                   Expanded(
//                       child: Container(
//                           margin: EdgeInsets.only(top: 8.0),
//                           child: TabBarView(
//                             children: getListTabView(controller.listFileTab),
//                           )))
//                 ],
//               )),
//             ));
//       } else {
//         return SizedBox.shrink();
//       }
//     });
//   }

//   List<Widget> getListTab(List<FileTab> listFileTab) {
//     List<Widget> list = [];
//     listFileTab.forEach((element) {
//       list.add(
//         new Stack(
//           children: <Widget>[
//             Wrap(children: <Widget>[
//               Container(
//                   child: Tab(
//                     iconMargin: EdgeInsets.all(0),
//                     text: element.name,
//                   ),
//                   padding: EdgeInsets.only(right: 20)),
//             ]),
//           ],
//         ),
//       );
//     });
//     return list;
//   }
// }

// List<Widget> getListTabView(List<FileTab> list) {
//   List<Widget> newList = [];
//   list.forEach((element) {
//     newList.add(new TabFileData(
//       fileTab: element,
//     ));
//   });
//   return newList;
// }

import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        height: 500,
        child: DefaultTabController(
          length: 3,
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: TabBar(
                  labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                  indicatorWeight: 3,
                  indicatorColor: Colors.blue[200],
                  labelColor: Colors.blue[400],
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(icon: Icon(Icons.directions_car)),
                    Tab(icon: Icon(Icons.directions_transit)),
                    Tab(icon: Icon(Icons.directions_bike)),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 8.0),
                      child: TabBarView(
                        children: [
                          Center(child: Text("Car")),
                          Center(child: Text("Transit")),
                          Center(child: Text("Bike"))
                        ],
                      )))
            ],
          )),
        ));
    ;
  }
}
