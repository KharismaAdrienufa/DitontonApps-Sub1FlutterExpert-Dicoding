part of 'tv_shows_detail_bloc.dart';

abstract class TvShowsDetailEvent extends Equatable {
  const TvShowsDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchTvShowsDetail extends TvShowsDetailEvent {
  final int id;

  const FetchTvShowsDetail(this.id);

  @override
  List<Object> get props => [id];
}
