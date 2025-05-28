import 'dart:convert'; // for jsonEncode, jsonDecode
import 'package:http/http.dart' as http; // for HTTP requests
import 'package:shared_preferences/shared_preferences.dart'; // for accessing token

class CartService {
  static const String _baseUrl = 'https://meatzo.com/api';

  static Future<bool> addToCartHttp({
    required String productId,
    required String priceId,
    int quantity = 1,
  }) async {
    final String url = '$_baseUrl/cart';

    try {
      // Get the token from shared preferences
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'product_id': productId,
          'price_id': priceId,
        }),
      );

      // Check response
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("✅ Add to cart success: $data");
        return true;
      } else {
        print("❌ Failed to add to cart: ${response.body}");
        return false;
      }
    } catch (e) {
      print("❌ Exception: $e");
      return false;
    }
  }
}
