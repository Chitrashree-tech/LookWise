import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cart_item.dart';
import '../cart_manager.dart';
import 'cart_page.dart';

const String apiKey = "AIzaSyDgD17God6JdvtULPEJh3I5eitQOJKCaYE";
const String cx = "92adab9f992d345ee";

Future<List<Map<String, String>>> fetchClothingImages(String category) async {
  final url =
      'https://www.googleapis.com/customsearch/v1?q=${Uri.encodeComponent("female daily $category clothing")}'
      '&key=$apiKey'
      '&cx=$cx'
      '&searchType=image'
      '&safe=active'
      '&num=8';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final items = data['items'] as List<dynamic>? ?? [];
    return items.map<Map<String, String>>((item) {
      return {
        'title': item['title'] ?? '',
        'image': item['link'] ?? '',
      };
    }).toList();
  } else {
    print('Search API error: ${response.statusCode} ${response.body}');
    throw Exception('Failed to fetch images');
  }
}

class ShopDailyClothingPage extends StatefulWidget {
  const ShopDailyClothingPage({super.key});
  @override
  State<ShopDailyClothingPage> createState() => _ShopDailyClothingPageState();
}

class _ShopDailyClothingPageState extends State<ShopDailyClothingPage> {
  String _selectedCategory = _clothingCategories.first;
  bool _loading = false;
  List<Map<String, String>> _images = [];

  @override
  void initState() {
    super.initState();
    _fetchImagesForCategory(_selectedCategory);
  }

  Future<void> _fetchImagesForCategory(String category) async {
    setState(() {
      _loading = true;
      _selectedCategory = category;
    });
    try {
      final images = await fetchClothingImages(category);
      setState(() {
        _images = images;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _images = [];
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF008A),
        title: const Text(
          "Shop Daily Clothing",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _clothingCategories.length,
                  itemBuilder: (context, index) {
                    final category = _clothingCategories[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: _selectedCategory == category,
                        selectedColor: const Color(0xFFFF008A),
                        labelStyle: TextStyle(
                          color: _selectedCategory == category ? Colors.white : Colors.black,
                        ),
                        onSelected: (selected) {
                          if (selected) {
                            _fetchImagesForCategory(category);
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Featured Items",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  final item = _images[index];
                  final inCart = CartManager().items.any(
                        (cartItem) => cartItem.imageUrl == item['image'],
                  );
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: item['image'] != null && item['image']!.isNotEmpty
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item['image']!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 60),
                            ),
                          )
                              : Container(
                            color: Colors.grey[200],
                            width: double.infinity,
                            child: const Icon(Icons.image, size: 60),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item['title'] ?? "Item Name",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: inCart ? Colors.green : const Color(0xFFFF008A),
                              minimumSize: const Size.fromHeight(36),
                            ),
                            onPressed: inCart
                                ? null
                                : () {
                              CartManager().add(CartItem(
                                title: item['title'] ?? 'Item',
                                imageUrl: item['image'] ?? '',
                                price: 399.0, // Example price
                              ));
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Added to cart!')),
                              );
                            },
                            icon: Icon(
                              inCart ? Icons.check : Icons.add_shopping_cart,
                              size: 18,
                            ),
                            label: Text(inCart ? "Added" : "Add to Cart"),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const List<String> _clothingCategories = [
  "Tops",
  "Bottoms",
  "Dresses",
  "Outerwear",
  "Shoes",
  "Accessories",
];
