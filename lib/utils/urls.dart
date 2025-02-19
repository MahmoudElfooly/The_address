import '../core/environment/environment.dart';

class Urls {
  static final String baseUrl = Environment.apiUrl;
  static final String getProducts = "${Environment.apiUrl}v1/products/";
  static final String getCategories = "${Environment.apiUrl}v1/categories/";
  static final String updateProduct = "${Environment.apiUrl}v1/products/";
}
