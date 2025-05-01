import 'package:e_commerce/helper/api.dart';
import 'package:e_commerce/models/product.dart';

class AddProduct {
  Future<Product> addProduct(
      {required String title,
      required String price,
      required String desc,
      required String image,
      required String category}) async {
    Map<String, dynamic> data = await Api().post(
        url: 'https://fakestoreapi.com/products',
        body: {
          'title': title,
          'price': price,
          'description': desc,
          'image': image,
          'category': category,
        },
        token: '');

    return Product.fromJson(data);
  }
}
