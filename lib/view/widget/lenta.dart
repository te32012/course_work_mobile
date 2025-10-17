import 'package:course_work/main.dart';
import 'package:course_work/view/styles/textStyles.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/about_film_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/favorite_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/popular_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/search_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/state/popular_state.dart';
import 'package:course_work/view/widget/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Lenta extends StatelessWidget {
  const Lenta(this.type_lenta, {super.key});

  // 1 - популярные, 2 - фавориты
  final int type_lenta;

  void onTapPopular() {}

  @override
  Widget build(BuildContext context) {
    switch (type_lenta) {
      case 1:
        {
          return Container(
            padding: EdgeInsets.all(15.00),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!scrollInfo.metrics.atEdge) {
                        return false; // Если не достигли края
                      }
                      if (scrollInfo.metrics.pixels == 0) {
                        return false; // Если на верхней части
                      }
                      context.read<PopularCubit>().nextFilm();
                      return true; //
                    },
                    child: ListView.builder(
                      itemCount: context
                          .read<PopularCubit>()
                          .state
                          .items
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        var f = context.read<PopularCubit>().state.items[index];
                        func() async {
                          var ok = await context
                              .read<PopularCubit>()
                              .hasElementInStorage(f.filmId);
                          if (ok) {
                            context.read<PopularCubit>().removeFilmFromFav(f.filmId);
                          } else {
                            context.read<PopularCubit>().addFilmsToFavUc(f);
                          }
                          context.read<PopularCubit>().updateFilmsStatus();
                          context.read<FavoriteCubit>().updateFilmsStatus();
                          context.read<SearchCubit>().updateFilmsStatus();
                        }
                        return GestureDetector(
                          onTap: () {
                            context.read<AboutFilmCubit>().setFilmState(f);
                            Navigator.pushNamed(context, Routes.aboutFilm);
                          },
                          child: PosterCart(f, func),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton.tonal(
                      onPressed: () {},
                      child: Text("Популярные", style: TextStyle(fontSize: StyleButtonTextInLenta.fontSize)),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.favorite,
                        );
                      },
                      child: Text("Избранные", style: TextStyle(fontSize: StyleButtonTextInLenta.fontSize)),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      case 2:
        {
          return Container(
            padding: EdgeInsets.all(15.00),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!scrollInfo.metrics.atEdge) {
                        return false; // Если не достигли края
                      }
                      if (scrollInfo.metrics.pixels == 0) {
                        return false; // Если на верхней части
                      }
                      context.read<PopularCubit>().nextFilm();
                      return true; //
                    },
                    child: ListView.builder(
                      itemCount: context
                          .read<FavoriteCubit>()
                          .state
                          .items
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        var f = context
                            .read<FavoriteCubit>()
                            .state
                            .items[index];
                        func() async {
                          var ok = await context
                              .read<FavoriteCubit>()
                              .hasElementInStorage(f.filmId);
                          if (ok) {
                            context.read<FavoriteCubit>().removeFilmFromFav(f.filmId);
                          } else {
                            context.read<FavoriteCubit>().addFilmsToFavUc(f);
                          }
                          context.read<PopularCubit>().updateFilmsStatus();
                          context.read<FavoriteCubit>().updateFilmsStatus();
                          context.read<SearchCubit>().updateFilmsStatus();
                        }
                        return GestureDetector(
                          onTap: () {
                            context.read<AboutFilmCubit>().setFilmState(f);
                            Navigator.pushNamed(context, Routes.aboutFilm);
                          },
                          child: PosterCart(f, func),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton.tonal(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.popular);
                      },
                      child: Text("Популярные", style: TextStyle(fontSize: StyleButtonTextInLenta.fontSize)),
                    ),
                    FilledButton(
                      onPressed: () {},
                      child: Text("Избранные", style: TextStyle(fontSize: StyleButtonTextInLenta.fontSize)),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    }
    return Text("пусто");
  }
}
