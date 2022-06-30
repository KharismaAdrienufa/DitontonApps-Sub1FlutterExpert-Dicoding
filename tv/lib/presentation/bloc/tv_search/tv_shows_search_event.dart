part of 'tv_shows_search_bloc.dart';

abstract class TvShowsSearchEvent extends Equatable {
  const TvShowsSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends TvShowsSearchEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
