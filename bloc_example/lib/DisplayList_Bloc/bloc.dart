import 'package:bloc_example/DisplayList_Bloc/event.dart';
import 'package:bloc_example/DisplayList_Bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputBloc extends Bloc<InputEvent, InputState> {
  InputBloc() : super(InputState([])) {
    on<AddInputEvent>(_onAddInput);
  }

  void _onAddInput(AddInputEvent event, Emitter<InputState> emit) {
  final input = event.input;

  // Define a regular expression to check for alphabets only
  final RegExp alphabetsOnly = RegExp(r'^[a-zA-Z]+$');

  if (alphabetsOnly.hasMatch(input)) {
    final updatedList = [...state.inputList, input];
    emit(InputState(updatedList, validationMessage: 'Success', textColor: Colors.green)); // Set text color to green for success
  } else {
    emit(InputState(state.inputList, validationMessage: 'Invalid input. Please use only alphabets.', textColor: Colors.red)); // Set text color to red for error
  }
}

}
