import 'package:amir_chikan/payment/paymentscreen.dart';
import 'package:flutter/material.dart';
import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
import 'package:amir_chikan/presentation/Global_widget/bottomNavigationbar.dart';
import 'package:amir_chikan/screens/AuthScreen/custome_Next_button.dart';
import 'package:amir_chikan/presentation/Global_widget/customechipbutton.dart';
import 'package:amir_chikan/presentation/Global_widget/gap.dart';
import 'package:amir_chikan/screens/Screen/HomeScrens/home_page_screen.dart';
import 'package:amir_chikan/screens/Order/OrderdetailsScreen.dart';
import 'package:amir_chikan/presentation/Global_widget/app_routes.dart';

class OrderRecipt extends StatefulWidget {
  final double? price;
  final String? productName;
  final double? discount;
  final double? tax;
  final String? address;
  final String? mobile;

  const OrderRecipt({
    super.key,
    this.productName,
    this.price,
    this.discount,
    this.tax,
    this.address,
    this.mobile,
  });

  @override
  State<OrderRecipt> createState() => _OrderReciptState();
}

class _OrderReciptState extends State<OrderRecipt> {
  String _selectedPayment = "COD";

  @override
  Widget build(BuildContext context) {
    final double subtotal = widget.price ?? 0.0;
    final double discount = widget.discount ?? 0.0;
    final double tax = widget.tax ?? 0.0;
    final double total = subtotal - discount + tax;

    return Scaffold(
      appBar: AppBar(
        title: Apptext(
            text: "Order Receipt", size: 20, fontWeight: FontWeight.bold),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Apptext(
                        text: "Product Details", fontWeight: FontWeight.bold),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.shopping_bag, color: Colors.blue),
                      title: Apptext(
                        text: widget.productName ?? "No Product",
                        fontWeight: FontWeight.w600,
                      ),
                      subtitle: Apptext(
                        text: "₹${subtotal.toStringAsFixed(2)}",
                      ),
                    ),
                    Divider(),
                    Apptext(
                        text: "Price Breakdown", fontWeight: FontWeight.bold),
                    SizedBox(height: 8),
                    _buildPriceRow(
                        "Subtotal", "₹${subtotal.toStringAsFixed(2)}"),
                    _buildPriceRow(
                        "Discount", "- ₹${discount.toStringAsFixed(2)}",
                        color: Colors.red),
                    _buildPriceRow("Tax", "+ ₹${tax.toStringAsFixed(2)}",
                        color: Colors.green),
                    Divider(),
                    _buildPriceRow("Total Bill", "₹${total.toStringAsFixed(2)}",
                        isBold: true, fontSize: 18),
                    SizedBox(height: 16),
                    Apptext(
                        text: "Shipping Address", fontWeight: FontWeight.bold),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Apptext(
                        text: widget.address ?? "No address provided",
                      ),
                    ),
                    Apptext(
                      text: "Mobile: ${widget.mobile ?? "N/A"}",
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 16),
                    Apptext(
                        text: "Payment Method", fontWeight: FontWeight.bold),
                    Divider(),
                    _buildRadioButton("COD", "Cash On Delivery"),
                    _buildRadioButton("Online", "Online Payment"),
                    Gaph(height: 10),
                    CustomChipButton(
                      text: "Place Order",
                      onPressed: () {
                        if (_selectedPayment == "Online") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OnlinePaymentScreen(
                                amount: total,
                                // name: "KAHGDGLIUG",
                                // email: "SCASKJVCSDCSD",
                                // mobile: "7028996365",
                              ),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => WillPopScope(
                              onWillPop: () async {
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.nav);
                                return false;
                              },
                              child: AlertDialog(
                                title: Apptext(
                                  text: "Thank You for Your Order!",
                                  fontWeight: FontWeight.bold,
                                ),
                                content: Apptext(
                                  text:
                                      "1. Your order has been successfully placed. Please go to View my order for live tracking.",
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
                                                builder: (_) => NavBar()),
                                          );
                                        },
                                      ),
                                      CustomChipButton(
                                        text: "VIEW MY ORDERS",
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
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
                                        onPressed: () => Navigator.pop(context),
                                        child: Apptext(
                                            text: "OK", color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value,
      {bool isBold = false, double fontSize = 12, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Apptext(
            text: label,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            size: fontSize,
          ),
          Apptext(
            text: value,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: color ?? Colors.black,
            size: fontSize,
          ),
        ],
      ),
    );
  }

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
