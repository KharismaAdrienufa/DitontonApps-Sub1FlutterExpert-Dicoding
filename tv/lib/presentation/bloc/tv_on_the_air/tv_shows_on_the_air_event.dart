part of 'tv_shows_on_the_air_bloc.dart';

abstract class TvShowsOnTheAirEvent extends Equatable {
  const TvShowsOnTheAirEvent();

  @override
  List<Object?> get props => [];
}

class FetchTvShowsOnTheAir extends TvShowsOnTheAirEvent {}
