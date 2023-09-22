import 'package:flutter/material.dart';
import 'package:flutter_app_gallery/network/endpoints.dart';
import 'package:flutter_app_gallery/widgets/imageCard.dart';
import 'package:flutter_app_gallery/models/webimage.dart';
import 'package:flutter_app_gallery/models/webImageList.dart';
import 'package:flutter_app_gallery/network/imageService.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Gallery App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  EndPoints endPoints = EndPoints();
  final ImageWebService imageWebService = ImageWebService(http.Client());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder<WebImageList>(
        future: imageWebService.fetchListOfWebImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<WebImage> images = snapshot.data!.webimages;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
                return SizedBox(
                  width: 400.0,
                  height: 450.0,
                  child: ImageCard(
                    authorName: images[index].author,
                    imageUrl: images[index].download_url,
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
