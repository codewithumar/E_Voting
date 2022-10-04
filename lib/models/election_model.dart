class ElectionModel {
  String? id;
  final String electioname;
  final String electiondate;
  final String electionstarttime;
  final String electionendtime;
  final String electionmaxvotetime;

  ElectionModel({
    this.id,
    required this.electioname,
    required this.electiondate,
    required this.electionstarttime,
    required this.electionendtime,
    required this.electionmaxvotetime,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'electioname': electioname,
        'electiondate': electiondate,
        'electionstarttime': electionstarttime,
        'electionendtime': electionendtime,
        'electionmaxvotetime': electionmaxvotetime,
      };

  static ElectionModel fromJson(Map<String, dynamic> data) => ElectionModel(
        id: data['id'],
        electioname: data['electioname'],
        electiondate: data['electiondate'],
        electionstarttime: data['electionstarttime'],
        electionendtime: data['electionendtime'],
        electionmaxvotetime: data['electionmaxvotetime'],
      );
}
