import 'dart:convert';

import 'package:amir_chikan/helper/util.dart';
import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
import 'package:amir_chikan/presentation/Global_widget/dummyimages.dart';
import 'package:amir_chikan/screens/Screen/HomeScrens/serchbar.dart';
import 'package:amir_chikan/screens/shop/shopwiseprodectlineerlistpage.dart';
import 'package:flutter/material.dart';
import 'package:amir_chikan/presentation/Global_widget/Appcolor.dart';
import 'package:amir_chikan/presentation/Global_widget/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ShopDetailsPage extends StatefulWidget {
  final String shopId;
  final String text;
  final String images;
  final VoidCallback? onPressed;
  final String openAt;
  final String closedAt;
  final String deliveryIn;

  const ShopDetailsPage({
    super.key,
    required this.shopId,
    required this.text,
    required this.images,
    this.onPressed,
    this.openAt = "09:00 AM",
    this.closedAt = "09:00 PM",
    this.deliveryIn = "30-40 Mins",
  });
  @override
  State<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  List<dynamic> productList = [];
  @override
  void initState() {
    super.initState();
    getproductdata();
  }

  Future<void> getproductdata() async {
    final baseurl = "https://meatzo.com/api/shop/details/${widget.shopId}";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth_token");

    final response = await http.get(Uri.parse(baseurl), headers: {
      'Authorization': "Bearer $token",
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final productdata = data['products'];
      // Util.pretty(productdata);

      print(productdata);

      setState(() {
        productList = productdata;
      });
    } else {
      print(
          "Failed to fetch shop details. Status code: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Apptext(
          text: "Shop Details",
          color: Colors.white,
          size: 20,
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gaph(height: 20),

            // Shop Image
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.white,
                              blurRadius: 2,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                           widget.images,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Gaph(height: 10),
                      Apptext(
                        text: widget.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        detailRow(
                            Icons.access_time, "Opens At: ", widget.openAt),
                        detailRow(Icons.store, "Closes At: ", widget.closedAt),
                        detailRow(Icons.delivery_dining, "Delivery In: ",
                            "30-40 Mins"),
                        ratingRow(4.5), // Example rating

                        Chip(
                          label: const Row(
                            children: [
                              Icon(Icons.directions, color: Colors.white),
                              Apptext(
                                text: "Directions",
                                color: Colors.white,
                              ),
                            ],
                          ),
                          backgroundColor: Appcolor
                              .primaryRed, // Use backgroundColor instead of color
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Gaph(height: 10),
            const Apptext(
              text: "Our Products",
              size: 15,
              fontWeight: FontWeight.bold,
            ),
            const Gaph(height: 20),
            SearchBar1(),

            const Gaph(height: 10),
            ShopwiseProductLinearList(
              productList: productList,
            ),
          ],
        ),
      ),
    );
  }

  Widget detailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Appcolor.primaryRed, size: 20),
          const SizedBox(width: 10),
          Apptext(
            text: title,
            fontWeight: FontWeight.bold,
          ),
          Apptext(text: value),
        ],
      ),
    );
  }

  Widget ratingRow(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.star, color: Appcolor.primaryRed, size: 20),
          const SizedBox(width: 10),
          const Apptext(
            text: "Ratings:",
            fontWeight: FontWeight.bold,
          ),
          Row(
            children: List.generate(
              fullStars,
              (index) => const Icon(Icons.star, color: Colors.amber, size: 20),
            )..addAll(
                hasHalfStar
                    ? [
                        const Icon(Icons.star_half,
                            color: Colors.amber, size: 20)
                      ]
                    : [],
              ),
          ),
        ],
      ),
    );
  }
}
