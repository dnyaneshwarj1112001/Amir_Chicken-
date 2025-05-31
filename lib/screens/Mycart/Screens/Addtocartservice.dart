import 'dart:convert'; // for jsonEncode, jsonDecode
import 'package:http/http.dart' as http; // for HTTP requests
import 'package:shared_preferences/shared_preferences.dart'; // for accessing token

class CartService {
  static const String _baseUrl = 'https://meatzo.com/api';

  /// Add to Cart
  static Future<Map<String, dynamic>> addToCartHttp({
    required String productId,
    required String priceId,
    required String shopId,
    int quantity = 1,
  }) async {
    final String url = '$_baseUrl/cart';
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');
    print(token);
    try {
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
          "cart_shop_id": shopId,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("✅ Add to cart success: $data");
        return {
          'success': true,
          'message': data['message'] ?? 'Added to cart successfully'
        };
      } else {
        print("❌ Failed to add to cart: $data");
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to add to cart'
        };
      }
    } catch (e) {
      print("❌ Exception: $e");
      return {
        'success': false,
        'message': 'Something went wrong. Please try again later.'
      };
    }
  }

  /// Delete from Cart
  static Future<Map<String, dynamic>> deleteCartItemHttp({
    required String productId,
  }) async {
    final String url = '$_baseUrl/cart/$productId';
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');
    print(token);
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        print(response);
        print("✅ Deleted cart item successfully: $data");
        return {
          'success': true,
          'message': data['message'] ?? 'Cart item deleted successfully'
        };
      } else {
        print("❌ Failed to delete cart item: $data");
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to delete cart item'
        };
      }
    } catch (e) {
      print("❌ Exception: $e");
      return {
        'success': false,
        'message': 'Something went wrong. Please try again later.'
      };
    }
  }

  static Future<Map<String, dynamic>> updateQty(
      {required String cartId, required int qty}) async {
    final String url = '$_baseUrl/cart/$cartId';
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');
    print(token);
    try {
      final response = await http.put(Uri.parse(url), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }, body: {
        "productQty": qty.toString(),
      });

      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        print("✅ Deleted cart item successfully: $data");
        return {
          'success': true,
          'message': data['message'] ?? 'Cart item deleted successfully'
        };
      } else {
        print("❌ Failed to delete cart item: $data");
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to delete cart item'
        };
      }
    } catch (e) {
      print("❌ Exception: $e");
      return {
        'success': false,
        'message': 'Something went wrong. Please try again later.'
      };
    }
  }
}
