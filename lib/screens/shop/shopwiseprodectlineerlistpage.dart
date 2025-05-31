import 'package:amir_chikan/screens/Mycart/Screens/Addtocartservice.dart';
import 'package:flutter/material.dart';
import 'package:amir_chikan/helper/util.dart';
import 'package:amir_chikan/presentation/Global_widget/gap.dart';
import 'package:amir_chikan/presentation/Global_widget/Appcolor.dart';
import 'package:amir_chikan/screens/Mycart/Screens/Mycard_Sreen.dart';

class ShopwiseProductLinearList extends StatefulWidget {
  final List<dynamic> productList;

  const ShopwiseProductLinearList({
    super.key,
    required this.productList,
  });

  @override
  State<ShopwiseProductLinearList> createState() =>
      _ShopwiseProductLinearListState();
}

class _ShopwiseProductLinearListState extends State<ShopwiseProductLinearList> {
  final Map<int, int> selectedSizeIndex = {};
  final String baseImageUrl = "https://meatzo.com/uploads/main_img/";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: widget.productList.length,
        itemBuilder: (context, index) {
          final product = widget.productList[index];
          // Util.pretty(product);
          final List prices = product['prices'] ?? [];
          final productId = product['tbl_product_id'] ?? product['product_id'];
          final shopId = product['shop'];

          // Util.pretty(prices);

          if (prices.isEmpty) return const SizedBox();

          selectedSizeIndex.putIfAbsent(index, () => 0);
          final selectedPrice = prices[selectedSizeIndex[index]!];

          final imageUrl = product['main_img'];
          final completeUrl = '$baseImageUrl$imageUrl';

          Util.pretty(completeUrl);

          return Container(
            width: 180,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: SizedBox(
                    height: 110,
                    width: double.infinity,
                    child: Image.network(
                      completeUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image,
                            size: 40, color: Colors.red),
                      ),
                    ),
                  ),
                ),

                // Product Name
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Text(
                    product['product_name'] ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),

                // Dropdown for size
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: selectedSizeIndex[index],
                    underline: const SizedBox(),
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                    items: List.generate(
                      prices.length,
                      (i) => DropdownMenuItem<int>(
                        value: i,
                        child: Text(prices[i]['size']),
                      ),
                    ),
                    onChanged: (int? newIndex) {
                      setState(() {
                        selectedSizeIndex[index] = newIndex!;
                      });
                    },
                  ),
                ),

                // Sale Price
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.currency_rupee,
                          size: 14, color: Colors.green),
                      Row(
                        children: [
                          Text(
                            "${selectedPrice['sale_price']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                          Gapw(width: 20),
                          if (selectedPrice['paper_price'] !=
                              selectedPrice['sale_price'])
                            Text(
                              "₹${selectedPrice['paper_price']}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // MRP & Discount
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      if (selectedPrice['discount_percentage'] != "0.00")
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.local_offer,
                                  size: 12, color: Colors.white),
                              const SizedBox(width: 2),
                              Text(
                                "${selectedPrice['discount_percentage']}% OFF",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                const Spacer(),

                InkWell(
                  onTap: () async {
                    final priceId = selectedPrice['price_id'];

                    print('Product ID: $productId');
                    print('Price ID: $priceId');

                    final result = await CartService.addToCartHttp(
                      productId: productId.toString(),
                      priceId: priceId.toString(),
                      shopId: shopId.toString(),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          result['message'],
                          textAlign: TextAlign.center,
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor:
                            result['success'] ? Colors.green : Colors.red,
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Appcolor.primaryRed,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_shopping_cart,
                            size: 18, color: Colors.white),
                        SizedBox(width: 6),
                        Text(
                          "Add to Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
