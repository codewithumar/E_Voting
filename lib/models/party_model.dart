class PartyModel {
  final String partyname;
  final String imgURl;
  PartyModel({required this.partyname, required this.imgURl});

  Map<String, dynamic> toJson() => {
        'partyname': partyname,
        'imgurl': imgURl,
      };

  static PartyModel fromJson(Map<String, dynamic> data) => PartyModel(
        partyname: data['partyname'],
        imgURl: data['imgurl'],
      );
}
