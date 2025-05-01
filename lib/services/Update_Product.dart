import 'package:e_commerce/helper/api.dart';
import 'package:e_commerce/models/product.dart';

class UpdateProductService {
  Future<Product> updateProduct(
      {required String title,
      required String price,
      required String desc,
      required String image,
      required int id,
      required String category}) async {
    print('product id  = $id');
    Map<String, dynamic> data = await Api().put(
        url: 'https://fakestoreapi.com/products/$id',
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
