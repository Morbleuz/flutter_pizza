import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/class/cart.dart';
import 'package:pizzeria/class/pizza.dart';
import 'package:pizzeria/class/pizza_data.dart';
import 'package:pizzeria/services/pizzeria_service.dart';
import 'package:pizzeria/ui/pizza_details.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';

class PizzaList extends StatefulWidget {
  final Cart _cart;
  const PizzaList(this._cart, {super.key});

  @override
  State<PizzaList> createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {
  late Future<List<Pizza>> _pizzas;

  PizzeriaService _service = PizzeriaService();

  @override
  void initState() {
    _pizzas = _service.fetchPizzas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget('Nos pizzas', widget._cart),
        body: FutureBuilder<List<Pizza>>(
          future: _pizzas,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildListView(snapshot.data!);
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                    'Impossible de récupérer les données : ${snapshot.error}',
                    style: PizzeriaStyle.errorTextStyle),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  _buildListView(List<Pizza> pizzas) {
    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      itemCount: pizzas.length,
      itemBuilder: (context, index) {
        return _buildRow(pizzas[index], context);
      },
    );
  }

  Widget _buildPizzaDetail(Pizza pizza) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ListTile(
          title: Text(pizza.title),
          subtitle: Text(pizza.garniture),
          leading: const Icon(Icons.local_pizza)),
      Image.network('${pizza.image}',
          height: 120,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth),
      Container(
          padding: const EdgeInsets.all(4.0), child: Text(pizza.garniture)),
    ]);
  }

  Widget _buildRow(Pizza pizza, context) {
    return Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10.0), top: Radius.circular(2.0))),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PizzaDetails(pizza, widget._cart),
                  ));
            },
            child: _buildPizzaDetail(pizza),
          ),
          BuyButtonWidget(pizza, widget._cart)
        ]));
  }
}
