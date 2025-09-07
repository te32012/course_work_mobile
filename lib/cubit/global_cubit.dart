

import 'package:course_work/data/model/film.dart';
import 'package:course_work/state/global_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalEmptyState({}));
  void update() {
    emit(GlobalEmptyState({}));
  }
  void add(Map<int, Film> items) {
    Map<int, Film> storage = {};
    storage.addAll(state.items);
    storage.addAll(items);
    emit(GlobalEmptyState(storage));
  }
  void remove(Map<int, Film> items) {
    Map<int, Film> storage = {};
    storage.addAll(state.items);
    storage.removeWhere((id, film) => items.containsKey(id));
    emit(GlobalEmptyState(storage));
  }

}