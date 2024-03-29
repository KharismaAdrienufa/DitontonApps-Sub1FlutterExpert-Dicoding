// ignore_for_file: non_constant_identifier_names

import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';

class TvResponse extends Equatable {
  final List<TvModel> TvList;

  const TvResponse({required this.TvList});

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        TvList: List<TvModel>.from((json['results'] as List)
            .map((x) => TvModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(TvList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [TvList];
}
