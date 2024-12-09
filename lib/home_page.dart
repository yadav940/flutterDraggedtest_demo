import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _valueDroppedItem = 0;
  int _valuePickedItem = 0;
  List<int> list = [0, 1, 2, 3, 4];
  void _acceptDraggedItem(int index) {
    setState(() {
      _valueDroppedItem = index;
      int pikedIndex = list.indexOf(_valuePickedItem);
      int droppedIndex = list.indexOf(_valueDroppedItem);
// Swap the values
      list[pikedIndex] = _valueDroppedItem;
      list[droppedIndex] = _valuePickedItem;
    });
  }

  void _setIsDragging(int index) {
    setState(() {
      _valuePickedItem = index;
    });
  }

  void _resetIsDragging() {
  }
  BoxDecoration getBoxDecoration (IconData e){

    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.primaries[e.hashCode % Colors.primaries.length],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black12,
          ),
          child: Wrap(
              children:  [
                for (int index in list) ...[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DragTarget<int>(
                      builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                          ) {
                        return Draggable<int>(
                          data: index,
                          childWhenDragging: const SizedBox(
                            height: 1,
                            width: 1,
                          ),
                          onDragStarted: () {
                            _setIsDragging(index);
                          },
                          onDraggableCanceled: (_, __) {
                            _resetIsDragging();
                          },
                          onDragCompleted: () {
                            _resetIsDragging();
                          },
                          feedback: getOptions(index),
                          child: getOptions(index),
                        );
                      },
                      onAccept: (int data) {
                        _acceptDraggedItem(index);
                      },
                    ),
                  )
                ]
                //return ;
              ]),
        ),
      ),
    );
  }

  Widget getOptions(int index){
    return Tooltip(
      verticalOffset: -70,
      message: getItemText(index),
      child: Container(
        height: 50,
        width: 50,
        decoration: getBoxDecoration(getItem(index)),
        child: Icon( getItem(index),color: Colors.white,),
      ),
    );
  }

  IconData getItem(int index) {
    IconData widget = Icons.add;
    switch (index) {
      case 0:
        widget =  Icons.person;
      case 1:
        widget = Icons.message ;
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
        text =  "person";
      case 1:
        text = "message" ;
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