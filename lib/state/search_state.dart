
import 'package:equatable/equatable.dart';
import 'package:course_work/data/model/film.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

final class SearchStateLoading extends SearchState {

}

final class SearchStateEmpty extends SearchState {}

final class SearchStateSucsess extends SearchState {
  const SearchStateSucsess(this.items);

  final List<Film> items;

  @override
  List<Object?> get props => [items];
  
  @override
  String toString() => 'SearchStateSuccess { items: ${items.length} }';
}

final class SearchStateError extends SearchState {
  const SearchStateError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

