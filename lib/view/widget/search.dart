import 'package:course_work/main.dart';
import 'package:course_work/model/entity/film.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/favorite_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/popular_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/search_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/about_film_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/state/search_state.dart';
import 'package:course_work/view/widget/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatelessWidget {
  final TextEditingController text;

  const Search(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 11,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (!scrollInfo.metrics.atEdge) {
                  return false; // Если не достигли края
                }
                if (scrollInfo.metrics.pixels == 0) {
                  return false; // Если на верхней части
                }
                print("search");
                context.read<SearchCubit>().onTextChanged(text.text);
                return true; //
              },
              child: ListView.builder(
                itemCount: context.read<SearchCubit>().state.items.length,
                itemBuilder: (BuildContext context, int index) {
                  func(Film f) async {
                    var ok = await context
                        .read<SearchCubit>()
                        .hasElementInStorage(
                          f.filmId,
                        );
                    if (ok) {
                      context.read<SearchCubit>().removeFilmFromFav(
                        f.filmId,
                      );
                    } else {
                      context.read<SearchCubit>().addFilmsToFavUc(
                        f,
                      );
                    }
                    context.read<PopularCubit>().updateFilmsStatus();
                    context.read<FavoriteCubit>().updateFilmsStatus();
                    context.read<SearchCubit>().updateFilmsStatus();
                  }

                  return GestureDetector(
                    onTap: () {
                      context.read<AboutFilmCubit>().setFilmState(
                        context.read<SearchCubit>().state.items[index],
                      );
                      Navigator.pushNamed(context, Routes.aboutFilm);
                    },
                    child: PosterCart(
                      context.read<SearchCubit>().state.items[index],
                      func,
                    ),
                  );
                },
              ),
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
