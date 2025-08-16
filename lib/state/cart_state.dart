

import 'package:course_work/data/model/film.dart';
import 'package:equatable/equatable.dart';

sealed class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class CartEmptyState extends CartState {

}

final class CartWithFilmState extends CartState {

  final Film _film;
  CartWithFilmState(this._film);
  
  Film get film => _film;
  
  @override
  List<Object?> get props => [_film];
}