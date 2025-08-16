import 'package:bloc/bloc.dart';
import 'package:course_work/data/repository/api/search_api_repository.dart';
import 'package:course_work/event/search_event.dart';
import 'package:course_work/state/search_state.dart';
import 'package:stream_transform/stream_transform.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.searchApiRepository) : super(SearchStateEmpty()) {
    on<TextChanged>(_onTextChanged, transformer: debounce(_duration));
  }

  final SearchApiRepository searchApiRepository;

  Future<void> _onTextChanged(
    TextChanged event,
    Emitter<SearchState> emit,
  ) async {
    final searchTerm = event.text;
    if (searchTerm.isEmpty) return emit(SearchStateEmpty());

    emit(SearchStateLoading());

    try {
      final result = await searchApiRepository.fetchPageByKeyword(searchTerm);
      emit(SearchStateSucsess(result));
    } catch (error) {
      emit(const SearchStateError("smt error"));
    }
  }


}
