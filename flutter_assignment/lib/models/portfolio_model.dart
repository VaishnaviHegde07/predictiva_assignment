// To parse this JSON data, do
//
//     final portfolioModel = portfolioModelFromJson(jsonString);

import 'dart:convert';

PortfolioModel portfolioModelFromJson(String str) =>
    PortfolioModel.fromJson(json.decode(str));

String portfolioModelToJson(PortfolioModel data) => json.encode(data.toJson());

class PortfolioModel {
  Status? status;
  Data? data;

  PortfolioModel({
    this.status,
    this.data,
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) => PortfolioModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  Portfolio? portfolio;

  Data({
    this.portfolio,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        portfolio: json["portfolio"] == null
            ? null
            : Portfolio.fromJson(json["portfolio"]),
      );

  Map<String, dynamic> toJson() => {
        "portfolio": portfolio?.toJson(),
      };
}

class Portfolio {
  double? balance;
  double? profit;
  int? profitPercentage;
  int? assets;

  Portfolio({
    this.balance,
    this.profit,
    this.profitPercentage,
    this.assets,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
        balance: json["balance"]?.toDouble(),
        profit: json["profit"]?.toDouble(),
        profitPercentage: json["profit_percentage"],
        assets: json["assets"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "profit": profit,
        "profit_percentage": profitPercentage,
        "assets": assets,
      };
}

class Status {
  String? msg;

  Status({
    this.msg,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
      };
}
