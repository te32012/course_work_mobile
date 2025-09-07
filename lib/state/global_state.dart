

import 'package:course_work/data/model/film.dart';
import 'package:equatable/equatable.dart';

sealed class GlobalState extends Equatable {
  final Map<int, Film> items;

  const GlobalState(this.items);

  @override
  List<Object?> get props => [];
}

final class GlobalEmptyState extends GlobalState {
  const GlobalEmptyState(super.items);
}
