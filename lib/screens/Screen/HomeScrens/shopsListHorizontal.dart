import 'package:amir_chikan/presentation/Global_widget/apptext.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final List<dynamic> categories;

  const Categories({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length > 4 ? 4 : categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 170,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Optional: Navigate or show details
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.08),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      categories[index]['image'],
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      categories[index]['category_name'] ?? "name",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
