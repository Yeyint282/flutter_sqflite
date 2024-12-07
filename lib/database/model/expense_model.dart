class ExpenseModel {
  int? id;
  String? name;
  int? cost;
  String? time;
  String? category;

  ExpenseModel({this.id, this.name, this.cost, this.time, this.category});

  ExpenseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cost = json['cost'];
    time = json['time'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['cost'] = cost;
    data['time'] = time;
    data['category'] = category;
    return data;
  }
}