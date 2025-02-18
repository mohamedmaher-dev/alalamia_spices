class FinancialPortfoliosData {
  bool? success;
  List<FinancialPortfolios>? financialPortfolios;

  FinancialPortfoliosData({this.success, this.financialPortfolios});

  FinancialPortfoliosData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      financialPortfolios = <FinancialPortfolios>[];
      json['data'].forEach((v) {
        financialPortfolios!.add(  FinancialPortfolios.fromJson(v));
      });
    }
  }


}

class FinancialPortfolios {
  String? id;
  int? status;
  String? image;
  bool? active;
  String? imagePath64;
  String? imagePath100;
  String? name;
  String? number;

  FinancialPortfolios(
      {this.id,
        this.status,
        this.image,
        this.active,
        this.imagePath64,
        this.imagePath100,
        this.name,
        this.number
      });

  FinancialPortfolios.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    status = json['status'];
    image = json['image'];
    active = json['active'];
    imagePath64 = json['image_path_64'];
    imagePath100 = json['image_path_100'];
    name = json['name'];
    number = json['number'].toString();
  }

}

