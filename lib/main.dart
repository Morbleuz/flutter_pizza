import 'package:flutter/material.dart';
import 'package:pizzeria/class/cart.dart';
import 'package:pizzeria/class/menu.dart';
import 'package:pizzeria/ui/pizza_list.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizzeria',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pizzeria'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Cart _cart = Cart();
  final _menus = [
    Menu(1, 'Entrées', 'entree.png', Colors.green),
    Menu(2, 'Pizzas', 'pizza.png', Colors.redAccent),
    Menu(3, 'Desserts', 'dessert.png', Colors.brown),
    Menu(4, 'Boissons', 'boisson.png', Colors.lightBlue),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(widget.title, _cart),
        body: Center(
            child: ListView.builder(
                itemCount: _menus.length,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      switch (_menus[index].type) {
                        case 2:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PizzaList(_cart)),
                          );
                      }
                    },
                    child: _buildRow(_menus[index])),
                itemExtent: 180)));
  }

  _buildRow(Menu menu) {
    return Container(
        height: 180,
        decoration: BoxDecoration(
            color: menu.color,
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/menus/${menu.image}',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
                height: 50,
                child: Center(
                    child: Text(
                  menu.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      fontSize: 28),
                ))),
          ],
        ));
  }
}
