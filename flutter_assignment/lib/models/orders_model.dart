// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

OrdersModel ordersModelFromJson(String str) =>
    OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  Status? status;
  Data? data;

  OrdersModel({
    this.status,
    this.data,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  List<Order>? orders;

  Data({
    this.orders,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  String? symbol;
  Type? type;
  Side? side;
  double? quantity;
  int? creationTime;
  double? price;

  Order({
    this.symbol,
    this.type,
    this.side,
    this.quantity,
    this.creationTime,
    this.price,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        symbol: json["symbol"],
        type: typeValues.map[json["type"]]!,
        side: sideValues.map[json["side"]]!,
        quantity: json["quantity"]?.toDouble(),
        creationTime: json["creation_time"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "type": typeValues.reverse[type],
        "side": sideValues.reverse[side],
        "quantity": quantity,
        "creation_time": creationTime,
        "price": price,
      };
}

enum Side { SELL, BUY }

final sideValues = EnumValues({"SELL": Side.SELL, "BUY": Side.BUY});

enum Type { LMT }

final typeValues = EnumValues({"LMT": Type.LMT});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
