import 'package:flutter/material.dart';
import 'package:pizzeria/class/cart.dart';
import 'package:pizzeria/class/pizza.dart';

class BuyButtonWidget extends StatelessWidget {
  final Pizza _pizza;
  final Cart _cart;

  const BuyButtonWidget(this._pizza, this._cart, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () => _cart.addProdct(_pizza),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red.shade600)),
          child: const Row(children: [
            Icon(Icons.shopping_cart),
            SizedBox(width: 5),
            Text("Commander")
          ]),
        )
      ],
    );
  }
}
