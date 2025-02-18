

class UserWallet {
  String? openningBalance;
  String? currentBalance;
  int? currency;
  int? status;

  UserWallet({this.openningBalance, this.currentBalance, this.currency, this.status});

  UserWallet.fromJson(Map<String, dynamic> json) {
    openningBalance = json['openning_balance'];
    currentBalance = json['current_balance'];
    currency = json['currency'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openning_balance'] = this.openningBalance;
    data['current_balance'] = this.currentBalance;
    data['currency'] = this.currency;
    data['status'] = this.status;
    return data;
  }
}

