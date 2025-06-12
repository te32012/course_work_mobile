import 'package:flutter/material.dart';

class AboutFilm extends StatelessWidget {
  late String fullname, about, countris, types, poster;

  AboutFilm({
    super.key,
    required this.fullname,
    required this.about,
    required this.countris,
    required this.types,
    required this.poster,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Flexible(
          flex: 4,
          child: Padding(
            padding: EdgeInsetsGeometry.all(20),
            child: Image.asset(poster),
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Text(
                  fullname,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Text(about, softWrap: true, overflow: TextOverflow.clip),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Text(
                      "Жанры:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Text(types, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: Text(
                      "Страны:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: Text(countris, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
