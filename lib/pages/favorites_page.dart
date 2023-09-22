import 'package:flutter/material.dart';
import 'package:flutter_app_gallery/widgets/imageCard.dart';
import 'package:flutter_app_gallery/models/webimage.dart';

class FavoritesPage extends StatefulWidget {
  final List<WebImage> favoriteImages;

  const FavoritesPage({super.key, required this.favoriteImages});

  @override
  FavoritesPageState createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPage> {
  void removeFromFavorites(WebImage image) {
    setState(() {
      widget.favoriteImages.remove(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text(
            'Favorites',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        )),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.favoriteImages.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 400.0,
            height: 475.0,
            child: ImageCard(
              authorName: widget.favoriteImages[index].author,
              imageUrl: widget.favoriteImages[index].download_url,
              isFavorite: true,
              onTapFavorite: () {
                removeFromFavorites(widget.favoriteImages[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
