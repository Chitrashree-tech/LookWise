import 'package:flutter/material.dart';

class ShopForOccasionsPage extends StatefulWidget {
  const ShopForOccasionsPage({super.key});

  @override
  State<ShopForOccasionsPage> createState() => _ShopForOccasionsPageState();
}

class _ShopForOccasionsPageState extends State<ShopForOccasionsPage> {
  String? _selectedOccasion;
  String? _selectedStyle;
  RangeValues _priceRange = const RangeValues(0, 500); // Example price range
  String? _occasionDescription;

  final List<String> _occasions = [
    'Formal Events',
    'Casual Outings',
    'Special Events',
    'Work/Professional',
  ];

  final List<String> _styles = [
    'Bohemian',
    'Minimalist',
    'Classic',
    'Trendy',
    'Elegant',
    'Casual',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop for Occasions',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFF008A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Categorized Occasions
            const Text('Choose an Occasion:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: _occasions.map((occasion) {
                return ChoiceChip(
                  label: Text(occasion),
                  selected: _selectedOccasion == occasion,
                  onSelected: (selected) {
                    setState(() {
                      _selectedOccasion = selected ? occasion : null;
                    });
                  },
                  selectedColor: const Color(0xFFFF008A).withOpacity(0.7),
                  labelStyle: TextStyle(
                    color: _selectedOccasion == occasion
                        ? Colors.white
                        : Colors.black87,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // 2. Style Filters
            const Text('Filter by Style (Optional):',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children: _styles.map((style) {
                return ChoiceChip(
                  label: Text(style),
                  selected: _selectedStyle == style,
                  onSelected: (selected) {
                    setState(() {
                      _selectedStyle = selected ? style : null;
                    });
                  },
                  selectedColor: const Color(0xFFFF008A).withOpacity(0.7),
                  labelStyle: TextStyle(
                    color: _selectedStyle == style ? Colors.white : Colors.black87,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // 3. Price Range Filter
            const Text('Filter by Price Range (Optional):',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 1000, // Example max price
              divisions: 5,
              labels: RangeLabels(
                '\$${_priceRange.start.round()}',
                '\$${_priceRange.end.round()}',
              ),
              activeColor: const Color(0xFFFF008A),
              onChanged: (RangeValues values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Min: \$${_priceRange.start.round()}'),
                Text('Max: \$${_priceRange.end.round()}'),
              ],
            ),
            const SizedBox(height: 20),

            // 4. User Input for Occasion Description
            const Text('Describe the Occasion (Optional):',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            TextField(
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'e.g., "a beach wedding in the evening", "a formal business dinner"',
              ),
              onChanged: (value) {
                setState(() {
                  _occasionDescription = value;
                });
              },
            ),
            const SizedBox(height: 30),

            // 5. Inspiration Boards (Now moved up)
            const Text('Inspiration for Different Occasions:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildInspirationCard(
                      'Formal', 'assets/formal_inspiration.jpg', 0.6),
                  const SizedBox(width: 10),
                  _buildInspirationCard(
                      'Casual', 'assets/casual_inspiration.jpg', 0.6),
                  const SizedBox(width: 10),
                  _buildInspirationCard(
                      'Party', 'assets/party_inspiration.jpg', 0.6),
                  const SizedBox(width: 10),
                  _buildInspirationCard(
                      'Work', 'assets/work_inspiration.jpg', 0.6),
                ],
              ),
            ),
            const SizedBox(height: 30), // Added some space after inspiration

            // 6. Button to trigger search/suggestions (Now at the end)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement logic to fetch outfit suggestions based on selected filters
                  print('Selected Occasion: $_selectedOccasion');
                  print('Selected Style: $_selectedStyle');
                  print('Price Range: ${_priceRange.start} - ${_priceRange.end}');
                  print('Occasion Description: $_occasionDescription');
                  // Navigate to a page displaying outfit suggestions
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF008A),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Find Outfit Suggestions',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInspirationCard(String title, String imagePath, double opacity) {
    return InkWell(
      onTap: () {
        // TODO: Implement navigation to a page with more details or suggestions based on this inspiration
        print('Tapped on $title inspiration');
      },
      child: SizedBox(
        width: 150,
        height: 180,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(opacity),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}