import 'package:freezed_annotation/freezed_annotation.dart';

part 'votecountmodel.freezed.dart';
part 'votecountmodel.g.dart';

@freezed
class VoteCountModel with _$VoteCountModel {
  const factory VoteCountModel({
    required String partyid,
    required String partyname,
    required DateTime datetime,
  }) = _TestClass;

  factory VoteCountModel.fromJson(Map<String, dynamic> json) =>
      _$VoteCountModelFromJson(json);
}
