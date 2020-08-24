class Expense {
  String recordId;
  String name;
  String createdAt;
  double amount;
  String category;

  Expense(
      {this.recordId, this.name, this.createdAt, this.amount, this.category});

  Expense.fromJson(Map<String, dynamic> json) {
    recordId = json['record_id'];
    name = json['name'];
    createdAt = json['created_at'];
    amount = json['amount'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['record_id'] = this.recordId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['amount'] = this.amount;
    data['category'] = this.category;
    return data;
  }
}
