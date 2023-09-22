import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import '../network/endpoints.dart';
import 'home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    _getDataAndNavigate();
  }

  Future<void> _getDataAndNavigate() async {
    final EndPoints endPoints = EndPoints();

    try {
      // Perform your HTTP request here
      Response response = await http.get(Uri.parse(endPoints.getListOfImages()));
      dynamic data = jsonDecode(response.body);

      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: const Center(
        child: SpinKitRing(
          color: Colors.white,
          size: 70.0,
        ),
      ),
    );
  }
}
