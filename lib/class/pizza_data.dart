import 'package:pizzeria/class/pizza.dart';

class PizzaData{
  List<Pizza> buildList() {
    return [
      Pizza(1,'Barbecue','La garniture', 'pizza-bbq.jpg',8),
      Pizza(2,'Hawai','La garniture', 'pizza-hawai.jpg',8),
      Pizza(3,'Epinards','La garniture', 'pizza-spinach.jpg',8),
      Pizza(4,'Végétarienne','La garniture', 'pizza-vegetable.jpg',8),
    ];
  }
}