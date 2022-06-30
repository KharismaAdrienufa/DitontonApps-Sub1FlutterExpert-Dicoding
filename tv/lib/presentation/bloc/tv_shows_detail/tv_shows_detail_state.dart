part of 'tv_shows_detail_bloc.dart';

abstract class TvShowsDetailState extends Equatable {
  const TvShowsDetailState();

  @override
  List<Object> get props => [];
}

class TvShowsDetailEmpty extends TvShowsDetailState {}

class TvShowsDetailLoading extends TvShowsDetailState {}

class TvShowsDetailHasData extends TvShowsDetailState {
  final TvDetail result;

  const TvShowsDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvShowsDetailError extends TvShowsDetailState {
  final String message;

  const TvShowsDetailError(this.message);

  @override
  List<Object> get props => [message];
}
