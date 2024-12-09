import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  int _valueDroppedItem = 0;
  int _valuePickedItem = 0;
  var list = [0, 1, 2, 3, 4].obs;

  void acceptDraggedItem(int index) {
    _valueDroppedItem = index;
    int pikedIndex = list.indexOf(_valuePickedItem);
    int droppedIndex = list.indexOf(_valueDroppedItem);
// Swap the values
    list[pikedIndex] = _valueDroppedItem;
    list[droppedIndex] = _valuePickedItem;
  }

  void setIsDragging(int index) {
    _valuePickedItem = index;
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
