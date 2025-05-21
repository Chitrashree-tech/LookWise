import 'package:flutter/material.dart';

class Feature {
  final String name;
  final IconData icon;
  final String route; // Add a route for each feature

  Feature({required this.name, required this.icon, required this.route});
}

class FeaturePage extends StatelessWidget {
  FeaturePage({super.key});

  final List<Feature> features = [
    Feature(
      name: 'Shop Daily Clothing',
      icon: Icons.shopping_bag,
      route: '/shop_daily_clothing',
    ),
    Feature(
      name: 'Daily Outfit Suggestions',
      icon: Icons.today,
      route: '/daily_outfit_suggestions',
    ),
    Feature(
      name: 'Shop for Occasions',
      icon: Icons.event,
      route: '/shop_for_occasions',
    ),
    Feature(
      name: 'Restyle my wardrobe',
      icon: Icons.checkroom,
      route: '/restyle_my_wardrobe',
    ),
    Feature(name: 'Chatbot', icon: Icons.smart_toy, route: '/chatbot'),
  ];

  // Assuming you have access to this list of saved suggestions
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
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            // REMOVED: fontStyle: FontStyle.italic,
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
              decoration: const BoxDecoration(color: Color(0xFFFF008A)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xFFFF008A),
                    ),
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
            // Saved Suggestions Section in Drawer
            if (savedSuggestions.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Saved Suggestions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 120, // Adjust height as needed
                child: ListView.builder(
                  itemCount: savedSuggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(savedSuggestions[index]),
                      onTap: () {
                        Navigator.pop(context); // Close the drawer
                        // You can navigate to a detailed view of the suggestion here
                        print(
                          'Tapped on saved suggestion: ${savedSuggestions[index]}',
                        );
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
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/features_background_image.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: Colors.grey.shade200);
              },
            ),
          ),
          SafeArea(
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
                          color: Colors.white.withOpacity(0.85),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
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
                                color: Colors.black87,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                features[index].route,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF008A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Sign Out",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
