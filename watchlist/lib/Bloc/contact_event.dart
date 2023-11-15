abstract class ContactEvent {}

class FetchContactsEvent extends ContactEvent {
  final int contactStartId;
  final int contactEndId;
  FetchContactsEvent(this.contactStartId, this.contactEndId);
}