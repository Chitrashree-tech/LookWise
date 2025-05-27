import 'package:flutter/material.dart';
import '../cart_manager.dart';
import '../models/cart_item.dart';

// Simulate fetching user name from profile/database
Future<String> fetchUserName() async {
  await Future.delayed(const Duration(milliseconds: 500));
  return "Priya Sharma"; // Replace with actual logic
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String address = '';
  String phone = '';
  bool orderPlaced = false;
  bool loadingName = true;

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final userName = await fetchUserName();
    setState(() {
      nameController.text = userName;
      loadingName = false;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartManager();

    if (orderPlaced) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
          backgroundColor: const Color(0xFFFF008A),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.check_circle, color: Colors.green, size: 80),
              SizedBox(height: 24),
              Text(
                "Order placed successfully!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text("Thank you for your purchase."),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: const Color(0xFFFF008A),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: cart.items.isEmpty
            ? const Center(child: Text("Your cart is empty."))
            : loadingName
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Order Summary",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final item = cart.items[index];
                  return ListTile(
                    leading: Image.network(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(item.title),
                    trailing: Text('₹${item.price.toStringAsFixed(2)}'),
                  );
                },
              ),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('₹${cart.total.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                "Shipping Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) => value == null || value.isEmpty ? 'Enter your name' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: addressController,
                      decoration: const InputDecoration(labelText: 'Address'),
                      validator: (value) => value == null || value.isEmpty ? 'Enter your address' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                      value == null || value.length < 10 ? 'Enter valid phone' : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF008A),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                  icon: const Icon(Icons.payment),
                  label: const Text("Pay"),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        orderPlaced = true;
                      });
                      cart.clear();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
