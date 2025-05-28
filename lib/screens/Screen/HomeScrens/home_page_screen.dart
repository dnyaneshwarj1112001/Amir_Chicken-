import 'dart:convert';
import 'package:amir_chikan/helper/util.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:amir_chikan/core/network/pincodeservice.dart';
import 'package:amir_chikan/presentation/Global_widget/Appcolor.dart';
import 'package:amir_chikan/screens/Screen/HomeScrens/pincodepopup.dart';
import 'package:amir_chikan/screens/shop/allshopsgridpage.dart';
import 'package:amir_chikan/screens/Order/Profile/profileScreen.dart';
import 'package:amir_chikan/screens/Screen/HomeScrens/serchbar.dart';
import 'package:amir_chikan/screens/shop/productdetailstpage.dart';
import 'package:amir_chikan/presentation/Global_widget/CustomiseDrawerandchip.dart';
import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
import 'package:amir_chikan/presentation/Global_widget/dummyimages.dart';
import 'package:amir_chikan/presentation/Global_widget/gap.dart';
import 'package:amir_chikan/presentation/Drawer/drawer.dart';
import 'package:amir_chikan/screens/Screen/HomeScrens/near_shops.dart';
import 'package:amir_chikan/screens/Screen/HomeScrens/shopsListHorizontal.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<dynamic> BannerList = [];
  List<dynamic> categories = [];
  List<dynamic> shoplist = [];

  bool isLoding = true;

  Future<void> gethomepageData() async {
    const baseurl = "https://meatzo.com/api/home";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth_token");

    final response = await http.get(Uri.parse(baseurl), headers: {
      'Authorization': "Bearer $token",
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final banners = data['banners'];
      final Categoriesdata = data["categories"];
      final shoplistdata = data['shops']['data'];
      Util.pretty(shoplistdata);
      setState(() {
        BannerList = banners;
        categories = Categoriesdata;
        shoplist = shoplistdata;

        isLoding = false;
      });
    } else {
      print("Failed to fetch home data. Status code: ${response.statusCode}");
      setState(() {
        isLoding = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPincodeBottomSheet();
      gethomepageData();
    });
  }

  void _showPincodeBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return PincodeBottomSheet(
          context,
          onLocationSelected: (String pincode) {
            print("Pincode selected: $pincode");
            setState(() {
              isLoding = false;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(shoplist);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Appcolor.primaryRed,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Apptext(
              text: "Home",
              color: Colors.white,
              size: 20,
            ),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              elevation: 2,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: _showPincodeBottomSheet,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.red, size: 18),
                      SizedBox(width: 4),
                      Text(
                        'Change Location',
                        style: TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: isLoding
          ? Center(
              child: CircularProgressIndicator(
              color: Appcolor.primaryRed,
            ))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  if (BannerList.isNotEmpty)
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 220.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.9,
                        aspectRatio: 16 / 9,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                      ),
                      items: BannerList.map((banner) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  banner['image'] ?? '',
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                        child: Text("Image not found"));
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 10),
                  SearchBar1(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Apptext(
                          text: "ABHISHEK, WHAT’S ON YOUR MIND?",
                          color: Colors.black,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailList(
                                  text: DummyData.shopNames,
                                  images: DummyData.images,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "See all",
                            style: TextStyle(
                              color: Appcolor.primaryRed,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Categories(categories: categories),
                  const Gaph(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllShopsGridPage(
                            shops: shoplist,
                            pincode: DummyData.pincodes,
                            text: DummyData.shopNames,
                            images: DummyData.images,
                            time: "30-40 Mins ",
                            subtitle: DummyData.shopNames,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 340, bottom: 10),
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Appcolor.primaryRed,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  ShopsNearyou(
                    shops: shoplist,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
