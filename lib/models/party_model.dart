class PartyModel {
  String? id;
  final String partyname;
  final String imgURl;
  PartyModel({this.id, required this.partyname, required this.imgURl});

  Map<String, dynamic> toJson() => {
        'partyname': partyname,
        'imgurl': imgURl,
        'id': id,
      };

  static PartyModel fromJson(Map<String, dynamic> data) => PartyModel(
        partyname: data['partyname'],
        imgURl: data['imgurl'],
        id: data['id'],
      );
}
