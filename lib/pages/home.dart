import 'package:flutter/material.dart';
import 'package:flutter_app_gallery/network/endpoints.dart';
import 'package:flutter_app_gallery/pages/favorites_page.dart';
import 'package:flutter_app_gallery/widgets/imageCard.dart';
import 'package:flutter_app_gallery/models/webimage.dart';
import 'package:flutter_app_gallery/models/webImageList.dart';
import 'package:flutter_app_gallery/network/imageService.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  EndPoints endPoints = EndPoints();
  final ImageWebService imageWebService = ImageWebService(http.Client());
  List<WebImage> favoriteImages = []; // stores favorite images

  void addFavorite(WebImage image) {
    setState(() {
      if (!favoriteImages.any((favImage) => favImage.id == image.id)) { // avoids duplicate favorites
        favoriteImages.add(image);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text(
            'Gallery App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          )
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            color: Colors.white70,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(
                    favoriteImages: favoriteImages, // passes favoriteImages to favorites page
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<WebImageList>(
        future: imageWebService.fetchListOfWebImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: SpinKitRing(
                color: Colors.teal,
                size: 70.0,
              ),
            );
          } if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<WebImage> images = snapshot.data!.webimages;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20, // limit to 20 items per requirements
              itemBuilder: (context, index) {
                WebImage currentImage = images[index];
                bool isFavorite = favoriteImages.contains(currentImage);
                return SizedBox(
                  width: 400.0,
                  height: 450.0,
                  child: ImageCard(
                    authorName: currentImage.author,
                    imageUrl: currentImage.download_url,
                    isFavorite: isFavorite,
                    onTapFavorite: () {
                      addFavorite(currentImage);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}