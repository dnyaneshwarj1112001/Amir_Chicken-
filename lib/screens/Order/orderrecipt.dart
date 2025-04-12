import 'package:flutter/material.dart';
import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
import 'package:amir_chikan/presentation/Global_widget/gap.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Receipt"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                 
                  SizedBox(
                      height: 60,
                      width: 200,
                      child: Image.asset(
                          "lib/innitiel_screens/images/scooter.jpg")),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Apptext(
                            text: "Invoice No: MTZ30",
                            size: 14,
                            fontWeight: FontWeight.bold),
                        Apptext(
                            text: "Date: 19-03-2025",
                            size: 14,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 140,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Apptext(
                                text: "Invoice To:",
                                fontWeight: FontWeight.bold),
                            Apptext(
                              text: "Kolhapur, Maharashtra, 411032, India",
                            ),
                            Apptext(
                              text: "Mobile: +07028996365",
                            ),
                          ],
                        ),
                      ),

                      // Vertical Divider
                      SizedBox(width: 10), // Space before divider
                      Container(
                        height: 50, // Adjust height as needed
                        width: 1.5, // Divider thickness
                        color: Colors.grey, // Divider color
                      ),
                      SizedBox(width: 10), // Space after divider

                      SizedBox(
                        width: 165,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Apptext(
                                text: "Pay To:", fontWeight: FontWeight.bold),
                            Apptext(
                              text: "Meatzo",
                            ),
                            Apptext(
                              text: "Email: meatzo123@gmail.comsdsfsdafsdfdsf",
                              maxline: 1,
                            ),
                            Apptext(
                              text: "Mobile: +919325279918",
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Product Table
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      // Table Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Apptext(text: "Product", fontWeight: FontWeight.bold),
                          Apptext(text: "Size", fontWeight: FontWeight.bold),
                          Apptext(
                              text: "Sale Price", fontWeight: FontWeight.bold),
                          Apptext(text: "Qty", fontWeight: FontWeight.bold),
                          Apptext(text: "Amount", fontWeight: FontWeight.bold),
                        ],
                      ),
                      Divider(),

                      // Product 1
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Apptext(text: "Eggs"),
                          Apptext(text: "30Nos"),
                          Apptext(text: "₹160.00"),
                          Apptext(text: "1"),
                          Apptext(text: "₹160"),
                        ],
                      ),
                      SizedBox(height: 5),

                      // Product 2
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Apptext(text: "Chicken"),
                          Apptext(text: "500GM"),
                          Apptext(text: "₹200.00"),
                          Apptext(text: "1"),
                          Apptext(text: "₹200"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Payment Info
              Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Apptext(
                              text: "Payment Info:",
                              size: 14,
                              fontWeight: FontWeight.bold),
                          Apptext(text: "Customer: ", size: 12),
                          Apptext(text: "Payment: Cash On Delivery", size: 12),
                          Apptext(text: "Amount: ₹360", size: 12),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildAmountRow(
                            "Subtotal", textColor: Colors.green, "₹360"),
                        _buildAmountRow("Discount", "- ₹0.00",
                            textColor: Colors.green),
                        _buildAmountRow("Tax Amount", "+ ₹0.00",
                            textColor: Colors.red),
                        const Divider(),
                        Container(
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _buildAmountRow("Grand Total", "₹360.00",
                                  isBold: true),
                            )),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Apptext(
                          text: "Terms & Conditions:",
                          fontWeight: FontWeight.bold),
                      Apptext(
                        text:
                            "The Company reserves the right, at its discretion, to change, modify, "
                            "add, or remove portions of these Terms at any time by posting the amended Terms.",
                        size: 12,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Divider(),
              // Powered By
              const Center(
                child: Apptext(
                  text: "Powered by Cloud Regex Pvt Ltd, Mob: 8999951727",
                  size: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountRow(String title, String value,
      {bool isBold = false, Color? textColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Apptext(
            text: title,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: textColor ?? Colors.black),
        const Gapw(width: 10),
        Apptext(
          text: value,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ],
    );
  }
}
