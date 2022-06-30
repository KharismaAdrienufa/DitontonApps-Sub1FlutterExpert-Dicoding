import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'recommendations_movie_event.dart';
part 'recommendations_movie_state.dart';

class RecommendationsMovieBloc
    extends Bloc<RecommendationsMovieEvent, RecommendationsMovieState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendationsMovieBloc(this._getMovieRecommendations)
      : super(RecommendationsMovieEmpty()) {
    on<FetchRecommendationsMovies>((event, emit) async {
      final id = event.id;

      emit(RecommendationsMovieLoading());
      final result = await _getMovieRecommendations.execute(id);

      result.fold(
        (failure) {
          emit(RecommendationsMovieError(failure.message));
        },
        (data) {
          emit(RecommendationsMovieHasData(data));
        },
      );
    });
  }
}
