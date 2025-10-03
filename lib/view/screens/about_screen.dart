import 'package:course_work/viewModel/cubitAndBloc/cubit/about_film_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/state/about_film_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
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
                      child: BlocBuilder<AboutFilmCubit, AboutFilmState>(
                        builder: (context, state) {
                          return switch (state) {
                            AboutFilmEmptyState() => Image.asset(
                              "assets/images/not_found.png",
                            ),
                            AboutFilmWithFilmState() => Image.memory(
                              state.film.posterData,
                            ),
                          };
                        },
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: BlocBuilder<AboutFilmCubit, AboutFilmState>(
                            builder: (context, state) {
                              return switch (state) {
                                AboutFilmEmptyState() => const Text(
                                  "not found",
                                ),
                                AboutFilmWithFilmState() => Text(
                                  state.film.nameRu,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              };
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: BlocBuilder<AboutFilmCubit, AboutFilmState>(
                            builder: (context, state) {
                              return switch (state) {
                                AboutFilmEmptyState() => const Text(
                                  "not found",
                                ),
                                AboutFilmWithFilmState() => Text(
                                  state.film.description,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              };
                            },
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
                              child:
                                  BlocBuilder<AboutFilmCubit, AboutFilmState>(
                                    builder: (context, state) {
                                      return switch (state) {
                                        AboutFilmEmptyState() => const Text(
                                          "not found",
                                        ),
                                        AboutFilmWithFilmState() => Text(
                                          state.film.genres.isNotEmpty
                                              ? state.film.genres
                                                    .map((e) => e.genre)
                                                    .take(2)
                                                    .reduce(
                                                      (e1, e2) => "$e1, $e2",
                                                    )
                                              : "жанр не указан",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      };
                                    },
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
                              child:
                                  BlocBuilder<AboutFilmCubit, AboutFilmState>(
                                    builder: (context, state) {
                                      return switch (state) {
                                        AboutFilmEmptyState() => const Text(
                                          "not found",
                                        ),
                                        AboutFilmWithFilmState() => Text(
                                          state.film.countries.isNotEmpty
                                              ? state.film.countries
                                                    .map((e) {
                                                      return e
                                                              .country
                                                              .isNotEmpty
                                                          ? e.country
                                                          : '';
                                                    })
                                                    .take(2)
                                                    .reduce(
                                                      (e1, e2) => "$e1, $e2",
                                                    )
                                              : "страна не указана",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      };
                                    },
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
        ),
      ),
    );
  }
}
