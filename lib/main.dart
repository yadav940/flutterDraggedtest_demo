// import 'package:flutter/material.dart';
//
// import 'home_page.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       title: 'Vinod Demo',
//       home: MyHomePage(title: 'Vinod Demo '),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:fluttertest/home_page_controller.dart';
import 'package:get/get.dart';

import 'dragging.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Vinod demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({ Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List array = [0,1, 2, 3, 4];

  //final HomePageController homePageController = Get.put(HomePageController());

  void _update(old, ew) {
    setState(() {
      try{
        // if(ew==5){
        //   ew=0;
        // }
        if(old<ew){
          var el = array[old];
          array.removeAt(old);
          array.insert(ew-1, el);
        }else{
          var el = array[old];
          array.removeAt(old);
          array.insert(ew, el);
        }
      }catch (_){
        array= [0,1, 2, 3, 4];
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final Key itemGlobalKey = GlobalKey();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            alignment: Alignment.centerRight,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 150,
              ),
              child: ReorderableListViewCustom(
                //key: itemGlobalKey,
                padding: EdgeInsets.only(bottom: 100),
                scrollDirection: Axis.horizontal,
                  buildDefaultDragHandles:true,
                children: [
                  for (final item in array)
                    Container(
                        key: ValueKey(item),
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.all(2),
                      /*decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                              ),
                            ]),*/
                        child: getOptions(item),
                      ),

                ],
                onReorder: _update,
              ),
            ),
          ),
        ));
  }

  BoxDecoration getBoxDecoration(IconData e) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.primaries[e.hashCode % Colors.primaries.length],
    );
  }

  Widget getOptions(int index) {
    String message = getItemText(index);
    IconData iconData = getItem(index);
    return Tooltip(
      verticalOffset: -70,
      message: message,
      child: Container(
        height: 50,
        width: 50,
        decoration: getBoxDecoration(iconData),
        child: Icon(
          iconData,
          color: Colors.white,
        ),
      ),
    );
  }


  IconData getItem(int index) {
    IconData widget = Icons.add;
    switch (index) {
      case 0:
        widget = Icons.person;
      case 1:
        widget = Icons.message;
      case 2:
        widget = Icons.call;
      case 3:
        widget = Icons.camera;
      case 4:
        widget = Icons.photo;
    }
    return widget;
  }

  String getItemText(int index) {
    String text = "Icons.add";
    switch (index) {
      case 0:
        text = "person";
      case 1:
        text = "message";
      case 2:
        text = "call";
      case 3:
        text = "camera";
      case 4:
        text = "photo";
    }
    return text;
  }
}