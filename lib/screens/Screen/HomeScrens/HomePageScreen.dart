import 'package:flutter/material.dart';
import 'package:amir_chikan/presentation/Global_widget/Appcolor.dart';
import 'package:amir_chikan/presentation/Global_widget/CustomiseDrawerandchip.dart';
import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
import 'package:amir_chikan/presentation/Global_widget/dummyimages.dart';
import 'package:amir_chikan/presentation/Global_widget/gap.dart';
import 'package:amir_chikan/screens/Screen/HomeScrens/nearshops.dart';
import 'package:amir_chikan/screens/Screen/HomeScrens/shopsListHorizontal.dart';
import 'package:amir_chikan/screens/shop/productdetailstpage.dart';
import 'package:amir_chikan/presentation/Drawer/drawer.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final double headerHeight = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const DrawerExample(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background Image + Header Widgets
            Column(
              children: [
                Container(
                  height: headerHeight,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("lib/innitiel_screens/images/homebg.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomiseDrawerandchip(text: "Change location"),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: "Search for your favourite meat",
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Scrollable Content below header
            Padding(
              padding: EdgeInsets.only(top: headerHeight - 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShopListGrid(
                    text: "Balaji Chicken",
                    images: DummyData.images,
                  ),

                  const Gaph(height: 10),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Image(
                            image: AssetImage(
                                "lib/innitiel_screens/images/Murga.png"),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "WE DELIVER FRESH AND HYGENIC MEAT FROM YOUR FAVOURITE SHOPS",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Nearby Shops
                  ShopsNearyou(
                    text: DummyData.shopNames,
                    Subtitle: DummyData.shopNames,
                    images: DummyData.images,
                    time: "30-40 Mins ",
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
