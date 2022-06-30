import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv/tv.dart';

part 'tv_shows_search_event.dart';
part 'tv_shows_search_state.dart';

class TvShowsSearchBloc extends Bloc<TvShowsSearchEvent, TvShowsSearchState> {
  final SearchTvShows _tvSearch;

  TvShowsSearchBloc(this._tvSearch) : super(TvShowsSearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(TvShowsSearchLoading());
      final result = await _tvSearch.execute(query);

      result.fold(
        (failure) {
          emit(TvShowsSearchError(failure.message));
        },
        (data) {
          emit(TvShowsSearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
