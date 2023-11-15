import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/Bloc/contact_bloc.dart';
import 'package:watchlist/Bloc/contact_event.dart';
import 'package:watchlist/Bloc/contact_state.dart';

class WatchlistPage extends StatefulWidget {

  final int contactStartId;
  final int contactEndId;

  const WatchlistPage({super.key,  required this.contactStartId, required this.contactEndId});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  bool isAscending = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactBloc(),
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactInitial) {
            context.read<ContactBloc>().add(FetchContactsEvent(widget.contactStartId, widget.contactEndId));
          }

          if (state is ContactLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ContactLoaded) {
            final contacts = isAscending
                ? List.from(state.contacts)
                : List.from(state.contacts.reversed);

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                  children: [
                    const Text('ID', style: TextStyle( fontSize: 15),),
                    IconButton(
                      icon: Icon(isAscending ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
                      onPressed: () {
                        isAscending = !isAscending;
                        context.read<ContactBloc>().add(FetchContactsEvent(widget.contactStartId, widget.contactEndId));
                      },
                    ),
                    const SizedBox(width: 50,),
                    const Text('Name', style: TextStyle( fontSize: 15),),
                    IconButton(
                      icon: Icon(isAscending ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
                      onPressed: () {
                        isAscending = !isAscending;
                        context.read<ContactBloc>().add(FetchContactsEvent(widget.contactStartId, widget.contactEndId));
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Container( 
                    color: const Color.fromARGB(255, 236, 241, 241),
                    child: ListView.builder(
                      //shrinkWrap: true,
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        final contact = contacts[index];
                        return Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Card(
                            color: Colors.white,
                            child: ListTile(
                              trailing: const CircleAvatar(
                                backgroundImage: AssetImage('assets/person_img.png'),
                              ),
                              title: Text(contact.name),
                              subtitle: Text(contact.phoneNumber),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is ContactError) {
            return Text(state.error);
          }

          return Container(
            color: const Color.fromARGB(255, 173, 170, 170),
          );
        },
      ),
    );
  }
}
