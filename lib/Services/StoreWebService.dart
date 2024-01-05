import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductService {
  static const String baseUrl = 'http://localhost:9090/produit'; 

static Future<List<dynamic>> fetchProducts() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to load products - Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load products - Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching products: $e');
    throw Exception('Failed to load products: $e');
  }
}


  static Future<void> addProduct(Map<String, dynamic> productData) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(productData),
    );

    if (response.statusCode == 201) {
      print('Product added successfully');
    } else {
      print('Failed to add product - Status code: ${response.statusCode}');
      throw Exception('Failed to add product');
    }
  } catch (e) {
    print('Error adding product: $e');
    throw Exception('Failed to add product');
  }
}


 static Future<void> deleteProduct(String productId) async {
  try {
    final Map<String, dynamic> requestData = {'id': productId};
    final response = await http.delete(
      Uri.parse('$baseUrl/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to delete product');
  }
}

static Future<void> updateProduct(String productId, Map<String, dynamic> productData) async {
  try {
    final Map<String, dynamic> requestData = {
      'id': productId, // Product ID received as a parameter
      ...productData, // Other product details
    };

    final response = await http.put(
      Uri.parse('$baseUrl/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to update product');
  }
}

}


