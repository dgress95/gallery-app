import 'package:flutter/material.dart';
import 'package:flutter_app_gallery/widgets/imageCard.dart';
import 'package:flutter_app_gallery/models/webimage.dart';


class FavoritesPage extends StatelessWidget {
  final List<WebImage> favoriteImages;

  const FavoritesPage({super.key, required this.favoriteImages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteImages.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 400.0,
            height: 450.0,
            child: ImageCard(
              authorName: favoriteImages[index].author,
              imageUrl: favoriteImages[index].download_url,
              onTapFavorite: () {
                // Handle removing from favorites (if needed)
              },
            ),
          );
        },
      ),
    );
  }
}
