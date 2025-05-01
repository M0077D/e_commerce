import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../services/database_helper.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Product> _products = [];
  bool _isLoading = false;
  String _error = '';
  bool _isOffline = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String get error => _error;
  bool get isOffline => _isOffline;

  ProductProvider() {
    fetchProducts();
    _setupConnectivityListener();
  }

  void _setupConnectivityListener() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _isOffline = result == ConnectivityResult.none;
      if (!_isOffline && _products.isEmpty) {
        fetchProducts();
      }
      notifyListeners();
    });
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      // Check connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      _isOffline = connectivityResult == ConnectivityResult.none;

      if (_isOffline) {
        // Load from local database
        _products = await _databaseHelper.getProducts();
        if (_products.isEmpty) {
          _error =
              'No products available offline. Please connect to the internet.';
        }
      } else {
        // Load from API
        _products = await _apiService.getProducts();
        // Save to local database for offline use
        await _databaseHelper.insertProducts(_products);
      }
    } catch (e) {
      _error = e.toString();
      // Try to load from database if API fails
      try {
        _products = await _databaseHelper.getProducts();
        if (_products.isNotEmpty) {
          _isOffline = true;
        }
      } catch (dbError) {
        // Database error
        _error += '\nDatabase error: $dbError';
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Product?> getProductById(int id) async {
    try {
      // Check connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      _isOffline = connectivityResult == ConnectivityResult.none;

      if (_isOffline) {
        // Get from local database
        return await _databaseHelper.getProduct(id);
      } else {
        // Get from API
        return await _apiService.getProduct(id);
      }
    } catch (e) {
      // Try to get from database if API fails
      return await _databaseHelper.getProduct(id);
    }
  }
}
