

class PaymentDetail {
  String? money;
  String? date;
  String? status;
  String? payment_type;
  String? userId;

  PaymentDetail({this.money, this.date, this.status,this.payment_type,this.userId});

  PaymentDetail.fromJson(Map<String, dynamic> json) {
    money = json['money'];
    date = json['date'];
    status = json['status'];
    payment_type = json['payment_type'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['money'] = this.money;
    data['date'] = this.date;
    data['status'] = this.status;
    data['payment_type'] = this.payment_type;
    data['userId'] = this.userId;

    return data;
  }
}
