class TinkPrivateModel {
  final int id;
  String name;
  String note;

  TinkPrivateModel({
    required this.id,
    required this.name,
    required this.note,
  });

  void privateChange({
    required String Nname,
    required String Nnote,
  }) {
    name = Nname;
    note = Nnote;
  }

  factory TinkPrivateModel.fromTinkMap(Map<String, dynamic> tinkMap) =>
      TinkPrivateModel(
        id: int.parse(tinkMap['id'].toString()),
        name: tinkMap['name'],
        note: tinkMap['note'],
      );

  Map<String, dynamic> toTinkMap() => {
        'name': name,
        'note': note,
      };
}
