import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_on_the_air.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  var _tvOnTheAir = <Tv>[];
  List<Tv> get tvOnTheAir => _tvOnTheAir;

  RequestState _tvOnTheAirState = RequestState.Empty;
  RequestState get tvOnTheAirState => _tvOnTheAirState;

  var _popularTvShows = <Tv>[];
  List<Tv> get popularTvShows => _popularTvShows;

  RequestState _popularTvShowsState = RequestState.Empty;
  RequestState get popularTvShowsState => _popularTvShowsState;

  var _topRatedTvShows = <Tv>[];
  List<Tv> get topRatedTvShows => _topRatedTvShows;

  RequestState _topRatedTvShowsState = RequestState.Empty;
  RequestState get topRatedTvShowsState => _topRatedTvShowsState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getTvOnTheAir,
    required this.getPopularTvShows,
    required this.getTopRatedTvShows,
  });

  final GetTvOnTheAir getTvOnTheAir;
  final GetPopularTvShows getPopularTvShows;
  final GetTopRatedTvShows getTopRatedTvShows;

  Future<void> fetchTvOnTheAir() async {
    _tvOnTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await getTvOnTheAir.execute();
    result.fold(
      (failure) {
        _tvOnTheAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _tvOnTheAirState = RequestState.Loaded;
        _tvOnTheAir = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    _popularTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();
    result.fold(
      (failure) {
        _popularTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _popularTvShowsState = RequestState.Loaded;
        _popularTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedTvShowsState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShows.execute();
    result.fold(
      (failure) {
        _topRatedTvShowsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _topRatedTvShowsState = RequestState.Loaded;
        _topRatedTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }
}
