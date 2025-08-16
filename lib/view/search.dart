import 'package:course_work/bloc/search_bloc.dart';
import 'package:course_work/cubit/about_film_cubit.dart';
import 'package:course_work/data/repository/api/lenta_api_repository.dart';
import 'package:course_work/state/search_state.dart';
import 'package:course_work/view/about_film.dart';
import 'package:course_work/view/widget/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatelessWidget {

  TextEditingController text;

  Search(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.00),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 11,
            child: BlocBuilder<SearchBloc, SearchState>( builder: (context, state)  {
              if (state is SearchStateSucsess) {
                var currState = state;
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!scrollInfo.metrics.atEdge) {
                      return false; // Если не достигли края
                    }
                    if (scrollInfo.metrics.pixels == 0) {
                      return false; // Если на верхней части
                    }
                    print("search");
                    context.read<SearchBloc>().searchApiRepository.fetchPageByKeyword(text.text);
                    return true; //
                  },
                  child: ListView.builder(
                    itemCount: currState.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          context.read<AboutFilmCubit>().setFilmState(currState.items[index]);
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return SafeArea(
                                  child: Scaffold(
                                    appBar: AppBar(),
                                    body: AboutFilm(),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        child: PosterCart(
                          controller.buttonPressed,
                          controller.search.value.films[index],
                          controller.storage.value.hasElement(
                            controller.search.value.films[index].value.filmId,
                          ),
                        ),
                      );
                    },
                  ),
                );
                } else {
                  return Text("not fount");
                }
            }),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
