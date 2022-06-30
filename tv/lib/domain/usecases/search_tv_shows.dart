import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/tv.dart';

class SearchTvShows {
  final TvRepository repository;

  SearchTvShows(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTvShows(query);
  }
}
