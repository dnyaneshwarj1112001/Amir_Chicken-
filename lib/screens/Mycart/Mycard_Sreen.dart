import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
import 'package:amir_chikan/screens/AuthScreen/custome_Next_button.dart';
import 'package:amir_chikan/presentation/Global_widget/gap.dart';
import 'package:amir_chikan/screens/Mycart/cubit/ChangeAddressAlertbox.dart';
import 'package:amir_chikan/screens/Mycart/mycardhelper.dart';
import 'package:amir_chikan/screens/Order/orders.dart';
import 'package:flutter/material.dart';
import 'package:amir_chikan/presentation/Global_widget/Appcolor.dart';
import 'package:amir_chikan/presentation/Global_widget/app_routes.dart';
import 'package:amir_chikan/presentation/Global_widget/mycardtext.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MyCardScreen extends StatefulWidget {
  const MyCardScreen({super.key});

  @override
  State<MyCardScreen> createState() => _MyCardScreenState();
}

class _MyCardScreenState extends State<MyCardScreen> {
  List<int> quantities =
      List.generate(5, (index) => 1); // Initialize quantity list

  void increaseQuantity(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  void decreaseQuantity(int index) {
    if (quantities[index] > 1) {
      setState(() {
        quantities[index]--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, AppRoutes.nav);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: const Apptext(
            text: 'Add To Card',
            color: Colors.white,
            size: 22,
          ),
          backgroundColor: Appcolor.primaryRed,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 233, 217, 217),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 3,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                        border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 1),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "lib/innitiel_screens/images/shop4.png",
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Egg",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    const cardtext(
                                        leadingtext: "Price:",
                                        trailingtext: " 100.00"),
                                    const SizedBox(height: 10),
                                    const cardtext(
                                        leadingtext: "GST:",
                                        trailingtext: " Rs 1.40 (1.00%)"),
                                    const SizedBox(height: 10),
                                    cardtext(
                                        leadingtext: "Qty:",
                                        trailingtext: "${quantities[index]}"),
                                    const SizedBox(height: 10),
                                    const cardtext(
                                        leadingtext: "Discount:",
                                        trailingtext: "Rs 0.00 (0.00%)"),
                                    const SizedBox(height: 10),
                                    const cardtext(
                                        leadingtext: "Total:",
                                        trailingtext: " Rs.161.60"),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () => decreaseQuantity(index),
                                          child: Chip(
                                            backgroundColor:
                                                Appcolor.primaryRed,
                                            labelPadding: EdgeInsets.zero,
                                            label: const Icon(Icons.remove,
                                                color: Colors.white, size: 18),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            visualDensity:
                                                VisualDensity.compact,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 15),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            "${quantities[index]}",
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        InkWell(
                                          onTap: () => increaseQuantity(index),
                                          child: const Chip(
                                            backgroundColor: Colors.green,
                                            labelPadding: EdgeInsets.zero,
                                            label: Icon(Icons.add,
                                                color: Colors.white, size: 18),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            visualDensity:
                                                VisualDensity.compact,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Gaph(height: 20),
                Container(
                  height: 290,
                  width: 380,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Mycardhelper(
                          lable: "Sub Total        ",
                          amount: "1220",
                          amountColor: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        Divider(),
                        Mycardhelper(
                          lable: "Discount Total    ",
                          amount: "1220",
                          amountColor: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        Divider(),
                        Mycardhelper(
                          lable: "Delivery Charge",
                          fontWeight: FontWeight.bold,
                          amount: "-40",
                        ),
                        Divider(),
                        Mycardhelper(
                          lable: "GST Total",
                          fontWeight: FontWeight.bold,
                          amount: "1.90",
                          amountColor: Color.fromARGB(255, 241, 90, 90),
                        ),
                        Divider(),
                        Mycardhelper(
                            lable: "Total      ",
                            fontWeight: FontWeight.bold,
                            amount: "1.90",
                            amountColor: Appcolor.primaryRed),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Apptext(
                                  text: "Shipping Address",
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Apptext(
                                      text:
                                          "Pune Division, Maharashtra, 411032, India - Mobile: + 7028996365"),
                                )
                              ],
                            ),
                            Chip(
                              label: Text(
                                "Change Address",
                                style: TextStyle(
                                  color: Appcolor.primaryRed, // Text color
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: Colors.white, // Background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Rounded corners
                                side: BorderSide(
                                  color: Appcolor.primaryRed, // Border color
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8), // Padding
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Ordersscreen()));
                            },
                            child: Chip(
                              label: Text(
                                "Place Order",
                                style: TextStyle(
                                  color: Colors.white, // Text color
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor:
                                  Appcolor.primaryRed, // Background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Rounded corners
                                side: BorderSide(
                                  color: Colors.white, // Border color
                                  width: 1,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8), // Padding
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Gaph(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
