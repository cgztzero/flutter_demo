import 'dart:ui';

class ImageGlobalConfig {
  static Map<String, String>? defaultHeaders;
  static String? errorImageUrl;
  static Color? errorColor;
  static String? placeImageUrl;
  static Color? placeImageColor;
  static Color? pressColor;

  static void addHeader(String key, String value) {
    defaultHeaders ??= {};
    defaultHeaders?[key] = value;
  }

  static void addHeaders(Map<String, String> map) {
    defaultHeaders ??= {};
    defaultHeaders?.addAll(map);
  }

  static void setErrorImageUrl(String url){
     errorImageUrl = url;
  }

  static void setErrorImageColor(Color color){
    errorColor = color;
  }

  static void setPlaceImageUrl(String url){
    placeImageUrl = url;
  }

  static void setPlaceImageColor(Color color){
    placeImageColor = color;
  }

  static void setPressColor(Color color){
    pressColor = color;
  }

}