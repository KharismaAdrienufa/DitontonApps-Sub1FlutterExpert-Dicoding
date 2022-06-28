import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tv_shows.dart';
import 'package:flutter/foundation.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTvShows searchTvShows;

  TvSearchNotifier({required this.searchTvShows});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _searchResult = [];
  List<Tv> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvShows.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
