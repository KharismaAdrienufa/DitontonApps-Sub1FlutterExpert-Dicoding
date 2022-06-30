part of 'tv_shows_recommendations_bloc.dart';

abstract class TvShowsRecommendationsEvent extends Equatable {
  const TvShowsRecommendationsEvent();

  @override
  List<Object> get props => [];
}

class FetchTvShowsRecommendations extends TvShowsRecommendationsEvent {
  final int id;

  const FetchTvShowsRecommendations(this.id);

  @override
  List<Object> get props => [id];
}
