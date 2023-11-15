import 'package:watchlist/Model/model.dart';

abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  final List<Contact> contacts;
  ContactLoaded(this.contacts);
}

class ContactError extends ContactState {
  final String error;
  ContactError(this.error);
}