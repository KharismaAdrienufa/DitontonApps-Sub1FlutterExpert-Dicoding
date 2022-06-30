import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMovieBloc(this._getNowPlayingMovies)
      : super(NowPlayingMovieEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await _getNowPlayingMovies.execute();

      result.fold((failure) {
        emit(NowPlayingMovieError(failure.message));
      }, (data) {
        emit(NowPlayingMovieHasData(data));
      });
    });
  }
}
