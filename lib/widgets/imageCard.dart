import 'dart:io';

import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget{
  final String authorName;
  final String imageUrl;
  final bool isFavorite;
  final Function()? onTapFavorite; // optional function for adding image card to favorites

  const ImageCard({super.key,
    required this.authorName,
    required this.imageUrl,
    required this.isFavorite,
    required this.onTapFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0,80.0,8.0,30.0),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Text(
              authorName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
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
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.teal[800]!),
              ),
                onPressed: onTapFavorite != null ? onTapFavorite! : () {}, // Toggle the favorite status
              icon: Icon(
                isFavorite ? Icons.favorite_border : Icons.favorite, // change icon based on favorite status
                color: Colors.white,
              ),
              label: Text(
                  isFavorite ? 'Remove from Favorites'.toUpperCase() : 'Add to Favorites'.toUpperCase(), // change text based on favorite status
                  style: const TextStyle(
                    color: Colors.white,
                )
              )
            )
          ],
        ),
      )
    );
  }
}
  