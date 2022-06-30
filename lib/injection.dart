import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
locator.registerFactory(
    () => NowPlayingMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SearchMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationsMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(() => WatchlistMovieBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

// bloc tv
  locator.registerFactory(
    () => TvShowsOnTheAirBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowsDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvShowsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowsSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowsRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvShowsBloc(
      locator(),
    ),
  );
  locator.registerFactory(() => WatchlistTvShowsBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetPopularTvShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShows(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvOnTheAir(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShows(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvStatus(locator()));
  locator.registerLazySingleton(() => RemoveTvWatchlist(locator()));
  locator.registerLazySingleton(() => SaveTvWatchlist(locator()));
  locator.registerLazySingleton(() => SearchTvShows(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(() => TvRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
      ));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<MovieDatabaseHelper>(() => MovieDatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
