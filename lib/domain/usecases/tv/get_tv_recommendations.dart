import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository _repository;

  GetTvRecommendations(this._repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return _repository.getTvRecommendations(id);
  }
}
