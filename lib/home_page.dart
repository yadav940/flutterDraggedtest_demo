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
                          onDragCompleted: (){

                            debugPrint("-----onDragCompleted----");
                          },
                          onDragEnd: (DraggableDetails data){

                            debugPrint("-----onDragEnd--offset--${data.offset}-----");
                          },
                          onDraggableCanceled: (Velocity v,Offset offset){
                            //debugPrint("-----onDraggableCanceled--offset--${offset}-----");

                          },
                          onDragUpdate: (DragUpdateDetails data){

                            // if(data.delta.dx>-1.3 && data.delta.dx<-0.5){
                            //   homePageController.acceptDraggedItem(3);
                            // }
                            // if(data.delta.dx>-0.5 && data.delta.dx<0.3){
                            //   homePageController.acceptDraggedItem(2);
                            // }
                            // if(data.delta.dx>-0.5 && data.delta.dx<0.0){
                            //   homePageController.acceptDraggedItem(1);
                            // }



                            debugPrint("-----onDragUpdate--delta--${data.delta}-----");

                          },
                          feedback: getOptions(index),
                          child: AnimatedScale(
                            scale: homePageController.valuePickedItem == index
                                ? 1.1
                                : 1,
                            duration: const Duration(milliseconds: 200),
                            child: getOptions(index),
                          ),
                        );
                      },
                      onAccept: (int data) {
                        homePageController.acceptDraggedItem(index);
                      },
                      onLeave: (int? data){

                        //debugPrint("-----onLeave----$data-----");
                      },
                      onMove: (DragTargetDetails<int> data){
                        //debugPrint("-----onMove-----${data.data}---");
                        //homePageController.acceptDraggedItem(data.data);
                      },
                        hitTestBehavior:HitTestBehavior.opaque,
                      onWillAccept: (int? data){

                        //debugPrint("-----onWillAccept-----${data}---");
                        return true;
                      },
                      // onAcceptWithDetails: (DragTargetDetails<int> data){
                      //   debugPrint("-----onAcceptWithDetails-----${data.data}---");
                      //   homePageController.acceptDraggedItem(data.data);
                      // },
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
