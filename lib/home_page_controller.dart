import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  int valueDroppedItem = 0;
  int valuePickedItem = 0;
  RxList<int> list = [0, 1, 2, 3, 4].obs;

  void acceptDraggedItem(int index) {
    valueDroppedItem = index;
    int pikedIndex = list.indexOf(valuePickedItem);
    int droppedIndex = list.indexOf(valueDroppedItem);
// Swap the values
    if (pikedIndex > droppedIndex) {
      for (int i = pikedIndex; i >= droppedIndex; i--) {
        if (i == droppedIndex) {
          list[i] = valuePickedItem;
          break;
        }
        list[i] = list[i - 1];
      }
    } else {
      for (int i = pikedIndex; i <= droppedIndex; i++) {
        if (i == droppedIndex) {
          list[i] = valuePickedItem;
          break;
        }
        list[i] = list[i + 1];
      }
    }
  }

  void setIsDragging(int index) {
    valuePickedItem = index;
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
