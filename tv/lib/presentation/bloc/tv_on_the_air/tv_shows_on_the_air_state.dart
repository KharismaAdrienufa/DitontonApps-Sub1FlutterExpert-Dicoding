part of 'tv_shows_on_the_air_bloc.dart';

abstract class TvShowsOnTheAirState extends Equatable {
  const TvShowsOnTheAirState();

  @override
  List<Object?> get props => [];
}

class TvShowsOnTheAirEmpty extends TvShowsOnTheAirState {}

class TvShowsOnTheAirLoading extends TvShowsOnTheAirState {}

class TvShowsOnTheAirHasData extends TvShowsOnTheAirState {
  final List<Tv> result;

  const TvShowsOnTheAirHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class TvShowsOnTheAirError extends TvShowsOnTheAirState {
  final String message;

  const TvShowsOnTheAirError(this.message);

  @override
  List<Object?> get props => [message];
}
