import 'package:course_work/data/model/film.dart';
import 'package:flutter/material.dart';

class PosterCart extends StatelessWidget {
  final Film film;
  bool isFavoriteCart = false;
  final Function(Film film, bool isFaivorite) buttonPressed;
  PosterCart(this.buttonPressed, this.film, this.isFavoriteCart, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: 160,
          width: 80,
          child: Image.network(film.posterUrl!),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      film.nameRu != null ? film.nameRu! : 'без имени',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${film.genres != null ? film.genres!.map((e) => e.genre).take(2).reduce((e1, e2) => "$e1, $e2") : "жанр не указан"} (${film.year != null ? film.year! : 'без года'})",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            isFavoriteCart = !isFavoriteCart;
            buttonPressed(film, isFavoriteCart);
          },
          child: (isFavoriteCart)
              ? Icon(Icons.favorite, color: Color.fromRGBO(8, 21, 198, 1))
              : Icon(
                  Icons.favorite_border,
                  color: Color.fromRGBO(8, 21, 198, 1),
                ),
        ),
      ],
    );
  }
}
