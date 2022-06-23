import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/application_layer/listing_details_page.dart';
import 'package:flutter_assignment/application_layer/widgets/post_list_item_widget.dart';
import 'package:flutter_assignment/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "New litsting should be scrolled and clicking on a new list card should open the url of the post",
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
//find and tap the tab
      final hotListingTab = find.byKey(const ValueKey('new-tab'));
      await tester.tap(hotListingTab);
      await tester.pumpAndSettle();
      // find and tap scroll the listview
      final hotListingScroll = find.byKey(const ValueKey('new-listview'));
      await tester.pumpAndSettle();
      await tester.fling(hotListingScroll, const Offset(0, -700), 10000);
      await tester.pumpAndSettle();
      await tester.fling(hotListingScroll, const Offset(0, 700), 10000);
      await tester.pumpAndSettle();
      expect(hotListingTab, findsOneWidget);

      //
      final fistItem = find.byType(PostListItem).first;
      await tester.tap(fistItem);
      await tester.pumpAndSettle();

      final postDetailPage = find.byType(ListingDetailsPage);

      expect(postDetailPage, findsOneWidget);

      sleep(const Duration(seconds: 3));
    },
  );
}
