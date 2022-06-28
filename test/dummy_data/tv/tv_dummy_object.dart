import 'package:ditonton/data/models/tv/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';

final testTv = Tv(
  backdropPath: '/path.jpg',
  genreIds: [1],
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
  episodeRunTime: [1],
  genres: [Genre(id: 0, name: "Sci-Fi & Fantasy")],
  homepage: "homepage",
  id: 1,
  inProduction: true,
  languages: ["languages"],
  name: "name",
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: ["US"],
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

final testTvTable = TvTable(
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
