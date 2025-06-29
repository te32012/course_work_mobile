import 'package:course_work/data/model/film.dart';
import 'package:flutter/material.dart';

class AboutFilm extends StatelessWidget {
  final Film film;

  const AboutFilm(this.film, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height + 100,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(20),
                  child: Image.network(film.posterUrl!),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Text(
                        film.nameRu != null ? film.nameRu! : 'без имени',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Text(
                        film.description != null
                            ? film.description!
                            : 'без описания',
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
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
                          child: Text(
                            film.genres != null
                                ? film.genres!
                                      .map((e) => e.genre)
                                      .take(2)
                                      .reduce((e1, e2) => "$e1, $e2")
                                : "жанр не указан",
                            overflow: TextOverflow.ellipsis,
                          ),
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
                          child: Text(
                            film.countries != null
                                ? film.countries!
                                      .map((e) {
                                        return e.country.isNotEmpty
                                            ? e.country
                                            : '';
                                      })
                                      .take(2)
                                      .reduce((e1, e2) => "$e1, $e2")
                                : "страна не указана",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
