import 'package:course_work/viewModel/cubitAndBloc/cubit/search_cubit.dart';
import 'package:course_work/viewModel/cubitAndBloc/state/search_state.dart';
import 'package:course_work/view/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    return SafeArea(
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return TextField(
                  controller: textEditingController,
                  onChanged: (value) {
                    print(value);
                    context.read<SearchCubit>().onTextChanged(value);
                  },
                );
              },
            ),
          ),
          body: Search(textEditingController),
        ),
      ),
    );
  }
}
