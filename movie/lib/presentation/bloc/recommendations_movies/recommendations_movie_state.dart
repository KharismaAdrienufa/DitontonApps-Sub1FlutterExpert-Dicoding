part of 'recommendations_movie_bloc.dart';

abstract class RecommendationsMovieState extends Equatable {
  const RecommendationsMovieState();

  @override
  List<Object> get props => [];
}

class RecommendationsMovieEmpty extends RecommendationsMovieState {}

class RecommendationsMovieLoading extends RecommendationsMovieState {}

class RecommendationsMovieHasData extends RecommendationsMovieState {
  final List<Movie> result;

  const RecommendationsMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class RecommendationsMovieError extends RecommendationsMovieState {
  final String message;

  const RecommendationsMovieError(this.message);

  @override
  List<Object> get props => [message];
}
