import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_shows_on_the_air_event.dart';
part 'tv_shows_on_the_air_state.dart';

class TvShowsOnTheAirBloc extends Bloc<TvShowsOnTheAirEvent, TvShowsOnTheAirState> {
  final GetTvOnTheAir _getTvOnTheAir;

  TvShowsOnTheAirBloc(this._getTvOnTheAir) : super(TvShowsOnTheAirEmpty()) {
    on<FetchTvShowsOnTheAir>((event, emit) async {
      emit(TvShowsOnTheAirLoading());
      final result = await _getTvOnTheAir.execute();

      result.fold(
        (failure) {
          emit(TvShowsOnTheAirError(failure.message));
        },
        (data) {
          emit(TvShowsOnTheAirHasData(data));
        },
      );
    });
  }
}
