import 'package:flutter/material.dart';

class RestyleMyWardrobePage extends StatefulWidget {
  const RestyleMyWardrobePage({super.key});

  @override
  State<RestyleMyWardrobePage> createState() => _RestyleMyWardrobePageState();
}

class _RestyleMyWardrobePageState extends State<RestyleMyWardrobePage> {
  List<ClothingItem> _closet = [];
  List<String> _suggestions = [];

  String? _selectedType;
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _specificTypeController =
      TextEditingController(); // For t-shirt, jeans, etc.
  final TextEditingController _materialController = TextEditingController();
  final TextEditingController _styleController = TextEditingController();
  final TextEditingController _accessoryTypeController =
      TextEditingController(); // Specific accessory
  final TextEditingController _footwearKindController =
      TextEditingController(); // Kind of footwear

  final List<String> _clothingBaseTypes = [
    'Top',
    'Bottom',
    'Dress',
    'Outerwear',
    'Footwear',
    'Accessory',
  ];

  void _addItemToCloset() {
    if (_selectedType != null && _colorController.text.isNotEmpty) {
      String specificType = '';
      String footwearKind = '';
      if (_selectedType == 'Top' || _selectedType == 'Bottom') {
        specificType = _specificTypeController.text;
      } else if (_selectedType == 'Accessory') {
        specificType = _accessoryTypeController.text;
      } else if (_selectedType == 'Footwear') {
        footwearKind = _footwearKindController.text;
      }

      final newItem = ClothingItem(
        baseType: _selectedType!,
        specificType: specificType.isNotEmpty ? specificType : null,
        color: _colorController.text,
        material:
            _materialController.text.isNotEmpty
                ? _materialController.text
                : null,
        style: _styleController.text.isNotEmpty ? _styleController.text : null,
        footwearKind: footwearKind.isNotEmpty ? footwearKind : null,
      );

      setState(() {
        _closet.add(newItem);
        print(
          'Added item: ${newItem.baseType}, ${newItem.color}, kind: ${newItem.footwearKind}, material: ${newItem.material}',
        );
        print('Current closet: $_closet'); // Print the entire list
        _selectedType = null;
        _colorController.clear();
        _specificTypeController.clear();
        _materialController.clear();
        _styleController.clear();
        _accessoryTypeController.clear();
        _footwearKindController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Base Type and Color are required.')),
      );
    }
  }

  void _removeItemFromCloset(int index) {
    setState(() {
      _closet.removeAt(index);
    });
  }

  void _generateSuggestions() {
    if (_closet.isNotEmpty) {
      setState(() {
        _suggestions = _generateOutfitCombinations(_closet);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your closet is empty. Add some items first.'),
        ),
      );
    }
  }

  List<String> _generateOutfitCombinations(List<ClothingItem> closet) {
    List<String> suggestions = [];
    List<ClothingItem> tops =
        closet.where((item) => item.baseType == 'Top').toList();
    List<ClothingItem> bottoms =
        closet.where((item) => item.baseType == 'Bottom').toList();
    List<ClothingItem> dresses =
        closet.where((item) => item.baseType == 'Dress').toList();
    List<ClothingItem> outerwears =
        closet.where((item) => item.baseType == 'Outerwear').toList();
    List<ClothingItem> footwear =
        closet.where((item) => item.baseType == 'Footwear').toList();
    List<ClothingItem> accessories =
        closet.where((item) => item.baseType == 'Accessory').toList();

    // Suggest dresses as standalone outfits with optional footwear and accessories
    for (var dress in dresses) {
      String suggestion =
          'Suggestion: ${dress.color} ${dress.specificType ?? dress.baseType}';
      if (footwear.isNotEmpty) {
        suggestion +=
            ' with ${footwear.first.color} Footwear (${footwear.first.footwearKind ?? 'kind not specified'})';
      }
      if (accessories.isNotEmpty) {
        suggestion +=
            ' and a ${accessories.first.color} ${accessories.first.specificType ?? 'Accessory'}';
      }
      suggestions.add(suggestion);
    }

    // Suggest tops with bottoms, optional outerwear, footwear, and accessories
    for (var top in tops) {
      for (var bottom in bottoms) {
        for (var shoe in footwear) {
          String suggestion =
              'Suggestion: ${top.color} ${top.specificType ?? top.baseType} with ${bottom.color} ${bottom.specificType ?? bottom.baseType} and ${shoe.color} Footwear (${shoe.footwearKind ?? 'kind not specified'})';
          if (outerwears.isNotEmpty) {
            suggestion += ' (Outerwear: ${outerwears.first.color})';
          }
          if (accessories.isNotEmpty) {
            suggestion +=
                ' with a ${accessories.first.color} ${accessories.first.specificType ?? 'Accessory'}';
          }
          suggestions.add(suggestion);
        }
        // If no footwear, still suggest the top and bottom (once per top-bottom pair)
        if (footwear.isEmpty) {
          String suggestion =
              'Suggestion: ${top.color} ${top.specificType ?? top.baseType} with ${bottom.color} ${bottom.specificType ?? bottom.baseType}';
          if (outerwears.isNotEmpty) {
            suggestion += ' (Outerwear: ${outerwears.first.color})';
          }
          if (accessories.isNotEmpty) {
            suggestion +=
                ' with a ${accessories.first.color} ${accessories.first.specificType ?? 'Accessory'}';
          }
          suggestions.add(suggestion);
        }
      }
    }

    if (suggestions.isEmpty && closet.isNotEmpty) {
      suggestions.add(
        'No specific outfit combinations found based on types. '
        'Try adding more variety to your closet!',
      );
    } else if (closet.isEmpty) {
      suggestions.add(
        'Your closet is empty. Add some items to get suggestions!',
      );
    }

    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restyle My Wardrobe',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFF008A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Item to Your Closet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Base Type'),
              value: _selectedType,
              items:
                  _clothingBaseTypes
                      .map(
                        (type) =>
                            DropdownMenuItem(value: type, child: Text(type)),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a base type';
                }
                return null;
              },
            ),
            if (_selectedType == 'Top' || _selectedType == 'Bottom')
              TextField(
                controller: _specificTypeController,
                decoration: const InputDecoration(
                  labelText: 'Specific Type (e.g., t-shirt, jeans)',
                ),
              ),
            if (_selectedType == 'Footwear')
              TextField(
                controller: _footwearKindController,
                decoration: const InputDecoration(
                  labelText: 'Kind of Footwear (e.g., sneakers, heels)',
                ),
              ),
            if (_selectedType == 'Accessory')
              TextField(
                controller: _accessoryTypeController,
                decoration: const InputDecoration(labelText: 'Accessory Type'),
              ),
            if (_selectedType != 'Footwear')
              TextField(
                controller: _colorController,
                decoration: const InputDecoration(labelText: 'Color'),
              ),
            if (_selectedType != 'Footwear' && _selectedType != 'Accessory')
              TextField(
                controller: _materialController,
                decoration: const InputDecoration(
                  labelText: 'Material (Optional)',
                ),
              ),
            if (_selectedType != 'Footwear' && _selectedType != 'Accessory')
              TextField(
                controller: _styleController,
                decoration: const InputDecoration(
                  labelText: 'Style (Optional)',
                ),
              ),
            if (_selectedType == 'Footwear')
              TextField(
                controller: _materialController,
                decoration: const InputDecoration(
                  labelText: 'Material (Optional)',
                ),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addItemToCloset,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF008A),
              ),
              child: const Text(
                'Add Item',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Current Closet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            _closet.isEmpty
                ? const Text('Your closet is empty. Add some items!')
                : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _closet.length,
                  itemBuilder: (context, index) {
                    final item = _closet[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.baseType == 'Footwear'
                                  ? '${item.color} Footwear (${item.footwearKind ?? 'kind not specified'}) '
                                      '${item.material?.isNotEmpty == true ? "(${item.material})" : ""}'
                                  : '${item.color} ${item.specificType ?? item.baseType} '
                                      '${item.material?.isNotEmpty == true ? "(${item.material})" : ""} '
                                      '${item.style?.isNotEmpty == true ? "[${item.style}]" : ""}',
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _removeItemFromCloset(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            const SizedBox(height: 20),
            const Text(
              'Outfit Suggestions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            _suggestions.isEmpty
                ? const Text(
                  'No outfit suggestions yet. Add items and generate!',
                )
                : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_suggestions[index]),
                      ),
                    );
                  },
                ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateSuggestions,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF008A),
              ),
              child: const Text(
                'Generate Suggestions',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClothingItem {
  final String baseType;
  final String? specificType;
  final String color;
  final String? material;
  final String? style;
  final String? footwearKind;

  ClothingItem({
    required this.baseType,
    this.specificType,
    required this.color,
    this.material,
    this.style,
    this.footwearKind,
  });
}
