import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app_gallery/models/webimage.dart';


void main() {
  test('WebImage Test', () {
    // Create a sample WebImage instance
    final webImage = WebImage(
      id: 'sample_id',
      author: 'John',
      width: 800,
      height: 600,
      url: 'https://example.com/image.jpg',
      download_url: 'https://example.com/download.jpg',
    );

    // Test the toJson() method
    final Map<String, dynamic> json = webImage.toJson();
    expect(json['id'], 'sample_id');
    expect(json['author'], 'John');
    expect(json['width'], 800);
    expect(json['height'], 600);
    expect(json['url'], 'https://example.com/image.jpg');
    expect(json['download_url'], 'https://example.com/download.jpg');

    // Test the fromJson() factory method
    final Map<String, dynamic> jsonInput = {
      'id': 'sample_id',
      'author': 'Jane',
      'width': 400,
      'height': 400,
      'url': 'https://example.com/other_image.jpg',
      'download_url': 'https://example.com/other_download.jpg',
    };

    final WebImage fromJsonWebImage = WebImage.fromJson(jsonInput);
    expect(fromJsonWebImage.id, 'sample_id');
    expect(fromJsonWebImage.author, 'Jane');
    expect(fromJsonWebImage.width, 400);
    expect(fromJsonWebImage.height, 400);
    expect(fromJsonWebImage.url, 'https://example.com/other_image.jpg');
    expect(fromJsonWebImage.download_url, 'https://example.com/other_download.jpg');
  });
}
