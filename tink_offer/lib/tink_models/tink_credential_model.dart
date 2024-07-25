class TinkCredentailModel {
  final int id;
  String name;
  String note;
  String login;
  String pass;

  TinkCredentailModel({
    required this.id,
    required this.name,
    required this.note,
    required this.login,
    required this.pass,
  });

  void credentialChange({
    required String Nname,
    required String Nnote,
    required String Nlogin,
    required String Npass,
  }) {
    name = Nname;
    note = Nnote;
    login = Nlogin;
    pass = Npass;
  }

  factory TinkCredentailModel.fromTinkMap(Map<String, dynamic> tinkMap) =>
      TinkCredentailModel(
        id: int.parse(tinkMap['id'].toString()),
        name: tinkMap['name'],
        note: tinkMap['note'],
        login: tinkMap['login'],
        pass: tinkMap['pass'],
      );

  Map<String, dynamic> toTinkMap() => {
        'name': name,
        'note': note,
        'login': login,
        'pass': pass,
      };
}
