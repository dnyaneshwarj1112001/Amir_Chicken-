import 'package:amir_chikan/helper/util.dart';
import 'package:amir_chikan/screens/Mycart/Screens/Addtocartservice.dart';
import 'package:flutter/material.dart';
import 'package:amir_chikan/screens/Mycart/Screens/mycardhelper.dart';
import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
import 'package:amir_chikan/screens/AuthScreen/custome_Next_button.dart';
import 'package:amir_chikan/presentation/Global_widget/gap.dart';
import 'package:amir_chikan/screens/Mycart/cubit/ChangeAddressAlertbox.dart';
import 'package:amir_chikan/screens/Mycart/Screens/mycartapiservice.dart';
import 'package:amir_chikan/screens/Order/OrderRecipt1.dart';
import 'package:amir_chikan/presentation/Global_widget/Appcolor.dart';
import 'package:amir_chikan/presentation/Global_widget/app_routes.dart';
import 'package:amir_chikan/presentation/Global_widget/mycardtext.dart';

class MyCardScreen extends StatefulWidget {
  const MyCardScreen({super.key});

  @override
  State<MyCardScreen> createState() => _MyCardScreenState();
}

class _MyCardScreenState extends State<MyCardScreen>
    with TickerProviderStateMixin {
  List<dynamic> cartList = [];
  List<int> quantities = [];
  double subtotal = 0.0;

  @override
  void initState() {
    super.initState();
    loadCartData();
  }

  Future<void> loadCartData() async {
    final items = await CartApi.fetchCartData();
    print(items);
    if (items != null) {
      setState(() {
        cartList = items;
        quantities = List.generate(items.length, (index) => 1);
        calculateSubtotal();
      });
    }
  }

  void calculateSubtotal() {
    subtotal = 0.0;
    for (int i = 0; i < cartList.length; i++) {
      final priceStr = cartList[i]['price']?['sale_price']?.toString() ?? '0';
      final price = double.tryParse(priceStr) ?? 0.0;
      subtotal += price * quantities[i];
    }
    setState(() {});
  }

  void increaseQuantity(int index, String cartId) {
    setState(() {
      int currentQty = quantities[index]++;
      CartService.updateQty(cartId: cartId.toString(), qty: currentQty);
      calculateSubtotal();
    });
  }

  void decreaseQuantity(int index, String cartId) {
    if (quantities[index] > 1) {
      setState(() {
        int currentQty = quantities[index]--;
        CartService.updateQty(cartId: cartId.toString(), qty: currentQty);
        calculateSubtotal();
      });
    }
  }

  void deleteItem(String id) async {
    print("===========================");
    print("this called");
    print(id);
    print("===========================");
    final result =
        await CartService.deleteCartItemHttp(productId: id.toString());

    if (result['success']) {
      print("🟢 Deleted successfully");
      loadCartData();
    } else {
      print("🔴 Error deleting: ${result['message']}");
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
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Apptext(
            text: 'My Cart',
            color: Colors.white,
            size: 22,
          ),
          backgroundColor: Appcolor.primaryRed,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: cartList.isEmpty
                  ? const Center(child: Text("Your cart is empty"))
                  : ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        final item = cartList[index];
                        print(item);
                        final cartId = item['cart_id'];
                        final name =
                            item['product']?['product_name'] ?? 'Product';
                        final priceStr =
                            item['price']?['sale_price']?.toString() ?? '0.00';
                        final price = double.tryParse(priceStr) ?? 0.0;
                        final image =
                            "https://meatzo.com/" + item['product']['main_img'];

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    image,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    cardtext(
                                      leadingtext: "Price:",
                                      trailingtext: "Rs. $priceStr",
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () =>
                                              decreaseQuantity(index, cartId),
                                          icon: const Icon(Icons.remove_circle,
                                              color: Colors.red),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade400),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                              "${quantities[index]} x ${price.toInt()}"),
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              increaseQuantity(index, cartId),
                                          icon: const Icon(Icons.add_circle,
                                              color: Colors.green),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () => deleteItem(cartId),
                                          icon: const Icon(Icons.delete,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const Gaph(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Mycardhelper(
                    lable: "Sub Total",
                    amount: subtotal.toStringAsFixed(2),
                    amountColor: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                  const Divider(),
                  Mycardhelper(
                    lable: "Discount",
                    amount: "120",
                    amountColor: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                  const Divider(),
                  Mycardhelper(
                    lable: "Delivery Charge",
                    amount: "40",
                    amountColor: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  const Divider(),
                  Mycardhelper(
                    lable: "GST",
                    amount: "10",
                    amountColor: Appcolor.primaryRed,
                    fontWeight: FontWeight.bold,
                  ),
                  const Divider(),
                  Mycardhelper(
                    lable: "Total",
                    amount: (subtotal - 120 + 40 + 10).toStringAsFixed(2),
                    amountColor: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Apptext(
                            text: "Shipping Address",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 4),
                          Apptext(
                            text:
                                "Pune, Maharashtra, 411032\nPhone: +91 7028996365",
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => ChangeAddressAlertbox(),
                          );
                        },
                        child: Text(
                          "Change",
                          style: TextStyle(color: Appcolor.primaryRed),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // CustomButton(
                  //   text: "Continue to Payment",
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (_) => Ordersscreen()

                  //       ),
                  //     );
                  //   },
                  // ),
                  CustomButton(
                    text: "Continue to Payment",
                    onPressed: () {
                      double discount = 120;
                      double deliveryCharge = 40;
                      double gst = 10;
                      double total = subtotal - discount + deliveryCharge + gst;

                      // Combine product names into a single string
                      String combinedProductNames = cartList.map((item) {
                        return item['product']?['product_name'] ?? 'Product';
                      }).join(', ');

                      // Static shipping info (you can make this dynamic later)
                      String address = "Pune, Maharashtra, 411032";
                      String mobile = "+91 7028996365";

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OrderRecipt(
                            productName: combinedProductNames,
                            price: subtotal,
                            discount: discount,
                            tax: gst,
                            address: address,
                            mobile: mobile,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
