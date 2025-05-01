import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/helper/api.dart';

class CategoriesServices {
  Future<List<Product>> getAllProducts(categoryName) async {
    List<dynamic> data = await Api().get(
        url: 'https://fakestoreapi.com/products/category/$categoryName',
        token: '');

    List<Product> ProductList = [];
    for (int i = 0; i < data.length; i++) {
      ProductList.add(Product.fromJson(data[i]));
    }
    return ProductList;
  }
}
