import '../constants/api_constants.dart';

class ImageHelper {
  static String getImageUrl(String image) {
    if (image.isEmpty) return '';

    if (image.startsWith('http')) {
      return image;
    }

    return "${ApiConstant.baseUrl}$image";
  }
}