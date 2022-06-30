part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieEmpty extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieHasData extends WatchlistMovieState {
  final List<Movie> result;

  const WatchlistMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  const WatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMessageSuccess extends WatchlistMovieState {
  final String message;

  const WatchlistMessageSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMessageFailure extends WatchlistMovieState {
  final String message;

  const WatchlistMessageFailure(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistStatus extends WatchlistMovieState {
  final bool isAddedToWatchlist;

  const WatchlistStatus(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
