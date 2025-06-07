import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/location_service.dart';
import '../services/weather_service.dart';

class DailyOutfitSuggestionsPage extends StatefulWidget {
  const DailyOutfitSuggestionsPage({super.key});

  @override
  State<DailyOutfitSuggestionsPage> createState() =>
      _DailyOutfitSuggestionsPageState();
}

class _DailyOutfitSuggestionsPageState
    extends State<DailyOutfitSuggestionsPage> {
  double? _currentTemperature;
  String? _currentLocation;
  String? _weatherCondition;
  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();

  final Map<String, String> _weatherImages = {
    'hot': 'assets/images/hot_weather.jpg',
    'normal': 'assets/images/normal_weather.jpg',
    'rainy': 'assets/images/rainy_weather.jpg',
    'cold': 'assets/images/cold_weather.jpg',
  };

  final Map<String, List<Map<String, String>>> _temperatureBasedSuggestions = {
    '20-24°C': [
      {
        "top": "Long Sleeve Cotton Shirt",
        "bottom": "Jeans",
        "footwear": "Sneakers",
        "accessories": "Light scarf",
        "color_match": "Neutral tones work well",
        "rationale": "Perfect for mild weather - comfortable yet stylish.",
      },
      {
        "top": "Button-down Shirt",
        "bottom": "Chinos",
        "footwear": "Loafers",
        "accessories": "Watch",
        "color_match": "Try complementary colors",
        "rationale": "Smart casual look for mild temperatures.",
      },
    ],
    '25-29°C': [
      {
        "top": "Short Sleeve T-Shirt",
        "bottom": "Shorts",
        "footwear": "Sandals",
        "accessories": "Sunglasses",
        "color_match": "Bright colors recommended",
        "rationale": "Stay cool and comfortable in warm weather.",
      },
      {
        "top": "Polo Shirt",
        "bottom": "Bermuda Shorts",
        "footwear": "Canvas Shoes",
        "accessories": "Baseball Cap",
        "color_match": "Pastel shades work well",
        "rationale": "Casual yet put-together summer look.",
      },
    ],
    '30-34°C': [
      {
        "top": "Lightweight Tank Top",
        "bottom": "Linen Shorts",
        "footwear": "Flip-flops",
        "accessories": "Sunglasses, Wide-brim hat",
        "color_match": "Light colors reflect heat",
        "rationale": "Minimal clothing for maximum cooling.",
      },
      {
        "top": "Sleeveless Blouse",
        "bottom": "Flowery Skirt",
        "footwear": "Strappy Sandals",
        "accessories": "Sunhat, Tote bag",
        "color_match": "Floral patterns recommended",
        "rationale": "Breathable fabrics for extreme heat.",
      },
    ],
    '< 20°C': [
      {
        "top": "Heavy Coat",
        "bottom": "Thermal Pants",
        "footwear": "Winter Boots",
        "accessories": "Scarf, Gloves, Beanie",
        "color_match": "Dark colors retain heat",
        "rationale": "Maximum insulation for cold weather.",
      },
      {
        "top": "Wool Sweater",
        "bottom": "Corduroy Pants",
        "footwear": "Leather Boots",
        "accessories": "Cashmere Scarf",
        "color_match": "Earthy tones recommended",
        "rationale": "Warm and stylish winter outfit.",
      },
    ],
    '35+°C': [
      {
        "top": "Ultra-Light Tank",
        "bottom": "Flowy Linen Shorts",
        "footwear": "Breathable Sandals",
        "accessories": "Sunglasses, Straw Hat",
        "color_match": "White reflects sunlight",
        "rationale": "Essential for extreme heat conditions.",
      },
      {
        "top": "Mesh Athletic Top",
        "bottom": "Running Shorts",
        "footwear": "Ventilated Sneakers",
        "accessories": "Cooling Towel",
        "color_match": "Light performance fabrics",
        "rationale": "For active wear in extreme heat.",
      },
    ],
  };

  int _suggestionIndex = 0;
  String _currentTemperatureRange = '';

  @override
  void initState() {
    super.initState();
    _fetchWeatherAndUpdateSuggestions();
  }

  Future<void> _fetchWeatherAndUpdateSuggestions() async {
    try {
      final position = await _locationService.getCurrentLocation();
      final temp = await _weatherService.fetchCurrentTemperature(
        position.latitude,
        position.longitude,
      );

      _currentLocation = await _locationService.getLocationName(position);

      if (temp != null) {
        if (mounted) {
          setState(() {
            _currentTemperature = temp;
            _updateTemperatureRange();
            _updateWeatherCondition();
          });
        }
      } else {
        throw Exception("Temperature is null");
      }
    } catch (e) {
      debugPrint("Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to fetch weather: $e')));
        setState(() {
          _currentTemperature = 31.0;
          _currentLocation = "Unknown Location";
          _updateTemperatureRange();
          _updateWeatherCondition();
        });
      }
    }
  }

  void _updateTemperatureRange() {
    if (_currentTemperature == null) return;

    if (_currentTemperature! >= 20 && _currentTemperature! <= 24) {
      _currentTemperatureRange = '20-24°C';
    } else if (_currentTemperature! >= 25 && _currentTemperature! <= 29) {
      _currentTemperatureRange = '25-29°C';
    } else if (_currentTemperature! >= 30 && _currentTemperature! <= 34) {
      _currentTemperatureRange = '30-34°C';
    } else if (_currentTemperature! < 20) {
      _currentTemperatureRange = '< 20°C';
    } else {
      _currentTemperatureRange = '35+°C';
    }
    _suggestionIndex = 0;
  }

  void _updateWeatherCondition() {
    if (_currentTemperature == null) return;

    if (_currentTemperature! >= 30) {
      _weatherCondition = 'hot';
    } else if (_currentTemperature! >= 20) {
      _weatherCondition = 'normal';
    } else if (_currentTemperature! < 20) {
      _weatherCondition = 'cold';
    }
  }

  List<Map<String, String>> get _currentRangeSuggestions =>
      _temperatureBasedSuggestions[_currentTemperatureRange] ?? [];

  Map<String, String> get _currentSuggestion {
    if (_currentRangeSuggestions.isNotEmpty) {
      return _currentRangeSuggestions[_suggestionIndex %
          _currentRangeSuggestions.length];
    } else {
      return {
        'top': 'No suggestion for this temperature',
        'bottom': '',
        'footwear': '',
        'accessories': '',
        'color_match': '',
        'rationale': '',
      };
    }
  }

  void _getNextSuggestion() {
    if (mounted) {
      setState(() {
        _suggestionIndex =
            (_suggestionIndex + 1) % _currentRangeSuggestions.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentSuggestion = _currentSuggestion;
    final now = DateTime.now();
    final formattedDate = DateFormat('MMMM dd, yyyy').format(now);
    final formattedTime = DateFormat('h:mm a').format(now);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF008A),
        title: const Text(
          "Daily Outfit Suggestions",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Background image
          if (_weatherCondition != null &&
              _weatherImages.containsKey(_weatherCondition))
            Positioned.fill(
              child: Image.asset(
                _weatherImages[_weatherCondition]!,
                fit: BoxFit.cover,
              ),
            ),

          // Overlay content
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(
                0.2,
              ), // dark overlay for readability
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _currentLocation ?? "Loading location...",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        _currentTemperature != null
                            ? "${_currentTemperature!.toStringAsFixed(1)}°C"
                            : "--°C",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "$formattedDate • $formattedTime",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      // Outfit Suggestion Box with transparency
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.65),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Recommended Outfit",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            _buildSuggestionItem(
                              "👕 Top",
                              currentSuggestion['top'],
                            ),
                            const SizedBox(height: 12),
                            _buildSuggestionItem(
                              "👖 Bottom",
                              currentSuggestion['bottom'],
                            ),
                            const SizedBox(height: 12),
                            _buildSuggestionItem(
                              "👟 Footwear",
                              currentSuggestion['footwear'],
                            ),
                            const SizedBox(height: 12),
                            _buildSuggestionItem(
                              "🧢 Accessories",
                              currentSuggestion['accessories'],
                            ),
                            const SizedBox(height: 16),
                            _buildSuggestionItem(
                              "🎨 Color Tips",
                              currentSuggestion['color_match'],
                              isBold: false,
                            ),
                            const SizedBox(height: 12),
                            _buildSuggestionItem(
                              "💡 Why This Works",
                              currentSuggestion['rationale'],
                              isBold: false,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Outfit saved to favorites!'),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF008A),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text("Save Outfit"),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: _getNextSuggestion,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFFFF008A),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                  color: Color(0xFFFF008A),
                                ),
                              ),
                            ),
                            child: const Text("See Another"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionItem(
    String label,
    String? value, {
    bool isBold = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(
          value ?? "Not specified",
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.w500 : FontWeight.normal,
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
