import 'package:e_commerce/helper/api.dart';
import 'package:e_commerce/models/product.dart';

class AllProductServices {
  static const String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> getAllProducts() async {
    List<dynamic> data = await Api().get(url: baseUrl, token: '');

    List<Product> ProductList = [];
    for (int i = 0; i < data.length; i++) {
      ProductList.add(Product.fromJson(data[i]));
    }
    return ProductList;
  }
}
