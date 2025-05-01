import 'package:e_commerce/helper/api.dart';

class AllCategoriesService {
  static const String url = 'https://api.example.com/categories';

  Future<List<dynamic>> GatAllCategories() async {
    List<dynamic> data = await Api().get(url: url, token: '');

    return data;
  }
}
