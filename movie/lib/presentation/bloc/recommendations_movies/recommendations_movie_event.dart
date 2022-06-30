part of 'recommendations_movie_bloc.dart';

abstract class RecommendationsMovieEvent extends Equatable {
  const RecommendationsMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchRecommendationsMovies extends RecommendationsMovieEvent {
  final int id;

  const FetchRecommendationsMovies(this.id);

  @override
  List<Object> get props => [id];
}
