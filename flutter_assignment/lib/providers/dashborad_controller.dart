import 'package:flutter/material.dart';
import 'package:flutter_assignment/models/orders_model.dart';
import 'package:flutter_assignment/models/portfolio_model.dart';
import 'package:flutter_assignment/service/response_handler.dart';
import 'package:flutter_assignment/service/service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DashboardController extends ChangeNotifier {
  bool _orderloading = false;
  bool get getOrderLoader => _orderloading;
  void setOrderLoader(bool loading) {
    _orderloading = loading;
    notifyListeners();
  }

  OrdersModel _fetchAllRecords = OrdersModel();
  List<Order> _filteredOrders = [];

  setAllOrdersREcords(OrdersModel records) {
    _fetchAllRecords = records;
    _filteredOrders = records.data?.orders ?? [];
    notifyListeners();
  }

  OrdersModel getAllOrdersRecords() {
    return _fetchAllRecords;
  }

  List<Order> get filteredOrders => _filteredOrders;

  List<String> getAllSymbols() {
    List<String> symbols = [];
    if (_fetchAllRecords.data?.orders != null) {
      for (var order in _fetchAllRecords.data!.orders!) {
        if (!symbols.contains(order.symbol)) {
          symbols.add(order.symbol!);
        }
      }
    }
    return symbols;
  }

  int itemsPerPage = 5;
  int currentPage = 0;

  List<Order> get currentPageOrders {
    final startIndex = currentPage * itemsPerPage;
    final endIndex =
        (startIndex + itemsPerPage).clamp(0, _filteredOrders.length);
    return _filteredOrders.sublist(startIndex, endIndex);
  }

  bool get canGoToNextPage {
    return (currentPage + 1) * itemsPerPage < _filteredOrders.length;
  }

  bool get canGoToPreviousPage {
    return currentPage > 0;
  }

  void setCurrentPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  Future<dynamic> getOrders() async {
    setOrderLoader(true);
    final response = await APIService.fetchOrders();
    if (response is Success) {
      Success data = response;
      var allrecords = data.successResponse as OrdersModel;
      setAllOrdersREcords(allrecords);
    } else if (response is Failure) {
      showToast('Failed to load orders');
    }
    setOrderLoader(false);
  }

  void filterOrders(
      {String? symbol, double? price, DateTime? startDate, DateTime? endDate}) {
    List<Order> filteredOrders = _fetchAllRecords.data!.orders!.where((order) {
      bool matches = true;
      if (symbol != null && symbol.isNotEmpty) {
        matches = matches && order.symbol == symbol;
      }
      if (price != null) {
        matches = matches && order.price == price;
      }
      if (startDate != null) {
        matches = matches &&
            (DateTime.fromMillisecondsSinceEpoch(order.creationTime! * 1000)
                    .isAfter(startDate) ||
                DateTime.fromMillisecondsSinceEpoch(order.creationTime! * 1000)
                    .isAtSameMomentAs(startDate));
      }
      if (endDate != null) {
        matches = matches &&
            (DateTime.fromMillisecondsSinceEpoch(order.creationTime! * 1000)
                    .isBefore(endDate) ||
                DateTime.fromMillisecondsSinceEpoch(order.creationTime! * 1000)
                    .isAtSameMomentAs(endDate));
      }
      return matches;
    }).toList();
    setFilteredOrders(filteredOrders);
  }

  void setFilteredOrders(List<Order> filterOrders) {
    _filteredOrders = filterOrders;
    currentPage = 0; // Reset to first page when applying filter
    notifyListeners();
  }

  String displaySide(Side side) {
    switch (side) {
      case Side.SELL:
        return "Sell";
      case Side.BUY:
        return "Buy";
      default:
        return "";
    }
  }

  bool _portfolioloading = false;
  bool get getPortfolioLoader => _portfolioloading;
  void setPortfolioLoader(bool loading) {
    _portfolioloading = loading;
    notifyListeners();
  }

  PortfolioModel _portfolioModel = PortfolioModel();

  setAllPortfolios(PortfolioModel records) {
    _portfolioModel = records;
  }

  PortfolioModel getAllPortfolios() {
    return _portfolioModel;
  }

  Future<dynamic> getPortfolios() async {
    setPortfolioLoader(true);
    final response = await APIService.fetchPortfolios();
    if (response is Success) {
      Success data = response;
      var allrecords = data.successResponse as PortfolioModel;
      setAllPortfolios(allrecords);
    } else if (response is Failure) {
      showToast('Failed to load portfolios');
    }
    setPortfolioLoader(false);
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}
