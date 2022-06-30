part of 'watchlist_tv_shows_bloc.dart';

abstract class WatchlistTvShowsEvent extends Equatable {
  const WatchlistTvShowsEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistTvShows extends WatchlistTvShowsEvent {}

class AddWatchListTv extends WatchlistTvShowsEvent {
  final TvDetail tvDetail;

  const AddWatchListTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveFromWatchListTv extends WatchlistTvShowsEvent {
  final TvDetail tvDetail;

  const RemoveFromWatchListTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class LoadWatchlistStatusTv extends WatchlistTvShowsEvent {
  final int id;

  const LoadWatchlistStatusTv(this.id);

  @override
  List<Object> get props => [id];
}
