import 'package:chainsampletask/Data/data.dart';
import 'package:chainsampletask/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OptionChainScreen extends StatefulWidget {
  const OptionChainScreen({super.key});

  @override
  State<OptionChainScreen> createState() => _OptionChainScreenState();
}

class _OptionChainScreenState extends State<OptionChainScreen> {
  final scrollController = ScrollController();
  final textController = TextEditingController();
  int startIndex = 0; 
  int endIndex = 0;  
  int visibleItemCount = 0; 
  double topPosition = 0; 
  double bottomPosition = 0; 
  double itemHeight = 0; 
  double screenHeight = 0; 
  double totalListHeight = 0; 

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_handleScrollEvent);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      screenHeight = MediaQuery.of(context).size.height;
      totalListHeight = scrollController.position.viewportDimension + scrollController.position.maxScrollExtent;
      itemHeight = totalListHeight / displayData.length;
      visibleItemCount = scrollController.position.viewportDimension ~/ itemHeight;
      calculateVisibleItemIndices();
    });
  }

  void calculateVisibleItemIndices() {
    startIndex = (scrollController.position.pixels / itemHeight).ceil();
    endIndex = startIndex + visibleItemCount - 1;
  }

  void _handleScrollEvent() {
    calculateVisibleItemIndices();
    if (textController.text.isNotEmpty) {
      final val = double.parse(textController.text);
      adjustPosition(val);
    }
  }

  void adjustPosition(double val) {
    if (displayData[endIndex].strikePrice > val && displayData[startIndex].strikePrice < val) {
      double diff = 0;
      if (displayData[startIndex].strikePrice > val) {
        diff = (displayData[startIndex].strikePrice - val) / range;
      } else {
        diff = (val - displayData[startIndex].strikePrice) / range;
      }
      setState(() {
        topPosition = (diff * itemHeight) + itemHeight;
        bottomPosition = (itemHeight * (visibleItemCount - diff.ceil())) - itemHeight;
      });
    } else if (displayData[startIndex].strikePrice > val) {
      setState(() {
        topPosition = 0;
        bottomPosition = itemHeight * visibleItemCount;
      });
    } else if (displayData[endIndex].strikePrice < val) {
      setState(() {
        topPosition = itemHeight * visibleItemCount;
        bottomPosition = 0;
      });
    }
  }

  void onSearchSubmit() {
    if (textController.text.isNotEmpty) {
      final val = double.parse(textController.text);
      if (displayData[0].strikePrice > val) {
        textController.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Entered value is lesser than ${displayData[0].strikePrice}"),
        ));
      } else if (displayData[displayData.length - 1].strikePrice < val) {
        textController.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Entered value is greater than ${displayData[displayData.length - 1].strikePrice}"),
        ));
      } else {
        final target = totalListHeight * (val / range) / displayData.length - itemHeight;
        scrollController.animateTo(target, duration: const Duration(seconds: 1), curve: Curves.bounceIn);
        adjustPosition(val);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: TextField(
              keyboardType: TextInputType.number,
              controller: textController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(color: primaryTextColor),
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: primaryTextColor),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: primaryTextColor,
                  ),
                  onPressed: onSearchSubmit,
                ),
                hintText: 'Search Strike price',
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Row(children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "CALL",
                      style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "STRIKE PRICE",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: primaryTextColor),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "PUT",
                      style: TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor),
                    ),
                  ),
                ),
              ]),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              horizontalMargin: 20,
                              columnSpacing: 30,
                              border: TableBorder.all(color: Colors.black),
                              headingRowHeight: 0,
                              columns: const [
                                DataColumn(
                                  label: Text('call1'),
                                ),
                                DataColumn(
                                  label: Text('call2'),
                                ),
                                DataColumn(
                                  label: Text('call3'),
                                ),
                              ],
                              rows: displayData
                                  .map(
                                    (element) => DataRow(
                                      cells: [
                                        DataCell(
                                          SizedBox(
                                            width: width * 0.14,
                                            child: Text(
                                              element.call1,
                                              style: const TextStyle(color: secondaryTextColor),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            width: width * dataTableWidthFactor,
                                            child: Text(
                                              element.call2,
                                              style: const TextStyle(color: primaryTextColor),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            width: width * dataTableWidthFactor,
                                            child: Text(
                                              element.call3,
                                              style: const TextStyle(color: secondaryTextColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        Container(
                          width: width * dataTableWidthFactor,
                          color: const Color.fromARGB(255, 1, 27, 2),
                          child: DataTable(
                            headingRowHeight: 0,
                            horizontalMargin: 15,
                            columnSpacing: 30,
                            border: TableBorder.symmetric(
                              inside: const BorderSide(color: Color.fromARGB(255, 1, 27, 2)),
                            ),
                            columns: const [
                              DataColumn(
                                label: Text('strikePrice'),
                              ),
                            ],
                            rows: displayData
                                .map(
                                  (element) => DataRow(
                                    cells: [
                                      DataCell(
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            element.strikePrice.toStringAsFixed(2),
                                            style: const TextStyle(color: primaryTextColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.4,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              horizontalMargin: 20,
                              columnSpacing: 30,
                              border: TableBorder.all(color: Colors.black),
                              headingRowHeight: 0,
                              columns: const [
                                DataColumn(
                                  label: Text('put1'),
                                ),
                                DataColumn(
                                  label: Text('put2'),
                                ),
                                DataColumn(
                                  label: Text('put3'),
                                ),
                              ],
                              rows: displayData
                                  .map(
                                    (element) => DataRow(
                                      cells: [
                                        DataCell(
                                          SizedBox(
                                            width: width * dataTableWidthFactor,
                                            child: Text(
                                              element.put1,
                                              style: const TextStyle(color: primaryTextColor),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            width: width * dataTableWidthFactor,
                                            child: Text(
                                              element.put2,
                                              style: const TextStyle(color: secondaryTextColor),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            width: width * 0.14,
                                            child: Text(
                                              element.put3,
                                              style: const TextStyle(color: secondaryTextColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (textController.text.isNotEmpty)
            AnimatedPositioned(
              left: width * 0.3,
              right: width * 0.3,
              bottom: bottomPosition,
              top: topPosition,
              duration: const Duration(milliseconds: 300),
              child: Chip(label: Text('Spot Price: ${textController.text}')),
            ),
        ],
      ),
    );
  }
}
