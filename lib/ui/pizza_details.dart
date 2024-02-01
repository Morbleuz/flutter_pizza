import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/class/cart.dart';
import 'package:pizzeria/class/option_item.dart';
import 'package:pizzeria/class/pizza.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:pizzeria/ui/share/total_widget.dart';

class PizzaDetails extends StatefulWidget {
  final Pizza _pizza;
  final Cart _cart;
  const PizzaDetails(this._pizza, this._cart, {Key? key}) : super(key: key);

  @override
  _PizzaDetails createState() => _PizzaDetails();
}

class _PizzaDetails extends State<PizzaDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget('Nos pizzas', widget._cart),
        body: ListView(
          padding: const EdgeInsets.all(4.0),
          children: [
            Text('Pizza : ${widget._pizza.title}',
                style: PizzeriaStyle.pageTitleTextStyle),
            Image.network(
              '${widget._pizza.image}',
              height: 180,
            ),
            Text(
              'Recette',
              style: PizzeriaStyle.headerTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
              child: Text(widget._pizza.garniture),
            ),
            Text(
              'Pâte et taille sélectionnées',
              style: PizzeriaStyle.headerTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: _buildDropDownPates()),
                Expanded(child: _buildDropDownTailles()),
              ],
            ),
            Text(
              'Sauce sélectionnées',
              style: PizzeriaStyle.headerTextStyle,
            ),
            _buildDropDownSauces(),
            TotalWidget(widget._pizza.total),
            BuyButtonWidget(widget._pizza, widget._cart)
          ],
        ));
  }

  _buildDropDownPates() {
    return DropdownButton(
        isExpanded: true,
        value: Pizza.pates[widget._pizza.pate],
        items: _buildDropDownItem(Pizza.pates),
        onChanged: (item) {
          setState(() {
            widget._pizza.pate = item!.value;
          });
        });
  }

  _buildDropDownSauces() {
    return DropdownButton(
        isExpanded: true,
        value: Pizza.sauces[widget._pizza.sauce],
        items: _buildDropDownItem(Pizza.sauces),
        onChanged: (item) {
          setState(() {
            widget._pizza.sauce = item!.value;
          });
        });
  }

  _buildDropDownTailles() {
    return DropdownButton(
        isExpanded: true,
        value: Pizza.tailles[widget._pizza.taille],
        items: _buildDropDownItem(Pizza.tailles),
        onChanged: (item) {
          setState(() {
            widget._pizza.taille = item!.value;
          });
        });
  }

  _buildDropDownItem(List<OptionItem> list) {
    return Iterable.generate(
      list.length,
      (i) => DropdownMenuItem(
        value: list[i],
        child: Text(list[i].name),
      ),
    ).toList();
  }

  Widget _buildBuyButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.red.shade800)),
            onPressed: () => print("Commander une pizza"),
            child: const Row(
              children: [
                Icon(Icons.shopping_cart),
                SizedBox(width: 5),
                Text("Commander")
              ],
            ))
      ],
    );
  }
}
