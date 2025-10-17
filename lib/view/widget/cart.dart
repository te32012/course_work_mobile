import 'package:course_work/model/entity/film.dart';
import 'package:course_work/view/styles/grapicStyles.dart';
import 'package:course_work/view/styles/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PosterCart extends StatelessWidget {
  final Film film;
  final Function onTap;

  const PosterCart(this.film, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 32), // Добавляем ограничения по ширине
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: 160,
            width: 80,
            child: film.posterData.isNotEmpty
                ? Image.memory(film.posterData, fit: BoxFit.cover)
                : Image.asset("assets/images/not_found.png", fit: BoxFit.cover),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 8), // Добавляем отступ справа
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    film.nameRu,
                    style: TextStyle(
                      fontSize: StyleTextNameInCart.fontSize,
                      fontWeight: StyleTextNameInCart.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2, // Увеличиваем до 2 строк для длинных названий
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${film.genres.isNotEmpty ? film.genres.map((e) => e.genre).take(2).reduce((e1, e2) => "$e1, $e2") : "жанр не указан"} (${film.year ?? "без года"})",
                    style: TextStyle(fontSize: StyleMainTextInCart.fontSize),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 24, // Фиксируем ширину для иконки
            child: GestureDetector(
              onTap: () {
                onTap.call();
              },
              child: (film.isFaivorite)
                  ? Icon(Icons.favorite, color: Grapicstyles.favorite)
                  : Icon(
                      Icons.favorite_border,
                      color: Grapicstyles.favorite,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}