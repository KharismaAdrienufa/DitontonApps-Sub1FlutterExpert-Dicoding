import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_shows_detail_event.dart';
part 'tv_shows_detail_state.dart';

class TvShowsDetailBloc extends Bloc<TvShowsDetailEvent, TvShowsDetailState> {
  final GetTvDetail _getTvDetail;

  TvShowsDetailBloc(this._getTvDetail) : super(TvShowsDetailEmpty()) {
    on<FetchTvShowsDetail>((event, emit) async {
      final id = event.id;

      emit(TvShowsDetailLoading());
      final result = await _getTvDetail.execute(id);

      result.fold(
        (failure) {
          emit(TvShowsDetailError(failure.message));
        },
        (data) {
          emit(TvShowsDetailHasData(data));
        },
      );
    });
  }
}
