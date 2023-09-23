import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_gallery/models/webImageList.dart';
import 'package:flutter_app_gallery/models/webimage.dart';
import 'package:flutter_app_gallery/network/endpoints.dart';
import 'package:flutter_app_gallery/network/imageService.dart';

import 'api_test.mocks.dart';


/**
 * Here we test our api calls!
 * For full coverage remember to create tests for all your calls
 * You want to cover a succesful call and a possible failure 
 */

@GenerateMocks([http.Client])
void main(){
  ImageWebService imageWebService;

  group('Call image api',(){
    EndPoints endPoints = EndPoints();
    final url  = endPoints.getImageInfoFromId(1);
    WebImage mockWebImage = WebImage(id: "1", author: "John Doe", width: 300, height: 300, url: 'https://example.com/data', download_url:'https://example.com/data');
    WebImageList mockWebImageList = WebImageList(webimages: [mockWebImage]);

    //Here is an example of a successful networking call
    test("Return webImageList if http completes", () async{
      final httpClient = MockClient();
      imageWebService = ImageWebService(httpClient);
      when(httpClient.get(any)).thenAnswer((_) async => http.Response(jsonEncode(mockWebImage),200));
      expect(imageWebService.fetchWebImageInfo(1),isA<Future<WebImage>>());
    });

    test('getImageSize Test', () {
      // Define sample width and height
      final int width = 800;
      final int height = 600;

      // Call the getImageSize function
      final String imageUrl = endPoints.getImageSize(width, height);

      // Define the expected result based on baseUrl, width, and height
      final String expectedUrl = 'https://picsum.photos/$width/$height';

      // Verify that the returned URL matches the expected result
      expect(imageUrl, expectedUrl);
    });


    test("Return list of web images if http completes successfully", () async {
      final httpClient = MockClient();
      imageWebService = ImageWebService(httpClient);

      // Mocking a successful HTTP response
      when(httpClient.get(Uri.parse(endPoints.getListOfImages())))
          .thenAnswer((_) async => http.Response(jsonEncode([mockWebImage]), 200));

      final result = await imageWebService.fetchListOfWebImages();

      expect(result, isA<WebImageList>());
      expect(result.webimages.length, 1);
      expect(result.webimages[0], isA<WebImage>());
    });

    test("Throw an exception if http call for list of web images completes with an error", () async {
      final httpClient = MockClient();
      imageWebService = ImageWebService(httpClient);

      // Mocking an error HTTP response
      when(httpClient.get(Uri.parse(endPoints.getListOfImages())))
          .thenAnswer((_) async => http.Response('Server Error', 500));

      try {
        await imageWebService.fetchListOfWebImages();
        fail("Expected an exception to be thrown");
      } catch (e) {
        expect(e, isA<Exception>());
        expect(e.toString(), contains('500'));
        expect(e.toString(), contains('Exception: 500'));
      }
    });

  });
}



