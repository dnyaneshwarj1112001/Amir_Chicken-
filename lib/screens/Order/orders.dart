import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
import 'package:amir_chikan/presentation/Global_widget/bottomNavigationbar.dart';
import 'package:amir_chikan/screens/AuthScreen/custome_Next_button.dart';
import 'package:amir_chikan/presentation/Global_widget/customechipbutton.dart';
import 'package:amir_chikan/presentation/Global_widget/gap.dart';
import 'package:amir_chikan/screens/Screen/HomeScrens/HomePageScreen.dart';
import 'package:amir_chikan/screens/Order/OrderdetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:amir_chikan/presentation/Global_widget/app_routes.dart';

class Ordersscreen extends StatefulWidget {
  const Ordersscreen({super.key});

  @override
  State<Ordersscreen> createState() => _OrdersscreenState();
}

class _OrdersscreenState extends State<Ordersscreen> {
  String _selectedPayment = "COD"; // Default payment method

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              Apptext(text: "My Orders", size: 20, fontWeight: FontWeight.bold),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Details Card
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Details
                      Apptext(
                        text: "Product Details",
                        fontWeight: FontWeight.bold,
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.shopping_bag, color: Colors.blue),
                        title: Apptext(
                          text: "Chicken (500GM)",
                          fontWeight: FontWeight.w600,
                        ),
                        subtitle: Apptext(text: "₹200.00"),
                      ),
                      Divider(),

                      // Price Breakdown
                      Apptext(
                        text: "Price Breakdown",
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 8),
                      _buildPriceRow("Subtotal", "₹200.00"),
                      _buildPriceRow("Discount", "- ₹10.00", color: Colors.red),
                      _buildPriceRow("Tax", "+ ₹1.90", color: Colors.green),
                      Divider(),
                      _buildPriceRow("Total Bill", "₹192",
                          isBold: true, fontSize: 18),

                      SizedBox(height: 16),

                      // Shipping Address
                      Apptext(
                        text: "Shipping Address",
                        fontWeight: FontWeight.bold,
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Apptext(
                          text:
                              "kjgyfjytfliyg, Pune Division, Maharashtra, 411032, India",
                        ),
                      ),
                      Apptext(
                        text: "Mobile: +7028996365",
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 16),

                      // Payment Method
                      Apptext(
                        text: "Payment Method",
                        fontWeight: FontWeight.bold,
                      ),
                      Divider(),
                      _buildRadioButton("COD", "Cash On Delivery"),
                      _buildRadioButton("Online", "Online Payment"),
                      Gaph(height: 10),
                      CustomChipButton(
                        text: "Place Order",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => WillPopScope(
                              onWillPop: () async {
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.nav);
                                return false; // Prevents dialog from closing on back press
                              },
                              child: AlertDialog(
                                title: Apptext(
                                  text: "Thank You for Your Order!",
                                  fontWeight: FontWeight.bold,
                                ),
                                content: Apptext(
                                  text:
                                      "1. Your order has been successfully placed. "
                                      "Please go to View my order for live tracking.",
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomChipButton(
                                        text: "BACK TO HOME",
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => NavBar()),
                                          );
                                        },
                                      ),
                                      CustomChipButton(
                                        text: "VIEW MY ORDERS",
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderDetailsScreen()),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Apptext(
                                            text: "Cancel", color: Colors.red),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Apptext(
                                            text: "OK", color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget to Display Price Rows
  Widget _buildPriceRow(String label, String value,
      {bool isBold = false, double fontSize = 16, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Apptext(
            text: label,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
          Apptext(
            text: value,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: color ?? Colors.black,
          ),
        ],
      ),
    );
  }

  // Radio Button UI
  Widget _buildRadioButton(String value, String text) {
    bool isSelected = _selectedPayment == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPayment = value;
        });
      },
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: _selectedPayment,
            onChanged: (newValue) {
              setState(() {
                _selectedPayment = newValue!;
              });
            },
            activeColor: Colors.red,
          ),
          Apptext(
            text: text,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.red : Colors.black,
          ),
        ],
      ),
    );
  }
}
