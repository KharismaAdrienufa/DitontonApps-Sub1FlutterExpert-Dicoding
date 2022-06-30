part of 'tv_shows_search_bloc.dart';

abstract class TvShowsSearchState extends Equatable {
  const TvShowsSearchState();

  @override
  List<Object?> get props => [];
}

class TvShowsSearchEmpty extends TvShowsSearchState {}

class TvShowsSearchLoading extends TvShowsSearchState {}

class TvShowsSearchHasData extends TvShowsSearchState {
  final List<Tv> result;

  const TvShowsSearchHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class TvShowsSearchError extends TvShowsSearchState {
  final String message;

  const TvShowsSearchError(this.message);

  @override
  List<Object?> get props => [message];
}
