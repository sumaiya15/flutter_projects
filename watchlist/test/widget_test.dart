import 'package:flutter_test/flutter_test.dart';
import 'package:watchlist/Repository/repository.dart';

void main(){
  test(" Fetch API Data", () async {
    final contacts = await Repository.fetchContacts(1, 20);
    bool done = contacts.isNotEmpty;
    expect(done, true);
  });
  
}