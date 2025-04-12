import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
import 'package:amir_chikan/presentation/Global_widget/dummyimages.dart';
import 'package:amir_chikan/presentation/Global_widget/serchbar.dart';
import 'package:amir_chikan/screens/shop/shopwiseprodectlineerlistpage.dart';
import 'package:flutter/material.dart';
import 'package:amir_chikan/presentation/Global_widget/Appcolor.dart';
import 'package:amir_chikan/presentation/Global_widget/gap.dart';

class ShopDetailsPage extends StatefulWidget {
  final String text;
  final String images;
  final VoidCallback? onPressed;

  const ShopDetailsPage({
    super.key,
    required this.text,
    required this.images,
    this.onPressed,
  });

  @override
  State<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  @override
  void initState() {
    super.initState();
    print(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop Details"),
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
                          child: Image.asset(
                            widget.images,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Gaph(height: 10),
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
                        detailRow(Icons.access_time, "Opens At: ", "8:00 AM"),
                        detailRow(Icons.store, "Closes At: ", "11:00 PM"),
                        detailRow(Icons.delivery_dining, "Delivery In: ",
                            "30-40 Mins"),
                        ratingRow(4.5), // Example rating

                        Chip(
                          label: Row(
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
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: CustomSearchBar(
                hintText: "Search for products",
                onChanged: (value) {
                  print(value);
                },
              ),
            ),
            Gaph(height: 10),
            shopwiseproductlineerlist(
                text: DummyData.shopNames, images: DummyData.images),
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
