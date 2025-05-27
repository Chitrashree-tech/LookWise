import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../cart_manager.dart';
import '../models/cart_item.dart';
import 'cart_page.dart';

// --- Google Custom Search API credentials ---
const String apiKey = "AIzaSyDgD17God6JdvtULPEJh3I5eitQOJKCaYE";
const String cx = "92adab9f992d345ee";

// --- Function to fetch images from Google Custom Search ---
Future<List<Map<String, String>>> fetchOutfitImages(String query) async {
  final url =
      'https://www.googleapis.com/customsearch/v1?q=${Uri.encodeComponent("female $query")}'
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
    throw Exception('Failed to fetch search results');
  }
}

// --- Shop for Occasions Page ---
class ShopForOccasionsPage extends StatefulWidget {
  const ShopForOccasionsPage({super.key});

  @override
  State<ShopForOccasionsPage> createState() => _ShopForOccasionsPageState();
}

class _ShopForOccasionsPageState extends State<ShopForOccasionsPage> {
  String? _occasion;
  String? _style;
  String? _dressType;
  double? _budget = 100;
  String? _note;

  bool _loading = false;

  final List<String> _occasions = [
    'Wedding',
    'Party',
    'Business Meeting',
    'Casual Outing',
    'Festival',
    'Other',
  ];
  final List<String> _styles = [
    'Classic',
    'Trendy',
    'Elegant',
    'Bohemian',
    'Minimalist',
    'Edgy',
  ];
  final List<String> _dressTypes = [
    'Gown',
    'Kurta',
    'Saree',
    'Blazer',
    'Dress',
    'Jeans',
    'T-shirt',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop for Occasions'),
        backgroundColor: const Color(0xFFFF008A),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Occasion
                const Text(
                  "What is the occasion?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: _occasions.map((o) {
                    return ChoiceChip(
                      label: Text(o),
                      selected: _occasion == o,
                      selectedColor: const Color(0xFFFF008A),
                      labelStyle: TextStyle(
                        color: _occasion == o ? Colors.white : Colors.black,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          _occasion = selected ? o : null;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),

                // Style
                const Text(
                  "What style do you prefer?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: _styles.map((s) {
                    return ChoiceChip(
                      label: Text(s),
                      selected: _style == s,
                      selectedColor: const Color(0xFFFF008A),
                      labelStyle: TextStyle(
                        color: _style == s ? Colors.white : Colors.black,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          _style = selected ? s : null;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),

                // Dress Type
                const Text(
                  "What type of dress or outfit are you looking for?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: _dressTypes.map((d) {
                    return ChoiceChip(
                      label: Text(d),
                      selected: _dressType == d,
                      selectedColor: const Color(0xFFFF008A),
                      labelStyle: TextStyle(
                        color: _dressType == d ? Colors.white : Colors.black,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          _dressType = selected ? d : null;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),

                // Budget
                const Text(
                  "What is your budget for this outfit?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Slider(
                  value: _budget ?? 100,
                  min: 0,
                  max: 1000,
                  divisions: 20,
                  label: "\$${_budget?.round() ?? 100}",
                  onChanged: (val) {
                    setState(() {
                      _budget = val;
                    });
                  },
                ),
                Text(_budget == null ? "No budget set" : "Budget: \$${_budget!.round()}"),
                const SizedBox(height: 28),

                // Notes
                const Text(
                  "Any special notes or requirements?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "e.g., prefer eco-friendly fabrics, need plus size, etc.",
                  ),
                  onChanged: (val) => _note = val,
                ),
                const SizedBox(height: 40),

                // Get Suggestions Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF008A),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: (_occasion != null && _dressType != null)
                        ? () async {
                      setState(() => _loading = true);
                      try {
                        // Build the search query from user input
                        final query = [
                          _occasion,
                          _style,
                          _dressType,
                          'outfit ideas',
                          _note
                        ].where((e) => e != null && e.trim().isNotEmpty).join(' ');
                        final results = await fetchOutfitImages(query);
                        setState(() => _loading = false);

                        // Navigate to the results page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OccasionResultsPage(results: results),
                          ),
                        );
                      } catch (e) {
                        setState(() => _loading = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    }
                        : null,
                    child: const Text("Get Outfit Images"),
                  ),
                ),
                const SizedBox(height: 16),
                if (_occasion == null || _dressType == null)
                  const Center(
                    child: Text(
                      "Please select at least an occasion and a dress type.",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
          if (_loading)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

// --- Results Page with Add to Cart Button ---
class OccasionResultsPage extends StatefulWidget {
  final List<Map<String, String>> results;

  const OccasionResultsPage({Key? key, required this.results}) : super(key: key);

  @override
  State<OccasionResultsPage> createState() => _OccasionResultsPageState();
}

class _OccasionResultsPageState extends State<OccasionResultsPage> {
  final Set<int> _cartIndices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outfit Suggestions'),
        backgroundColor: const Color(0xFFFF008A),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
            },
          ),
        ],
      ),
      body: widget.results.isEmpty
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
          itemCount: widget.results.length,
          itemBuilder: (context, index) {
            final item = widget.results[index];
            final inCart = _cartIndices.contains(index);
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
                        backgroundColor: inCart ? Colors.green : const Color(0xFFFF008A),
                        minimumSize: const Size.fromHeight(36),
                      ),
                      onPressed: inCart
                          ? null
                          : () {
                        setState(() {
                          _cartIndices.add(index);
                        });
                        // Add to global cart
                        CartManager().add(CartItem(
                          title: item['title'] ?? 'Outfit',
                          imageUrl: item['image'] ?? '',
                          price: 499.0, // Example price
                        ));
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
      ),
    );
  }
}
