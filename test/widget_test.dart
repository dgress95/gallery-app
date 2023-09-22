// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_gallery/widgets/imageCard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ImageCard Widget Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await mockNetworkImagesFor(() async =>
    await tester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: ImageCard(
            authorName: 'John Doe',
            imageUrl: 'https://example.com/image.jpg',
            isFavorite: false,
            onTapFavorite: () {},
          ),
        ),
      ),
    ));

    // Verify that our card and its contents exist
    expect(find.byType(Card), findsOneWidget);
    expect(find.text("John Doe"), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Verify that the favorite button is there
    expect(find.byType(TextButton), findsOneWidget);

    // Tap on the favorite button
    await tester.tap(find.byType(TextButton));
    await tester.pump();

    // Verify that the onTapFavorite function is called
    // Add your verification logic here
  });

  testWidgets('ImageCard Widget Test with Favorite', (WidgetTester tester) async {
    // Build our widget with favorite status and trigger a frame.
    await mockNetworkImagesFor(() async =>
    await tester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: ImageCard(
            authorName: 'Jane Doe',
            imageUrl: 'https://example.com/image2.jpg',
            isFavorite: true,
            onTapFavorite: () {},
          ),
        ),
      ),
    ));

    // Verify that the favorite icon is filled
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    // Tap on the favorite button
    await tester.tap(find.byType(TextButton));
    await tester.pump();

    // Verify that the onTapFavorite function is called
    // Add your verification logic here
  });
}
