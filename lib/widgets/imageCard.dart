import 'dart:io';

import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget{
  final String authorName;
  final String imageUrl;
  final Function() onTapFavorite;

  const ImageCard({super.key,
    required this.authorName,
    required this.imageUrl,
    required this.onTapFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.deepPurple,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0,30.0,8.0,30.0),
        child: Flex(
          direction: Axis.vertical,
          children: [ 
            Text(
              authorName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.0,
              )
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Image.network(imageUrl)
                ],
              ),
            ),
            TextButton.icon(
              onPressed: onTapFavorite, // Toggle the favorite status
              icon: const Icon(
                // isFavorite ? Icons.favorite : Icons.favorite_border,
                Icons.favorite,
                color: Colors.redAccent,
              ),
              label: const Text(
                  // isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
                  'Add to favorites',
                  style: TextStyle(
                    color: Colors.redAccent,
                )
              )
            )
          ],
        ),
      )
    );
  }
}
  