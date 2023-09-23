// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_gallery/models/webimage.dart';
import 'package:flutter_app_gallery/widgets/imageCard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:flutter_app_gallery/pages/favorites_page.dart';

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

  });

  testWidgets('ImageCard Widget Test with Favorite', (WidgetTester tester) async {
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
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

  });

  testWidgets('FavoritesWidget Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await mockNetworkImagesFor(() async =>
    await tester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: FavoritesPage(
            favoriteImages: [
              WebImage(author: 'Author 1', download_url: 'url1', id: '1', width: 400, height: 400, url: ''),
              WebImage(author: 'Author 2', download_url: 'url2', id: '2', width: 400, height: 400, url: ''),
            ],
          ),
        ),
      ),
    ),
    );

    // Verify if the app bar title is correct
    expect(find.text('Favorites'), findsOneWidget);

    // Verify if there are two ImageCards (based on sample data provided)
    expect(find.byType(ImageCard), findsNWidgets(2));

    // Verify if the ImageCards have the correct author names
    expect(find.text('Author 1'), findsOneWidget);
    expect(find.text('Author 2'), findsOneWidget);
  });

}

void addFavorite(currentImage) {
  currentImage;
}
