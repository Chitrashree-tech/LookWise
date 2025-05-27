import 'package:flutter/material.dart';

class OccasionResultsPage extends StatelessWidget {
  final List<Map<String, String>> results;

  const OccasionResultsPage({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outfit Suggestions'),
        backgroundColor: const Color(0xFFFF008A),
      ),
      body: results.isEmpty
          ? const Center(child: Text("No images found."))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7,
          ),
          itemCount: results.length,
          itemBuilder: (context, index) {
            final item = results[index];
            return Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: item['image'] != null && item['image']!.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item['image']!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 60),
                      ),
                    )
                        : Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, size: 60),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item['title'] ?? "Outfit",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF008A),
                        minimumSize: const Size.fromHeight(36),
                      ),
                      onPressed: () {
                        // Implement your cart logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Added to cart!')),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart, size: 18),
                      label: const Text("Add to Cart"),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
