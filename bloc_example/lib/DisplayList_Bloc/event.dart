// Event
abstract class InputEvent {}

class AddInputEvent extends InputEvent {
  final String input;
  AddInputEvent(this.input);
}

