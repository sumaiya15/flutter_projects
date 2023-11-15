import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/Bloc/contact_event.dart';
import 'package:watchlist/Bloc/contact_state.dart';
import 'package:watchlist/Repository/repository.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial()) {
    on<FetchContactsEvent>((event, emit) async {
      emit(ContactLoading());

      try {
        final contacts = await Repository.fetchContacts(event.contactStartId,event.contactEndId);
        emit(ContactLoaded(contacts));
      } catch (e) {
        emit(ContactError('Failed to load contacts'));
      }
    });
  }  
}
