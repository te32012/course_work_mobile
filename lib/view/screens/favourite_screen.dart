import 'package:course_work/view/widget/cart.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/about_film_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/favorite_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/popular_cubit.dart';
import 'package:course_work/main.dart';
import 'package:course_work/viewModel/cubitAndBloc/state/favorite_state.dart';
import 'package:course_work/viewModel/cubitAndBloc/state/popular_state.dart';
import 'package:course_work/view/widget/lenta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoriteCubit>().init();
    return SafeArea(
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text(
                  "Избранные",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.findPage);
                  },
                  child: Icon(Icons.search),
                ),
              ],
            ),
          ),
          body: Lenta(2),
        ),
      ),
    );
  }
}
