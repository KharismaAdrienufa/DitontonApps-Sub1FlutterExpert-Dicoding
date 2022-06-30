part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistMovies extends WatchlistMovieEvent {}

class AddWatchListMovie extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const AddWatchListMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveFromWatchListMovie extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const RemoveFromWatchListMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class LoadWatchlistStatus extends WatchlistMovieEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
