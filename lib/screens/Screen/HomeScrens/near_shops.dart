import 'package:amir_chikan/helper/util.dart';
import 'package:flutter/material.dart';
import 'package:amir_chikan/presentation/Global_widget/Appcolor.dart';
import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
import 'package:amir_chikan/screens/shop/ShopDetailsPage.dart';

class ShopsNearyou extends StatefulWidget {
  final List<dynamic> shops;

  final String time;
  final int pincode;

  const ShopsNearyou({
    super.key,
    required this.shops,
    // required this.text,

    this.time = "30-40 Mins",
    this.pincode = 415524,
  });

  @override
  State<ShopsNearyou> createState() => _ShopsNearyouState();
}

class _ShopsNearyouState extends State<ShopsNearyou> {
  @override
  void initState() {
    super.initState();

    print("Shop List: ${widget.shops}");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 10),
        itemExtent: 160,
        itemCount: widget.shops.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopDetailsPage(
                      text: widget.shops[index]['name'],
                      shopId: widget.shops[index]['id'].toString(),
                      images: widget.shops[index]['image'],
                      deliveryIn: widget.shops[index]['opens_at'],
                      closedAt: widget.shops[index]['closes_at'],
                      openAt: widget.shops[index]['opens_at'],
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: AspectRatio(
                        aspectRatio: 1.5,
                        child: Image.network(
                          widget.shops[index]['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.broken_image,
                                color: Colors.red,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Apptext(
                            text: widget.shops[index]['name'],
                            fontWeight: FontWeight.bold,
                            size: 12,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Apptext(
                                text: "Opens At: ",
                                fontWeight: FontWeight.bold,
                                size: 12,
                              ),
                              Apptext(
                                text: widget.shops[index]['opens_at'],
                                size: 10,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on,
                                  size: 14, color: Colors.red),
                              Text(
                                " ${widget.shops[index]['pincode']}",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 36,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Appcolor.primaryRed,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopDetailsPage(
                                text: widget.shops[index]['name'],
                                shopId: widget.shops[index]['id'].toString(),
                                images: widget.shops[index]['image'],
                                deliveryIn: widget.shops[index]['opens_at'],
                                closedAt: widget.shops[index]['closes_at'],
                                openAt: widget.shops[index]['opens_at'],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Shop Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.shopping_cart, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
