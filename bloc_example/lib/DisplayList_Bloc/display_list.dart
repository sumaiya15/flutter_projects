import 'package:bloc_example/DisplayList_Bloc/bloc.dart';
import 'package:bloc_example/DisplayList_Bloc/event.dart';
import 'package:bloc_example/DisplayList_Bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayList extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  DisplayList({super.key});

  @override
  Widget build(BuildContext context) {
    final inputBloc = BlocProvider.of<InputBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Enter Text'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('Add to List'),
              onPressed: () {
                final input = _textController.text;
                if (input.isNotEmpty) {
                  inputBloc.add(AddInputEvent(input));
                  _textController.clear();
                } else {
                  inputBloc.add(AddInputEvent('')); // Trigger validation message for empty input
                }
              },
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  BlocBuilder<InputBloc, InputState>(
                    builder: (context, state) {
                      return Text(
                        state.validationMessage,
                        style: TextStyle(
                          color: state.textColor,
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: BlocBuilder<InputBloc, InputState>(
                      builder: (context, state) {
                        return ListView.builder(
                          itemCount: state.inputList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(state.inputList[index]),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
