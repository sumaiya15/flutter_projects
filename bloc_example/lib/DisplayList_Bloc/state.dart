
import 'package:flutter/material.dart';

class InputState {
  final List<String> inputList;
  final String validationMessage;
  final Color textColor; // Add this property for text color

  InputState(this.inputList, {this.validationMessage = '', this.textColor = Colors.black});
}
