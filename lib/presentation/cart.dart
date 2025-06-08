import 'package:flutter/material.dart';

class PosterCart extends StatelessWidget {
 
  final  String name, type, year, poster ;
  final  bool isFavorite;
  const PosterCart({super.key, required this.name, required this.type, required this.year, required this.poster, required this.isFavorite});


  @override
  Widget build(BuildContext context) {
    final h = (MediaQuery.sizeOf(context).height) / 12;
    final w = (MediaQuery.sizeOf(context).width);

    return Center(
      child: Row(
        children: [
          ConstrainedBox(
            constraints: 
              BoxConstraints(
                minHeight: 0, 
                minWidth: 0,
                maxHeight: h,
                maxWidth: w
              ), 
            child: Image.asset(poster)
          ),
          ConstrainedBox(
              constraints: 
                BoxConstraints(
                  minHeight: 0, 
                  minWidth: 0,
                  maxHeight: h,
                  maxWidth: w/2
                ),  
              child: Column (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(name,
                        style: TextStyle(
                          fontSize: 14
                        ),
                      ),
                      isFavorite ? Icon(Icons.favorite): Text(""),
                    ],
                  ),
                  Row (
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: 
                    [
                      Text("$type ($year)",
                        style: TextStyle(
                          fontSize: 14
                        ),
                      )
                  ],)
                ]
              ),
            ),
        ],
      ),
    );
  }
}