import 'package:flutter/material.dart';
import 'package:fluttertest/home_page_controller.dart';
import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  final HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      backgroundColor: Colors.white,
      body: Obx(() => Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black12,
              ),
              child: Wrap(children: [
                for (int index in homePageController.list) ...[
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
                          childWhenDragging:
                              const SizedBox(height: 1, width: 1),
                          onDragStarted: () {
                            homePageController.setIsDragging(index);
                          },
                          feedback: getOptions(index),
                          child: getOptions(index),
                        );
                      },
                      onAccept: (int data) {
                        homePageController.acceptDraggedItem(index);
                      },
                    ),
                  )
                ]
                //return ;
              ]),
            ),
          )),
    );
  }

  BoxDecoration getBoxDecoration(IconData e) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.primaries[e.hashCode % Colors.primaries.length],
    );
  }

  Widget getOptions(int index) {
    String message = homePageController.getItemText(index);
    IconData iconData = homePageController.getItem(index);
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
}
