import 'package:course_work/cubit/global_cubit.dart';
import 'package:course_work/data/model/film.dart';
import 'package:course_work/state/global_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PosterCart extends StatelessWidget {
  final Film film;
  // final Future<> Function(Film film, bool isFaivorite) buttonPressed;
  const PosterCart(this.film, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: 160,
          width: 80,
          child: BlocBuilder<GlobalCubit, GlobalState>(
            builder: (BuildContext context, GlobalState state) {
              if (film.posterData.isNotEmpty) {
                return Image.memory(film.posterData);
              } else {
                return Image.asset("assets/images/not_found.png");
              }
            },
          ),
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
                      film.nameRu,
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
                    "${film.genres.isNotEmpty ? film.genres.map((e) => e.genre).take(2).reduce((e1, e2) => "$e1, $e2") : "жанр не указан"} (${film.year ?? "без года"})",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<GlobalCubit, GlobalState>(
          builder: (BuildContext context, GlobalState state) {
            return GestureDetector(
              onTap: () {
                if (state.items.containsKey(film.filmId)) {
                  context.read<GlobalCubit>().add(<int, Film>{film.filmId: film});
                } else {
                  context.read<GlobalCubit>().remove(<int, Film>{film.filmId: film});
                }
              },
              child: (state.items.containsKey(film.filmId))
                  ? Icon(Icons.favorite, color: Color.fromRGBO(8, 21, 198, 1))
                  : Icon(
                      Icons.favorite_border,
                      color: Color.fromRGBO(8, 21, 198, 1),
                    ),
            );
          },
        ),
      ],
    );
  }
}
