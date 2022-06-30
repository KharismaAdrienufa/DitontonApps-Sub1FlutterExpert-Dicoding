part of 'tv_shows_recommendations_bloc.dart';

abstract class TvShowsRecommendationsState extends Equatable {
  const TvShowsRecommendationsState();

  @override
  List<Object> get props => [];
}

class TvShowsRecommendationsEmpty extends TvShowsRecommendationsState {}

class TvShowsRecommendationsLoading extends TvShowsRecommendationsState {}

class TvShowsRecommendationsHasData extends TvShowsRecommendationsState {
  final List<Tv> result;

  const TvShowsRecommendationsHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvShowsRecommendationsError extends TvShowsRecommendationsState {
  final String message;

  const TvShowsRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}
