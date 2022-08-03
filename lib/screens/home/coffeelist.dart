import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeeapp/screens/home/coffeetile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffeeapp/models/coffee.dart';

class CoffeeList extends StatefulWidget {
  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  @override
  Widget build(BuildContext context) {
    // final coffeee = Provider.of<QuerySnapshot>(context);
    //print(brews.documents);
    // for (var doc in coffeee.docs) {
    //   print(doc.data);
    // }
    final coffee = Provider.of<List<Coffee>>(context) ?? [];
    // coffee.forEach((brew) {
    //   print(brew.name);
    //   print(brew.sugars);
    // });
    // return Container();
    return ListView.builder(
      itemCount: coffee.length,
      itemBuilder: (context, index) {
        return CoffeeTile(coffee: coffee[index]);
      },
    );
  }
}
