import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tv_shows.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvShowsNotifier extends ChangeNotifier {
  var _watchlistTvShows = <Tv>[];
  List<Tv> get watchlistTvShows => _watchlistTvShows;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvShowsNotifier({required this.getWatchlistTvShows});

  final GetWatchlistTvShows getWatchlistTvShows;

  Future<void> fetchWatchlistTvShows() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvShows.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }
}
