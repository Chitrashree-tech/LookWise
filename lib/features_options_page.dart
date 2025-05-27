import 'package:flutter/material.dart';
import 'screens/shop_daily_clothing_page.dart';
import 'screens/daily_outfit_suggestions_page.dart';
import 'screens/shop_for_occasions_page.dart';
import 'screens/restyle_my_wardrode_page.dart';
import 'screens/cart_page.dart';
import 'screens/chatbot_page.dart';

class Feature {
  final String name;
  final IconData icon;
  final String route;

  Feature({required this.name, required this.icon, required this.route});
}

class FeaturePage extends StatelessWidget {
  FeaturePage({super.key});

  final List<Feature> features = [
    Feature(name: 'Shop Daily Clothing', icon: Icons.shopping_bag, route: '/shop_daily_clothing'),
    Feature(name: 'Daily Outfit Suggestions', icon: Icons.today, route: '/daily_outfit_suggestions'),
    Feature(name: 'Shop for Occasions', icon: Icons.event, route: '/shop_for_occasions'),
    Feature(name: 'Restyle my wardrobe', icon: Icons.checkroom, route: '/restyle_my_wardrobe'),
    Feature(name: 'Chatbot', icon: Icons.smart_toy, route: '/chatbot'),
  ];

  final List<String> savedSuggestions = [
    'Outfit Idea 1',
    'Accessory 2',
    'Look for Wedding',
    'Casual Friday Outfit',
    'Summer Dress Suggestion',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: const Color(0xFFFF008A),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          "LookWise..",
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Icon(Icons.person, color: Color(0xFFFF008A)),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFFF008A),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(Icons.person, size: 40, color: Color(0xFFFF008A)),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'User Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Edit Preferences'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/body_type');
              },
            ),
            const Divider(),
            if (savedSuggestions.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Saved Suggestions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: savedSuggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(savedSuggestions[index]),
                      onTap: () {
                        Navigator.pop(context);
                        // You can implement navigation or action for saved suggestion here
                      },
                    );
                  },
                ),
              ),
              const Divider(),
            ],
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: features.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFFFF008A),
                          child: Icon(
                            features[index].icon,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          features[index].name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          if (features[index].name == 'Chatbot') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const ChatbotPage()),
                            );
                          } else {
                            Navigator.pushNamed(context, features[index].route);
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartPage()),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF008A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  label: const Text(
                    "View Cart",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
