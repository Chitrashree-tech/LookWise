import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyOutfitSuggestionsPage extends StatefulWidget {
  const DailyOutfitSuggestionsPage({super.key});

  @override
  State<DailyOutfitSuggestionsPage> createState() =>
      _DailyOutfitSuggestionsPageState();
}

class _DailyOutfitSuggestionsPageState
    extends State<DailyOutfitSuggestionsPage> {
  // Dummy current temperature (replace with actual data)
  double get _currentTemperature => 31.5;

  final Map<String, List<Map<String, String>>> _temperatureBasedSuggestions = {
    '20-24°C': [
      {
        "top": "Long Sleeve Cotton Shirt",
        "bottom": "Jeans",
        "footwear": "Sneakers",
        "accessories": "Light scarf",
        "color_match": "Comfortable for mild weather.",
        "rationale":
            "A long-sleeve cotton shirt provides enough warmth without being too heavy, paired with jeans for a classic casual look. Sneakers offer comfortable footwear for everyday activities, and a light scarf can add a touch of style without being cumbersome.",
      },
      {
        "top": "Light Sweater",
        "bottom": "Chinos",
        "footwear": "Loafers",
        "accessories": "Simple watch",
        "color_match": "Good for a slightly cooler day.",
        "rationale":
            "A light sweater offers a bit more insulation, and chinos are a versatile and comfortable bottom option. Loafers provide a slightly more polished yet still comfortable footwear choice. A simple watch is a practical and understated accessory for daily wear.",
      },
      {
        "top": "Cardigan over a Tee",
        "bottom": "Corduroys",
        "footwear": "Casual boots",
        "accessories": "Small pendant",
        "color_match": "Layered for adaptability.",
        "rationale":
            "Layering allows you to adjust to temperature changes, and corduroys add a touch of texture and warmth. Casual boots offer comfortable and supportive footwear. A small pendant is a subtle and easy-to-wear accessory.",
      },
      {
        "top": "Flannel Shirt",
        "bottom": "Dark Wash Jeans",
        "footwear": "Sneakers",
        "accessories": "Bracelet",
        "color_match": "Casual and cozy.",
        "rationale":
            "A flannel shirt provides a bit of warmth and a relaxed vibe, complemented by dark wash jeans. Sneakers are a comfortable and practical footwear choice for a casual look. A bracelet adds a touch of personal style without being too much.",
      },
      {
        "top": "Lightweight Jacket",
        "bottom": "Trousers",
        "footwear": "Oxfords",
        "accessories": "Belt",
        "color_match": "For a bit of protection from the breeze.",
        "rationale":
            "A lightweight jacket shields from wind, and trousers offer a slightly more polished look. Oxfords are a smart and comfortable footwear option. A belt is a necessary and often stylish accessory.",
      },
      {
        "top": "Hoodie",
        "bottom": "Joggers",
        "footwear": "Trainers",
        "accessories": "Cap",
        "color_match": "Relaxed and sporty.",
        "rationale":
            "A hoodie is comfortable and casual, paired with joggers for ease of movement. Trainers are the natural footwear choice for a sporty and relaxed outfit. A cap can offer sun protection and add to the casual vibe.",
      },
      {
        "top": "Denim Shirt",
        "bottom": "Khaki Pants",
        "footwear": "Boat shoes",
        "accessories": "Sunglasses",
        "color_match": "Classic and versatile.",
        "rationale":
            "A denim shirt is a timeless piece, and khaki pants are a neutral and adaptable choice. Boat shoes offer a comfortable and classic footwear option. Sunglasses are essential for sunny days and a simple yet stylish accessory.",
      },
      {
        "top": "Turtle Neck",
        "bottom": "Black Pants",
        "footwear": "Ankle boots",
        "accessories": "Earrings",
        "color_match": "Sleek and warm enough.",
        "rationale":
            "A turtleneck provides warmth around the neck, and black pants are a stylish and versatile bottom. Ankle boots offer a sleek and comfortable footwear choice. Simple earrings can add a touch of elegance without being heavy.",
      },
      {
        "top": "Sweatshirt",
        "bottom": "Track Pants",
        "footwear": "Slip-on sneakers",
        "accessories": "Wristband",
        "color_match": "Comfortable for leisure.",
        "rationale":
            "A sweatshirt is soft and warm, paired with track pants for ultimate comfort. Slip-on sneakers are easy and comfortable footwear for leisure activities. A wristband can be a practical or stylistic simple accessory.",
      },
      {
        "top": "Long Sleeve Polo",
        "bottom": "Slim Fit Jeans",
        "footwear": "Driving shoes",
        "accessories": "Stylish watch",
        "color_match": "Smart casual option.",
        "rationale":
            "A long-sleeve polo offers a slightly more refined look than a t-shirt, paired with slim fit jeans for a modern silhouette. Driving shoes are a comfortable and stylish footwear choice for a smart casual look. A stylish watch is a practical and often subtle accessory.",
      },
    ],
    '25-29°C': [
      {
        "top": "Short Sleeve T-Shirt",
        "bottom": "Shorts",
        "footwear": "Sandals",
        "accessories": "Sunglasses",
        "color_match": "Ideal for warm days.",
        "rationale":
            "Short sleeves and shorts are perfect for staying cool. Sandals are comfortable and breathable footwear for warm weather. Sunglasses are essential for sun protection and a simple accessory.",
      },
      {
        "top": "Polo Shirt",
        "bottom": "Chino Shorts",
        "footwear": "Loafers",
        "accessories": "Light belt",
        "color_match": "Smart and cool.",
        "rationale":
            "A polo shirt offers a slightly more polished look while remaining cool. Loafers provide a comfortable yet smart casual footwear option. A light belt is a practical and subtle accessory.",
      },
      {
        "top": "Linen Shirt",
        "bottom": "Linen Pants",
        "footwear": "Espadrilles",
        "accessories": "Straw hat",
        "color_match": "Breathable for hot weather.",
        "rationale":
            "Linen is highly breathable, making this ideal for warmer temperatures. Espadrilles are lightweight and comfortable footwear. A straw hat offers sun protection and a relaxed vibe.",
      },
      {
        "top": "Tank Top",
        "bottom": "Denim Skirt",
        "footwear": "Flip-flops",
        "accessories": "Lightweight scarf (optional)",
        "color_match": "Cool and casual.",
        "rationale":
            "A tank top keeps arms cool, and a denim skirt is casual and comfortable. Flip-flops are the quintessential warm-weather footwear. A lightweight scarf can add a touch of style or sun protection without being heavy.",
      },
      {
        "top": "Short Sleeve Button-Down",
        "bottom": "Bermuda Shorts",
        "footwear": "Boat shoes",
        "accessories": "Casual watch",
        "color_match": "Relaxed yet stylish.",
        "rationale":
            "A short-sleeve button-down offers a bit more polish than a t-shirt while still being cool. Boat shoes are comfortable and stylish footwear. A casual watch is a practical and simple accessory.",
      },
      {
        "top": "Sleeveless Blouse",
        "bottom": "Wide Leg Trousers",
        "footwear": "Flat sandals",
        "accessories": "Tote bag",
        "color_match": "Flowy and comfortable.",
        "rationale":
            "Sleeveless tops and wide-leg trousers allow for air circulation and comfort. Flat sandals are easy and comfortable footwear. A tote bag is a practical accessory for carrying essentials.",
      },
      {
        "top": "Lightweight Cotton Top",
        "bottom": "Capri Pants",
        "footwear": "Sandals",
        "accessories": "Necklace",
        "color_match": "Easy and breezy.",
        "rationale":
            "Light cotton is breathable, and capri pants offer a bit more coverage than shorts while still being cool. Sandals are comfortable for everyday wear. A simple necklace can add a touch of style.",
      },
      {
        "top": "Performance Tee",
        "bottom": "Athletic Shorts",
        "footwear": "Athletic sandals",
        "accessories": "Sports watch",
        "color_match": "Great for active days.",
        "rationale":
            "Performance fabrics wick away moisture, ideal for warmer activity. Athletic sandals provide breathable footwear. A sports watch is a functional accessory for active wear.",
      },
      {
        "top": "Henley Shirt",
        "bottom": "Canvas Shorts",
        "footwear": "Sneakers",
        "accessories": "Wristband",
        "color_match": "Casual with a bit of style.",
        "rationale":
            "A henley offers a bit more detail than a plain t-shirt, paired with durable canvas shorts. Sneakers are comfortable and versatile footwear. A wristband is a simple, often sporty accessory.",
      },
      {
        "top": "V-Neck Tee",
        "bottom": "Drawstring Pants",
        "footwear": "Espadrilles",
        "accessories": "Light scarf",
        "color_match": "Simple and comfortable.",
        "rationale":
            "A v-neck tee is a basic and comfortable option, paired with easy-to-wear drawstring pants. Espadrilles are lightweight and casual footwear. A light scarf can add a touch of color or be used for light sun protection.",
      },
    ],
    '30-34°C': [
      {
        "top": "Lightweight Tank Top",
        "bottom": "Breathable Shorts",
        "footwear": "Flip-flops",
        "accessories": "Sunglasses, wide-brimmed hat",
        "color_match": "Keep cool in the heat.",
        "rationale":
            "Minimal fabric allows for maximum cooling in hot temperatures. Flip-flops are the easiest footwear for the heat. Sunglasses and a wide-brimmed hat are essential for sun protection in India.",
      },
      {
        "top": "Loose Fit Linen Shirt",
        "bottom": "Lightweight Skirt",
        "footwear": "Flat sandals",
        "accessories": "Straw hat, small crossbody bag",
        "color_match": "Airy and comfortable for hot days.",
        "rationale":
            "Loose-fitting linen allows for airflow, and a lightweight skirt keeps legs cool. Flat sandals are comfortable for walking. A straw hat provides sun protection, and a small crossbody bag keeps essentials handy without adding bulk.",
      },
      {
        "top": "Cotton Vest",
        "bottom": "Cotton Shorts",
        "footwear": "Sandals",
        "accessories": "Sunglasses, simple cotton scarf (for sun protection)",
        "color_match": "Minimal coverage for maximum coolness.",
        "rationale":
            "A vest keeps the torso relatively cool, paired with cotton shorts for breathability. Sandals are comfortable for daily wear. Sunglasses are a must, and a light cotton scarf can be used to protect the neck and face from the sun.",
      },
      {
        "top": "Sleeveless Cotton Top",
        "bottom": "Linen Blend Pants",
        "footwear": "Espadrilles",
        "accessories": "Lightweight cotton or linen scarf, small earrings",
        "color_match": "Light and stylish.",
        "rationale":
            "Sleeveless tops keep arms cool, and linen blend pants offer breathability with a bit more coverage. Espadrilles are comfortable and stylish. A light scarf can add a touch of elegance and sun protection, paired with small earrings for a subtle touch.",
      },
      {
        "top": "Thin Strap Top",
        "bottom": "Flowy Palazzo Pants",
        "footwear": "Flat sandals",
        "accessories": "Sunglasses, delicate bracelet",
        "color_match": "Elegant and cool.",
        "rationale":
            "Thin straps and flowy palazzo pants allow for maximum air circulation. Flat sandals are comfortable and chic. A delicate bracelet adds a subtle touch of elegance.",
      },
      {
        "top": "Moisture-Wicking Tee",
        "bottom": "Quick-Dry Shorts",
        "footwear": "Athletic sandals or breathable sneakers",
        "accessories": "Visor or cap, hydration pack (if active)",
        "color_match": "Ideal for humid conditions.",
        "rationale":
            "Moisture-wicking fabrics draw sweat away from the skin, and quick-dry shorts prevent discomfort from humidity. Athletic sandals or breathable sneakers are good for warmer, active days. A visor or cap offers sun protection, and a hydration pack is useful for staying hydrated.",
      },
      {
        "top": "Open-Back Top",
        "bottom": "High-Waisted Shorts",
        "footwear": "Flat sandals or stylish slip-ons",
        "accessories": "Sunglasses, small sling bag",
        "color_match": "Trendy and keeps you cool.",
        "rationale":
            "An open-back design allows for ventilation, paired with stylish high-waisted shorts. Flat sandals or stylish slip-ons are comfortable and fashionable. A small sling bag keeps essentials secure without being cumbersome.",
      },
      {
        "top": "Halter Top",
        "bottom": "Lightweight Culottes",
        "footwear": "Flip-flops or flat sandals",
        "accessories": "Wide-brimmed hat, simple anklet",
        "color_match": "Chic and comfortable in the heat.",
        "rationale":
            "Halter tops leave the shoulders and back bare, paired with breezy culottes. Flip-flops or flat sandals are easy and comfortable. A wide-brimmed hat offers excellent sun protection, and a simple anklet adds a touch of flair.",
      },
      {
        "top": "Cropped Tank",
        "bottom": "Paper Bag Waist Shorts",
        "footwear": "Sandals or espadrilles",
        "accessories": "Sunglasses, small waist pouch (worn as a crossbody)",
        "color_match": "Fashionable and cool.",
        "rationale":
            "A cropped tank exposes the midriff for coolness, paired with trendy paper bag waist shorts. Sandals or espadrilles are comfortable and stylish footwear. A small waist pouch worn across the body keeps essentials secure and hands-free.",
      },
      {
        "top": "Bamboo Fabric Tee",
        "bottom": "Bamboo Fabric Shorts",
        "footwear": "Lightweight sandals or breathable sneakers",
        "accessories": "Sunglasses, minimalist watch",
        "color_match": "Naturally breathable and soft.",
        "rationale":
            "Bamboo fabric is known for its excellent breathability and soft feel in hot weather. Lightweight sandals or breathable sneakers are comfortable choices. A minimalist watch is a practical and understated accessory.",
      },
    ],
    '< 20°C': [
      {
        "top": "Heavy Coat",
        "bottom": "Thick Pants",
        "footwear": "Winter boots",
        "accessories": "Warm scarf, gloves, hat",
        "color_match": "Warmest for cold.",
        "rationale":
            "A heavy coat provides maximum insulation for very cold conditions. Thick pants help retain body heat. Winter boots offer warmth and protection for the feet. A warm scarf, gloves, and hat are essential for protecting extremities from the cold.",
      },
      {
        "top": "Wool Sweater",
        "bottom": "Fleece Lined Leggings",
        "footwear": "Warm boots",
        "accessories": "Wool scarf, mittens, beanie",
        "color_match": "Cozy layers.",
        "rationale":
            "A wool sweater provides excellent warmth as a mid-layer. Fleece-lined leggings add an extra layer of insulation under pants or can be worn alone. Warm boots keep feet cozy. A wool scarf, mittens, and a beanie provide significant warmth for the head and hands.",
      },
      {
        "top": "Puffer Jacket",
        "bottom": "Thermal Trousers",
        "footwear": "Insulated boots",
        "accessories": "Thick gloves, warm hat",
        "color_match": "Insulated for warmth.",
        "rationale":
            "A puffer jacket traps air for insulation, keeping the core warm. Thermal trousers provide an insulating base layer. Insulated boots offer warmth and protection from the cold ground. Thick gloves and a warm hat are crucial for preventing heat loss.",
      },
      {
        "top": "Parka",
        "bottom": "Wool Skirt with Tights",
        "footwear": "Waterproof boots",
        "accessories": "Warm scarf, earmuffs, gloves",
        "color_match": "Protective and warm.",
        "rationale":
            "A parka offers protection from wind and potential snow or rain, as well as warmth. A wool skirt worn with thick tights provides warmth while allowing for a different style. Waterproof boots keep feet dry and warm. A warm scarf, earmuffs, and gloves protect vulnerable areas from the cold.",
      },
      {
        "top": "Fleece Hoodie",
        "bottom": "Corduroy Pants",
        "footwear": "Casual boots with warm lining",
        "accessories": "Scarf, gloves",
        "color_match": "Soft and insulating.",
        "rationale":
            "A fleece hoodie is soft and provides a good layer of warmth. Corduroy pants offer some insulation and a comfortable texture. Casual boots with warm lining keep feet comfortable. A scarf and gloves add necessary protection from the chill.",
      },
      {
        "top": "Quilted Jacket",
        "bottom": "Insulated Jeans",
        "footwear": "Warm sneakers or boots",
        "accessories": "Gloves, hat",
        "color_match": "Warm and practical.",
        "rationale":
            "A quilted jacket provides a good level of insulation for moderately cold conditions. Insulated jeans offer warmth without being too bulky. Warm sneakers or boots provide comfortable and warm footwear. Gloves and a hat are essential for keeping hands and head warm.",
      },
      {
        "top": "Wool Blend Coat",
        "bottom": "Wool Trousers",
        "footwear": "Dress boots with warm lining",
        "accessories": "Stylish scarf, leather gloves",
        "color_match": "Stylish and warm.",
        "rationale":
            "A wool blend coat offers a balance of style and warmth for colder days. Wool trousers provide good insulation and a smart look. Dress boots with warm lining keep feet warm while maintaining a stylish appearance. A stylish scarf and leather gloves add both warmth and a touch of elegance.",
      },
      {
        "top": "Thermal Top",
        "bottom": "Snow Pants",
        "footwear": "Snow boots",
        "accessories": "Waterproof gloves, warm hat, neck gaiter",
        "color_match": "For very cold conditions.",
        "rationale":
            "A thermal top acts as a warm base layer. Snow pants provide excellent insulation and protection from snow. Snow boots are waterproof and heavily insulated for extreme cold. Waterproof gloves, a warm hat, and a neck gaiter offer maximum protection in very cold and potentially snowy conditions.",
      },
      {
        "top": "Down Vest over Sweater",
        "bottom": "Velvet Pants",
        "footwear": "Ankle boots with warm lining",
        "accessories": "Warm scarf, elegant gloves",
        "color_match": "Layered warmth with texture.",
        "rationale":
            "A down vest adds core warmth over a sweater, allowing for arm movement. Velvet pants offer a touch of luxury and some warmth. Ankle boots with warm lining provide comfortable and stylish footwear. A warm scarf and elegant gloves add both warmth and a sophisticated touch.",
      },
      {
        "top": "Chunky Knit Sweater",
        "bottom": "Flannel Lined Pants",
        "footwear": "Warm casual boots or thick socks with sturdy shoes",
        "accessories": "Cozy scarf, mittens, warm headband",
        "color_match": "Super cozy for cold days.",
        "rationale":
            "A chunky knit sweater provides significant warmth. Flannel-lined pants add an extra layer of cozy insulation. Warm casual boots or thick socks with sturdy shoes keep feet warm. A cozy scarf, mittens, and a warm headband ensure maximum comfort and warmth on very cold days.",
      },
    ],
    '35+°C': [
      {
        "top": "Ultra-Light Tank",
        "bottom": "Flowy Linen Shorts",
        "footwear": "Flip-flops or very light sandals",
        "accessories": "Sunglasses, wide-brimmed straw hat",
        "color_match": "Maximum breathability for extreme heat.",
        "rationale":
            "Minimal fabric is key to staying cool. Flip-flops or very light sandals allow your feet to breathe. Sunglasses protect your eyes from the strong Indian sun, and a wide-brimmed straw hat provides crucial shade.",
      },
      {
        "top": "Loose Cotton Vest",
        "bottom": "Wide Leg Rayon Pants",
        "footwear": "Flat, open sandals or espadrilles",
        "accessories":
            "Straw hat or light cotton scarf (for head/neck), small crossbody bag",
        "color_match": "Airy and comfortable.",
        "rationale":
            "A loose cotton vest allows for ventilation, and wide-leg rayon pants are lightweight and flowy. Flat, open sandals or espadrilles keep your feet cool. A straw hat or light cotton scarf offers sun protection, and a small crossbody bag keeps essentials handy without adding bulk.",
      },
      {
        "top": "Thin Muslin Top",
        "bottom": "Lightweight Culottes",
        "footwear": "Flat, breathable sandals",
        "accessories": "Sunglasses, small stud earrings",
        "color_match": "Gentle on the skin in heat.",
        "rationale":
            "Muslin is a very light and breathable fabric, perfect for hot weather, paired with airy culottes. Flat, breathable sandals are comfortable for walking. Sunglasses are essential, and small stud earrings are a simple and non-obtrusive accessory.",
      },
      {
        "top": "UV Protective Long Sleeve",
        "bottom": "Quick-Dry Skirt",
        "footwear": "Comfortable sandals or walking shoes",
        "accessories": "Wide-brimmed hat or cap, reusable water bottle",
        "color_match": "Protection from sun and heat.",
        "rationale":
            "UV protective fabric shields from the intense sun, and a quick-dry skirt helps manage any moisture. Comfortable sandals or walking shoes are practical for daily activities. A wide-brimmed hat or cap offers sun protection, and staying hydrated with a reusable water bottle is crucial in the heat.",
      },
      {
        "top": "Halter Neck Cotton Dress",
        "bottom": "",
        "footwear": "Flip-flops or flat sandals",
        "accessories": "Sunglasses, small pendant necklace",
        "color_match": "Single layer to stay cool.",
        "rationale":
            "A single-layer cotton dress minimizes fabric against the skin, promoting coolness. Flip-flops or flat sandals are the easiest footwear. Sunglasses are essential, and a small pendant necklace is a simple and elegant accessory.",
      },
      {
        "top": "Spaghetti Strap Top",
        "bottom": "Loose Fit Gauze Pants",
        "footwear": "Flat, open sandals",
        "accessories": "Sunglasses, delicate anklet",
        "color_match": "Minimal and airy.",
        "rationale":
            "Spaghetti straps allow for maximum skin exposure to stay cool, paired with lightweight gauze pants for breathability. Flat, open sandals are the most comfortable footwear. Sunglasses are a must, and a delicate anklet is a light and subtle accessory.",
      },
      {
        "top": "Bamboo Sleeveless Top",
        "bottom": "Hemp Blend Shorts",
        "footwear": "Lightweight sandals or espadrilles",
        "accessories": "Sunglasses, minimalist watch",
        "color_match": "Naturally breathable and soft.",
        "rationale":
            "Bamboo and hemp are natural fibers known for their excellent breathability and soft feel in hot weather. Lightweight sandals or espadrilles are comfortable choices. A minimalist watch is a practical and non-obtrusive accessory.",
      },
      {
        "top": "Cropped Open Knit Top",
        "bottom": "Lightweight Joggers",
        "footwear": "Breathable sneakers or sandals",
        "accessories": "Sunglasses, small backpack (if needed)",
        "color_match": "Stylish while staying cool.",
        "rationale":
            "A cropped open knit top allows for some ventilation, paired with lightweight joggers for comfort. Breathable sneakers or sandals are suitable footwear. Sunglasses are essential, and a small backpack can be practical for carrying essentials without adding heat.",
      },
      {
        "top": "Seamless Breathable Tee",
        "bottom": "Performance Skort",
        "footwear": "Athletic sandals or breathable walking shoes",
        "accessories": "Visor or cap, small fan (handheld)",
        "color_match": "Comfortable for movement in heat.",
        "rationale":
            "Seamless and breathable fabrics prevent chafing and wick away moisture, paired with a practical skort. Athletic sandals or breathable walking shoes are comfortable for being on your feet. A visor or cap offers sun protection, and a small handheld fan can provide extra relief from the heat.",
      },
      {
        "top": "Tie-Front Lightweight Blouse",
        "bottom": "Lightweight Twill Shorts",
        "footwear": "Comfortable sandals or espadrilles",
        "accessories": "Sunglasses, light hair tie or scrunchie",
        "color_match": "Fashionable and practical for hot weather.",
        "rationale":
            "A lightweight blouse allows for some airflow, and twill shorts are a comfortable and stylish choice. Comfortable sandals or espadrilles are good for daily wear. Sunglasses are essential, and a light hair tie or scrunchie helps keep hair off your neck in the heat.",
      },
    ],
  };

  int _suggestionIndex = 0;
  String _currentTemperatureRange = '';

  String get _currentDayOfWeek {
    final now = DateTime.now();
    return DateFormat('EEEE').format(now);
  }

  @override
  void initState() {
    super.initState();
    _updateTemperatureRange();
  }

  void _updateTemperatureRange() {
    if (_currentTemperature >= 20 && _currentTemperature <= 24) {
      _currentTemperatureRange = '20-24°C';
    } else if (_currentTemperature >= 25 && _currentTemperature <= 29) {
      _currentTemperatureRange = '25-29°C';
    } else if (_currentTemperature >= 30 && _currentTemperature <= 34) {
      _currentTemperatureRange = '30-34°C';
    } else if (_currentTemperature < 20) {
      _currentTemperatureRange = '< 20°C';
    } else {
      _currentTemperatureRange = '35+°C';
    }
    _suggestionIndex = 0; // Reset index when temperature range changes
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
        'color_match': '',
      };
    }
  }

  void _getNextSuggestion() {
    setState(() {
      _suggestionIndex =
          (_suggestionIndex + 1) % _currentRangeSuggestions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentSuggestion = _currentSuggestion;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF008A),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Outfit Suggestion for Today (${_currentDayOfWeek})",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "Current Temperature: ${_currentTemperature.toStringAsFixed(1)}°C",
              style: const TextStyle(fontSize: 20, color: Colors.pink),
            ),
            const SizedBox(height: 20),
            Text(
              "Top: ${currentSuggestion['top'] ?? 'N/A'}",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "Bottom: ${currentSuggestion['bottom'] ?? 'N/A'}",
              style: const TextStyle(fontSize: 20),
            ),
            if (currentSuggestion.containsKey(
              'footwear',
            )) // Add footwear if available
              Text(
                "Footwear: ${currentSuggestion['footwear'] ?? 'N/A'}",
                style: const TextStyle(fontSize: 20),
              ),
            if (currentSuggestion.containsKey(
              'accessories',
            )) // Add accessories if available
              Text(
                "Accessories: ${currentSuggestion['accessories'] ?? 'N/A'}",
                style: const TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 16),
            Text(
              "Color Matching: ${currentSuggestion['color_match'] ?? 'N/A'}",
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            Text(
              "Rationale: ${currentSuggestion['rationale'] ?? 'N/A'}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Suggestion saved!')),
                    );
                  },
                  child: const Text("Save Suggestion"),
                ),
                ElevatedButton(
                  onPressed: _getNextSuggestion,
                  child: const Text("Get Another Suggestion"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
