
import 'package:flutter/material.dart';

class AboutFilm extends StatelessWidget {
  
  late String fullname, about, countris, types, poster;

  AboutFilm({super.key, required this.fullname, required this.about, required this.countris, required this.types, required this.poster});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height/24;
    final w = MediaQuery.sizeOf(context).width-40;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 6*h, 
            minWidth: 0,
            maxHeight: 12*h,
            maxWidth: w
          ),
          child: Image.asset(poster),
        ),
        ConstrainedBox(constraints: 
          BoxConstraints(
            minHeight: 0, 
            minWidth: 0,
            maxHeight: 4*h,
            maxWidth: w
          ),
          child: Column(children: [
            Text(fullname),
            Text(about),
            Text(types),
            Text(countris)
          ],),
        )

    ],);
  }
  
}