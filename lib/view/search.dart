import 'package:course_work/main.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/search_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/about_film_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/state/search_state.dart';
import 'package:course_work/view/application.dart';
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
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return NotificationListener<ScrollNotification>(
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
                    itemCount: state.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          context.read<AboutFilmCubit>().setFilmState(
                            state.items[index],
                          );
                          Navigator.pushNamed(context, Routes.aboutFilm);
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              height: 160,
                              width: 80,
                              child: BlocBuilder<SearchCubit, SearchState>(
                                builder:
                                    (BuildContext context, SearchState state) {
                                      if (state.items[index].posterData.isNotEmpty) {
                                        return Image.memory(state.items[index].posterData);
                                      } else {
                                        return Image.asset(
                                          "assets/images/not_found.png",
                                        );
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
                                          state.items[index].nameRu,
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
                                        "${state.items[index].genres.isNotEmpty ? state.items[index].genres.map((e) => e.genre).take(2).reduce((e1, e2) => "$e1, $e2") : "жанр не указан"} (${state.items[index].year ?? "без года"})",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            BlocBuilder<SearchCubit, SearchState>(
                              builder:
                                  (BuildContext context, SearchState state) {
                                    return GestureDetector(
                                      onTap: () {
                                            if (state.items[index].isFaivorite) {
                                              context.read<SearchCubit>().removeFilmFromFav(state.items[index].filmId);
                                            } else {
                                              context.read<SearchCubit>().addFilmsToFavUc(state.items[index]);
                                            }
                                      },
                                      child:
                                          (context.read<SearchCubit>().hasElementInStorage(state.items[index].filmId))
                                          ? Icon(
                                              Icons.favorite,
                                              color: Color.fromRGBO(
                                                8,
                                                21,
                                                198,
                                                1,
                                              ),
                                            )
                                          : Icon(
                                              Icons.favorite_border,
                                              color: Color.fromRGBO(
                                                8,
                                                21,
                                                198,
                                                1,
                                              ),
                                            ),
                                    );
                                  },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
