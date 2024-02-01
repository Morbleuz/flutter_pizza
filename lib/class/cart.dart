import 'package:pizzeria/class/pizza.dart';

class CartItem {
  final Pizza pizza;
  int quantity;

  CartItem(this.pizza, [this.quantity = 1]);
}

class Cart {
  List<CartItem> _items = [];

  int totalItems() {
    return _items.length;
  }

  get total {
    double total = 0;
    for (CartItem item in _items) {
      total += item.pizza.total * item.quantity;
    }
    return total;
  }

  CartItem getCartItem(int index) {
    return _items[index];
  }

  void addProdct(Pizza pizza) {
    int index = findCartItemIndex(pizza.id);
    if (index == -1) {
      print('nouvelle pizza !');
      _items.add(CartItem(pizza));
    } else {
      CartItem item = _items[index];
      item.quantity++;
      print("nouvelle quantité de pizza ! ");
      print(item.quantity);
    }
  }

  void removeProduct(Pizza pizza) {
    int index = findCartItemIndex(pizza.id);
    if (index != -1) {
      _items.removeAt(index);
    }
  }

  int findCartItemIndex(int id) {
    return _items.indexWhere((element) => element.pizza.id == id);
  }
}
