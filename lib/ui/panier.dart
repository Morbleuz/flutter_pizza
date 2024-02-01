import 'package:flutter/material.dart';
import 'package:pizzeria/class/cart.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';

class Panier extends StatefulWidget {
  final Cart _cart;
  const Panier(this._cart, {super.key});

  @override
  State<Panier> createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon panier'),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: widget._cart.totalItems(),
            itemBuilder: (BuildContext context, int index) {
              return _buildItem(widget._cart.getCartItem(index));
            },
          )),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20.0),
            child: Table(
              border: TableBorder.all(color: Colors.red),
              children: [
                TableRow(children: [
                  Text(''),
                  Text(
                    textAlign: TextAlign.center,
                    'TOTAL HT',
                    style: PizzeriaStyle.priceSubTotalTextStyle,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    '${widget._cart.total} €',
                    style: PizzeriaStyle.priceSubTotalTextStyle,
                  ),
                ]),
                TableRow(children: [
                  Text(''),
                  Text(
                    'TVA',
                    textAlign: TextAlign.center,
                    style: PizzeriaStyle.priceSubTotalTextStyle,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    '${(widget._cart.total * 0.20).toStringAsFixed(2)} €',
                    style: PizzeriaStyle.priceSubTotalTextStyle,
                  ),
                ]),
                TableRow(children: [
                  Text(''),
                  Text(
                    'TOTAL TTC',
                    textAlign: TextAlign.center,
                    style: PizzeriaStyle.priceTotalTextStyle,
                  ),
                  Text(
                    '${widget._cart.total + widget._cart.total * 0.10} €',
                    textAlign: TextAlign.center,
                    style: PizzeriaStyle.priceTotalTextStyle,
                  ),
                ])
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: SizedBox(
              height: 50, //height of button
              width: MediaQuery.of(context).size.width, //width of button
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: const Text(
                  'VALIDER LE PANIER',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  print("Valider le panier");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(CartItem cartItem) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.30,
          height: 100,
          child: Image.network('${cartItem.pizza.image}',
              height: 120,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth),
        ),
        Padding(padding: EdgeInsets.all(10)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItem.pizza.title,
                style: PizzeriaStyle.headerTextStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${cartItem.pizza.price.toString()} €",
                    style: PizzeriaStyle.itemPriceTextStyle,
                  ),
                  //Quantité
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            cartItem.quantity--;

                            if (cartItem.quantity == 0) {
                              widget._cart.removeProduct(cartItem.pizza);
                            }
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(cartItem.quantity.toString()),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            cartItem.quantity++;
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  )
                ],
              ),
              Text(
                'Sous-total : ${cartItem.pizza.total * cartItem.quantity} €',
                style: PizzeriaStyle.priceSubTotalTextStyle,
              )
            ],
          ),
        )
      ],
    );
  }
}
