import 'package:the_movie/configuration/configuration.dart';

class ImageDownloader {
  ImageDownloader._();

  static String imageUrl(String path) => Configuration.imageUrl + path;
}
