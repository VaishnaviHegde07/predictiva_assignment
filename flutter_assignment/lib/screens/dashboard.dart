import 'package:flutter/material.dart';
import 'package:flutter_assignment/providers/dashborad_controller.dart';
import 'package:flutter_assignment/screens/utils/text.dart';
import 'package:flutter_assignment/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchDashboardData();
    });
  }

  void fetchDashboardData() async {
    await Provider.of<DashboardController>(context, listen: false)
        .getPortfolios();
    // ignore: use_build_context_synchronously
    await Provider.of<DashboardController>(context, listen: false).getOrders();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    DashboardController records = Provider.of<DashboardController>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        children: [
          Container(
            height: screenHeight * 0.08,
            color: const Color(0xff151515),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 18, right: 18, bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HeadingText(
                  text: 'Hi Robin,',
                  fontSize: screenHeight * 0.030,
                ),
                SizedBox(height: screenHeight * 0.002),
                const CommonText(
                    text: 'Here is an overview of your account activities.'),
                SizedBox(height: screenHeight * 0.02),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    records.getPortfolioLoader ||
                            records.getAllPortfolios().data == null
                        ? const Center(child: CircularProgressIndicator())
                        : showPortfolios(context, records),
                    SizedBox(height: screenHeight * 0.02),
                    records.getOrderLoader ||
                            records.getAllOrdersRecords().data == null
                        ? const Center(child: CircularProgressIndicator())
                        : showOrders(context, records),
                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showPortfolios(BuildContext context, DashboardController records) {
    double screenHeight = MediaQuery.of(context).size.height * 0.33;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        height: screenHeight,
        width: screenWidth,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorPalette.containerBackground, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(text: 'Balance'),
                  HeadingText(
                    text:
                        "\$${records.getAllPortfolios().data!.portfolio!.balance!.toStringAsFixed(2)}",
                    fontSize: screenHeight * 0.075,
                  ),
                  const Divider(color: ColorPalette.containerBackground),
                  const CommonText(text: 'Profits'),
                  Row(
                    children: [
                      HeadingText(
                        text:
                            "\$${records.getAllPortfolios().data!.portfolio!.profit!.toStringAsFixed(2)}",
                        fontSize: screenHeight * 0.075,
                      ),
                      const SizedBox(width: 10),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Image.asset('assets/images/Vector.png',
                                  width: 20, height: 20),
                              Text(
                                '${records.getAllPortfolios().data!.portfolio!.profitPercentage!}%',
                                style: const TextStyle(color: Colors.red),
                              )
                            ],
                          )),
                    ],
                  ),
                  const Divider(color: ColorPalette.containerBackground),
                  const CommonText(text: 'Assets'),
                  HeadingText(
                    text: records
                        .getAllPortfolios()
                        .data!
                        .portfolio!
                        .assets!
                        .toInt()
                        .toString(),
                    fontSize: screenHeight * 0.075,
                  ),
                ],
              ),
            ),
            const Divider(color: ColorPalette.containerBackground),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/warning-circle.png',
                    width: screenWidth * 0.07, height: screenHeight * 0.07),
                SizedBox(width: screenWidth * 0.01),
                const CommonText(text: 'This subscription expires in a month'),
              ],
            ),
          ],
        ));
  }

  String formatUnixTimestamp(int unixTimestamp) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
    var formatter = DateFormat('dd MMM, yyyy');
    return formatter.format(dateTime);
  }

  Widget showOrders(BuildContext context, DashboardController records) {
    double screenHeight = MediaQuery.of(context).size.height * 0.63;
    return Container(
      height: screenHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: ColorPalette.containerBackground, width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 0, left: 8, right: 8, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 7, left: 8, right: 8, bottom: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeadingText(
                        text: "Open trades",
                        fontSize: screenHeight * 0.035,
                      ),
                      GestureDetector(
                        onTap: () {
                          showFilterDialog(context, records);
                        },
                        child: Image.asset('assets/images/filter-list.png'),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(
                    height: screenHeight * 0.7,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      itemCount: records.currentPageOrders.length,
                      itemBuilder: (context, index) {
                        var order = records.currentPageOrders[index];
                        return Column(
                          children: [
                            const Divider(
                                color: ColorPalette.containerBackground),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HeadingText(
                                  text: order.symbol ?? '',
                                  fontSize: screenHeight * 0.03,
                                ),
                                CommonText(
                                    text: order.price!.toStringAsFixed(2)),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            records.displaySide(order.side!) ==
                                                    'Buy'
                                                ? Colors.green
                                                : Colors.red),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        " ${records.displaySide(order.side!)} ",
                                        style: TextStyle(
                                            color: records.displaySide(
                                                        order.side!) ==
                                                    'Buy'
                                                ? Colors.green
                                                : Colors.red),
                                      )
                                    ],
                                  ),
                                ),
                                CommonText(
                                  text: formatUnixTimestamp(
                                    order.creationTime ?? 0,
                                  ),
                                  color: const Color(0xffB1B1B8),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.005),
                          ],
                        );
                      },
                    ),
                  ),
                  const Divider(color: ColorPalette.containerBackground),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonText(
                        text:
                            '${(records.currentPage * records.itemsPerPage) + 1} - ${(records.currentPage * records.itemsPerPage + records.currentPageOrders.length)} of ${records.filteredOrders.length}',
                        color: const Color(0xffE1E1E5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: screenHeight * 0.08,
                            width: screenHeight * 0.07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: ColorPalette.containerBackground,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: records.canGoToPreviousPage
                                    ? () {
                                        records.setCurrentPage(
                                            records.currentPage - 1);
                                      }
                                    : null,
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: records.canGoToPreviousPage
                                      ? Colors.white
                                      : const Color(0xffB1B1B8),
                                  size: screenHeight * 0.04,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Container(
                            height: screenHeight * 0.08,
                            width: screenHeight * 0.07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: ColorPalette.containerBackground,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: IconButton(
                                onPressed: records.canGoToNextPage
                                    ? () {
                                        records.setCurrentPage(
                                            records.currentPage + 1);
                                      }
                                    : null,
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: records.canGoToNextPage
                                      ? Colors.white
                                      : const Color(0xffB1B1B8),
                                  size: screenHeight * 0.04,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showFilterDialog(BuildContext context, DashboardController records) {
    String? selectedSymbol;
    final priceController = TextEditingController();
    DateTime? selectedStartDate;
    DateTime? selectedEndDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: ColorPalette.lightgrey, width: 0.5),
          ),
          title: const Text(
            'Filter Table',
            style: TextStyle(
                color: ColorPalette.whiteColor, fontWeight: FontWeight.bold),
          ),
          elevation: 5,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: ColorPalette.containerBackground,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: ColorPalette.containerBackground,
                            style: const TextStyle(
                                color: ColorPalette.whiteColor, fontSize: 14),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                border: InputBorder.none,
                                labelText: 'Symbol',
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.start,
                                labelStyle: TextStyle(
                                    color: ColorPalette.lightgrey,
                                    fontSize: 12)),
                            items: records.getAllSymbols().map((String symbol) {
                              return DropdownMenuItem<String>(
                                value: symbol,
                                child: Text(
                                  symbol,
                                  style: const TextStyle(
                                      color: ColorPalette.whiteColor,
                                      fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedSymbol = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: ColorPalette.containerBackground,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: TextFormField(
                            controller: priceController,
                            style:
                                const TextStyle(color: ColorPalette.whiteColor),
                            decoration: const InputDecoration(
                                labelText: 'Price',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(8),
                                labelStyle: TextStyle(
                                    color: ColorPalette.lightgrey,
                                    fontSize: 12)),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Date range',
                    style: TextStyle(
                        color: ColorPalette.whiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: ColorPalette.containerBackground,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: TextFormField(
                            style: const TextStyle(
                                color: ColorPalette.whiteColor, fontSize: 14),
                            decoration: InputDecoration(
                                labelText: 'Start Date',
                                contentPadding: const EdgeInsets.all(8),
                                border: InputBorder.none,
                                suffixIcon: Image.asset(
                                    'assets/images/calendar.png',
                                    width: 20,
                                    height: 20),
                                labelStyle: const TextStyle(
                                    color: ColorPalette.lightgrey,
                                    fontSize: 10)),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate:
                                    selectedStartDate ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  selectedStartDate = pickedDate;
                                  if (selectedEndDate != null &&
                                      selectedEndDate!
                                          .isBefore(selectedStartDate!)) {
                                    selectedEndDate = null;
                                  }
                                });
                              }
                            },
                            controller: TextEditingController(
                              text: selectedStartDate == null
                                  ? ''
                                  : DateFormat('dd-MM-yyyy')
                                      .format(selectedStartDate!),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: ColorPalette.containerBackground,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: TextFormField(
                            style: const TextStyle(
                                color: ColorPalette.whiteColor, fontSize: 14),
                            decoration: InputDecoration(
                                labelText: 'End Date',
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(8),
                                suffixIcon: Image.asset(
                                    'assets/images/calendar.png',
                                    width: 20,
                                    height: 20),
                                labelStyle: const TextStyle(
                                    color: ColorPalette.lightgrey,
                                    fontSize: 10)),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: selectedEndDate ?? DateTime.now(),
                                firstDate: selectedStartDate ?? DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  selectedEndDate = pickedDate;
                                });
                              }
                            },
                            controller: TextEditingController(
                              text: selectedEndDate == null
                                  ? ''
                                  : DateFormat('dd-MM-yyyy')
                                      .format(selectedEndDate!),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPalette.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                records.filterOrders(
                  symbol: selectedSymbol,
                  price: double.tryParse(priceController.text),
                  startDate: selectedStartDate,
                  endDate: selectedEndDate,
                );
                Navigator.of(context).pop();
              },
              child: const Text(
                'Filter Table',
                style: TextStyle(
                    color: ColorPalette.whiteColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
