import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_shows_event.dart';
part 'watchlist_tv_shows_state.dart';

class WatchlistTvShowsBloc
    extends Bloc<WatchlistTvShowsEvent, WatchlistTvShowsState> {
  final GetWatchlistTvShows _getWatchlistTv;
  final SaveTvWatchlist _saveWatchlistTv;
  final RemoveTvWatchlist _removeWatchlistTv;
  final GetWatchlistTvStatus _getWatchListStatusTv;

  WatchlistTvShowsBloc(this._getWatchlistTv, this._saveWatchlistTv,
      this._removeWatchlistTv, this._getWatchListStatusTv)
      : super(WatchlistTvShowsEmpty()) {
    on<FetchWatchlistTvShows>((event, emit) async {
      emit(WatchlistTvShowsLoading());
      final result = await _getWatchlistTv.execute();

      result.fold(
        (failure) {
          emit(WatchlistTvShowsError(failure.message));
        },
        (data) {
          emit(WatchlistTvShowsHasData(data));
        },
      );
    });

    on<AddWatchListTv>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await _saveWatchlistTv.execute(tvDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvShowsMessageFailure(failure.message));
        },
        (successMessage) {
          emit(const WatchlistTvShowsMessageSuccess('Added To Watchlist'));
        },
      );
      add(LoadWatchlistStatusTv(tvDetail.id));
    });

    on<RemoveFromWatchListTv>((event, emit) async {
      final tvDetail = event.tvDetail;
      final result = await _removeWatchlistTv.execute(tvDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvShowsMessageFailure(failure.message));
        },
        (successMessage) {
          emit(const WatchlistTvShowsMessageSuccess('Removed From Watchlist'));
        },
      );
      add(LoadWatchlistStatusTv(tvDetail.id));
    });

    on<LoadWatchlistStatusTv>((event, emit) async {
      final id = event.id;
      final result = await _getWatchListStatusTv.execute(id);

      emit(WatchlistTvShowsStatus(result));
    });
  }
}
