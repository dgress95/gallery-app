import 'dart:io';

import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget{
  final String authorName;
  final String imageUrl;
  final bool isFavorite;

  const ImageCard({super.key, required this.authorName,required this.imageUrl, required this.isFavorite});

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
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.redAccent,
              ),
              label: const Text(
                'Add to Favorites',
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
  