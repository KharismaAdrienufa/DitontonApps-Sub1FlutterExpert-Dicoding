import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvDetail {
  final TvRepository _repository;

  GetTvDetail(this._repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return _repository.getTvDetail(id);
  }
}
