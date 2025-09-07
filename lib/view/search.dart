import 'package:course_work/bloc/search_bloc.dart';
import 'package:course_work/cubit/about_film_cubit.dart';
import 'package:course_work/event/search_event.dart';
import 'package:course_work/state/search_state.dart';
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
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
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
                      context.read<SearchBloc>().add(
                        TextChanged(text: text.text),
                      );
                      return true; //
                    },
                    child: ListView.builder(
                      itemCount: currState.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            context.read<AboutFilmCubit>().setFilmState(
                              currState.items[index],
                            );
                            Navigator.pushNamed(context, Routes.about_film);
                          },
                          child: PosterCart(currState.items[index]),
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
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
