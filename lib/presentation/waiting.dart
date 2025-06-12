
import 'package:flutter/material.dart';

class Waiting extends StatelessWidget {
  
  late Animation<double> animation;

  Waiting({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(image: AssetImage("assets/animation/cicle.gif"),),
    );
  }  
}