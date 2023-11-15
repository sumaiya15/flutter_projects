
import 'package:flutter_test/flutter_test.dart';
import 'package:watchlist/Screens/watchlist_screen.dart';

void main(){
 testWidgets('Check Soring Order', (WidgetTester tester) async{
    bool isAscending = true;
    await tester.pumpWidget(const WatchlistPage(contactStartId: 1, contactEndId: 20));
    expect(isAscending, true);
  });
}