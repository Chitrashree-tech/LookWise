import 'models/cart_item.dart';

class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  void add(CartItem item) => _items.add(item);

  void remove(CartItem item) => _items.remove(item);

  double get total => _items.fold(0, (sum, item) => sum + item.price);

  void clear() => _items.clear();
}
