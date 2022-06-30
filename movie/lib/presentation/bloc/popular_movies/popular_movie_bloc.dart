import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _getPopularMovies;

  PopularMovieBloc(this._getPopularMovies) : super(PopularMovieEmpty()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(PopularMovieError(failure.message));
        },
        (data) {
          emit(PopularMovieHasData(data));
        },
      );
    });
  }
}