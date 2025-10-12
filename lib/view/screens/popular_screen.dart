import 'package:course_work/main.dart';
import 'package:course_work/view/widget/lenta.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/about_film_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/cubit/popular_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/state/popular_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularScreen extends StatelessWidget {
  const PopularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<PopularCubit>().init();
    return SafeArea(
      child: BlocBuilder<PopularCubit, PopularState>(
        builder: (context, state) {
          print("re create");
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Text(
                    "Популярные",
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
            body: Lenta(1),
          );
        },
      ),
    );
  }
}
