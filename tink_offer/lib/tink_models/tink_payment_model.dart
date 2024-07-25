class TinkPaymentModel {
  final int id;
  String name;
  String type;
  String amount;
  String info;
  String day;
  String month;
  String year;
  String time;
  String remind;

  TinkPaymentModel({
    required this.id,
    required this.name,
    required this.type,
    required this.amount,
    required this.info,
    required this.day,
    required this.month,
    required this.year,
    required this.time,
    required this.remind,
  });

  void paymentChange({
    required String Nname,
    required String Ntype,
    required String Namount,
    required String Ninfo,
    required String Nday,
    required String Nmonth,
    required String Nyear,
    required String Ntime,
  }) {
    name = Nname;
    type = Ntype;
    amount = Namount;
    info = Ninfo;
    day = Nday;
    month = Nmonth;
    year = Nyear;
    time = Ntime;
  }

  factory TinkPaymentModel.fromTinkMap(Map<String, dynamic> tinkMap) =>
      TinkPaymentModel(
        id: int.parse(tinkMap['id'].toString()),
        name: tinkMap['name'],
        type: tinkMap['type'],
        amount: tinkMap['amount'],
        info: tinkMap['info'],
        day: tinkMap['day'],
        month: tinkMap['month'],
        year: tinkMap['year'],
        time: tinkMap['time'],
        remind: tinkMap['remind'],
      );

  Map<String, dynamic> toTinkMap() => {
        'name': name,
        'type': type,
        'amount': amount,
        'info': info,
        'day': day,
        'month': month,
        'year': year,
        'time': time,
        'remind': remind,
      };
}
