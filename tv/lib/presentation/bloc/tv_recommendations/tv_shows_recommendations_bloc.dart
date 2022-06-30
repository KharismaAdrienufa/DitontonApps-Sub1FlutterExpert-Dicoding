import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_shows_recommendations_event.dart';
part 'tv_shows_recommendations_state.dart';

class TvShowsRecommendationsBloc extends Bloc<TvShowsRecommendationsEvent, TvShowsRecommendationsState> {
  final GetTvRecommendations _getTvRecommendations;

  TvShowsRecommendationsBloc(this._getTvRecommendations) : super(TvShowsRecommendationsEmpty()) {
    on<FetchTvShowsRecommendations>((event, emit) async {
      final id = event.id;

      emit(TvShowsRecommendationsLoading());
      final result = await _getTvRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(TvShowsRecommendationsError(failure.message));
        },
        (data) {
          emit(TvShowsRecommendationsHasData(data));
        },
      );
    });
  }
}
