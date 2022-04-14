import 'package:flutter/material.dart';
import 'package:plantholic/Model/plantModels.dart';
import './components/body.dart';

class DetailsScreen extends StatelessWidget {
  final PlantModel product;

  DetailsScreen({@required this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(product: product),
    );
  }
}
