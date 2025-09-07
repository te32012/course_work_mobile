import 'package:course_work/cubit/about_film_cubit.dart';
import 'package:course_work/cubit/global_cubit.dart';
import 'package:course_work/cubit/lenta_cubit.dart';
import 'package:course_work/data/repository/api/lenta_api_repository.dart';
import 'package:course_work/state/global_state.dart';
import 'package:course_work/state/lenta_state.dart';
import 'package:course_work/view/about_film.dart';
import 'package:course_work/view/application.dart';
import 'package:course_work/view/widget/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Lenta extends StatelessWidget {
  const Lenta({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: BlocBuilder<LentaCubit, LentaState>(
              builder: (context, state) {
                if (state is LentaWithFilmsState) {
                  var currentState = state;
                  return NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!scrollInfo.metrics.atEdge) {
                        return false; // Если не достигли края
                      }
                      if (scrollInfo.metrics.pixels == 0) {
                        return false; // Если на верхней части
                      }
                      context
                          .read<LentaCubit>()
                          .nextFilm(); // Загружаем новые данные
                      return true; //
                    },
                    child: ListView.builder(
                      itemCount: currentState.isFaivorite
                          ? currentState
                                .favoriteFilmRepository
                                .storageList
                                .length
                          : currentState.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        var f = currentState.isFaivorite
                            ? currentState
                                  .favoriteFilmRepository
                                  .storageList[index]
                                  .film
                            : currentState.items[index];
                        return GestureDetector(
                          onTap: () {
                            context.read<AboutFilmCubit>().setFilmState(f);
                            Navigator.pushNamed(context, Routes.about_film);
                          },
                          child: PosterCart(f),
                        );
                      },
                    ),
                  );
                } else {
                  return Text("not fount");
                }
              },
            ),
          ),
          BlocBuilder<LentaCubit, LentaState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.tonal(
                    onPressed: () {
                      context.read<LentaCubit>().changeFaivoriteSataus(false);
                    },
                    child: Text("Популярные", style: TextStyle(fontSize: 14)),
                  ),
                  FilledButton(
                    onPressed: () {
                      context.read<LentaCubit>().changeFaivoriteSataus(true);
                    },
                    child: Text("Избранные", style: TextStyle(fontSize: 14)),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
