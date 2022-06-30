import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;
  final GetWatchListStatus _getWatchListStatus;

  WatchlistMovieBloc(this._getWatchlistMovies, this._saveWatchlist,
      this._removeWatchlist, this._getWatchListStatus)
      : super(WatchlistMovieEmpty()) {
    on<FetchWatchlistMovies>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await _getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(WatchlistMovieError(failure.message));
        },
        (data) {
          emit(WatchlistMovieHasData(data));
        },
      );
    });

    on<AddWatchListMovie>(
      (event, emit) async {
        final movieDetail = event.movieDetail;
        final result = await _saveWatchlist.execute(movieDetail);

        result.fold(
          (failure) {
            emit(WatchlistMessageFailure(failure.message));
          },
          (successMessage) {
            emit(const WatchlistMessageSuccess('Added From Watchlist'));
          },
        );
        add(LoadWatchlistStatus(movieDetail.id));
      },
    );

    on<RemoveFromWatchListMovie>(
      (event, emit) async {
        final movieDetail = event.movieDetail;
        final result = await _removeWatchlist.execute(movieDetail);

        result.fold(
          (failure) {
            emit(WatchlistMessageFailure(failure.message));
          },
          (successMessage) {
            emit(const WatchlistMessageSuccess('Removed From Watchlist'));
          },
        );
        add(LoadWatchlistStatus(movieDetail.id));
      },
    );

    on<LoadWatchlistStatus>(
      (event, emit) async {
        final id = event.id;
        final result = await _getWatchListStatus.execute(id);

        emit(WatchlistStatus(result));
      },
    );
  }
}
