part of 'watchlist_tv_shows_bloc.dart';

abstract class WatchlistTvShowsState extends Equatable {
  const WatchlistTvShowsState();

  @override
  List<Object> get props => [];
}

class WatchlistTvShowsEmpty extends WatchlistTvShowsState {}

class WatchlistTvShowsLoading extends WatchlistTvShowsState {}

class WatchlistTvShowsHasData extends WatchlistTvShowsState {
  final List<Tv> result;

  const WatchlistTvShowsHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistTvShowsError extends WatchlistTvShowsState {
  final String message;

  const WatchlistTvShowsError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvShowsMessageSuccess extends WatchlistTvShowsState {
  final String message;

  const WatchlistTvShowsMessageSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvShowsMessageFailure extends WatchlistTvShowsState {
  final String message;

  const WatchlistTvShowsMessageFailure(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvShowsStatus extends WatchlistTvShowsState {
  final bool isAddedToWatchlist;

  const WatchlistTvShowsStatus(this.isAddedToWatchlist);

  @override
  List<Object> get props => [isAddedToWatchlist];
}
