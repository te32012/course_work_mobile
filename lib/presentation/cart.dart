import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
 
  final  String name, type, year, poster ;
  final  bool isFavorite;
  Cart({super.key, required this.name, required this.type, required this.year, required this.poster, required this.isFavorite});


  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final w = MediaQuery.sizeOf(context).width;

    return Center(
      child: Padding(padding: EdgeInsetsGeometry.all(40),
        child: Row(
          children: [
            ConstrainedBox(constraints: BoxConstraints.loose(Size(w / 4, h)), child: Image.file(poster)),
            Padding(padding: EdgeInsetsGeometry.all(5),
              child: ConstrainedBox(constraints: BoxConstraints.loose(Size((w / 4)*3, h)), 
                child: Column (
                  children: [
                    Row(
                      children: [
                        Text(name),
                        isFavorite ? Icon(Icons.favorite) : Text("")
                      ],
                    ),
                    Text("$type ($year)")
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}