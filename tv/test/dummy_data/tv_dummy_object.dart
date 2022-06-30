import 'package:tv/tv.dart';
import 'package:core/core.dart';

final testTv = Tv(
  backdropPath: '/path.jpg',
  genreIds: const [1],
  id: 1,
  name: 'name',
  originalLanguage: 'en',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: '/path.jpg',
  voteAverage: 1.0,
  voteCount: 1,
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: "backdropPath",
  episodeRunTime: const [1],
  genres: const [Genre(id: 0, name: "Sci-Fi & Fantasy")],
  homepage: "homepage",
  id: 1,
  inProduction: true,
  languages: const ["languages"],
  name: "name",
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: const ["US"],
  originalLanguage: "originalLanguage",
  originalName: "originalName",
  overview: "overview",
  popularity: 1.0,
  posterPath: "posterPath",
  status: "status",
  tagline: "tagline",
  type: "type",
  voteAverage: 1.0,
  voteCount: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
