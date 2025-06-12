import 'package:flutter/material.dart';

class PosterCart extends StatelessWidget {
  final String name, type, year, poster;
  final bool isFavorite;
  const PosterCart({
    super.key,
    required this.name,
    required this.type,
    required this.year,
    required this.poster,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(flex: 2, child: Container(padding:  EdgeInsets.all(10), height: 160, width: 80, child: Expanded(child: Image.asset(poster)))),
        Flexible(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("$type ($year)", style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        Spacer(flex: 1),
        Icon(Icons.favorite)
      ],
    );
  }
}
