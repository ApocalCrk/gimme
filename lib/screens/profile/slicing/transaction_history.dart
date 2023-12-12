import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  List<Map<String, dynamic>> historyData = [];
  int currentPage = 1;
  bool isLoading = false;
  bool isLastPage = false;
  TextEditingController searchController = TextEditingController();
  String selectedDate = 'All time';

  Future<void> searchData(String query) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.http(url, '$endpoint/user/getTransactionBySearch/${dataUser["uid"]}/$query')
    );
    if (response.statusCode == 200) {
      final List<dynamic> historyList = json.decode(response.body);
      setState(() {
        historyData.clear();
        historyData.addAll(historyList.cast<Map<String, dynamic>>());
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> searchDataByDate(String date) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(
      Uri.http(url, '$endpoint/user/getTransactionByDate/${dataUser["uid"]}/$date')
    );
    if (response.statusCode == 200) {
      final List<dynamic> historyList = json.decode(response.body);
      setState(() {
        historyData.clear();
        historyData.addAll(historyList.cast<Map<String, dynamic>>());
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getPaymentHistory() async {
    if(currentPage == 1) historyData.clear();
    if (!isLastPage) {
      setState(() {
        isLoading = true;
      });
      
      final response = await http.get(
        Uri.http(url, '$endpoint/user/getAllTransaction/${dataUser["uid"]}', {
          'page': currentPage.toString(),
        }),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> historyList = responseData['data'];
        setState(() {
          historyData.addAll(historyList.cast<Map<String, dynamic>>());
          isLoading = false;
          final int lastPage = responseData['last_page'];
          if (currentPage >= lastPage) {
            isLastPage = true;
          } else {
            currentPage++;
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPaymentHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "Transaction History",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  onChanged:(value) {
                    if (value.isNotEmpty && searchController.text.isNotEmpty) {
                      setState(() {
                        currentPage = 1;
                        isLastPage = false;
                        searchData(searchController.text);
                      });
                    }else{
                      setState(() {
                        currentPage = 1;
                        isLastPage = false;
                        getPaymentHistory();
                      });
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintText: "Search",
                    hintStyle: const TextStyle(
                      color: secondaryColor,
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600
                    ),
                    prefixIcon: const Icon(Icons.search_rounded, color: secondaryColor),
                    suffixIcon: searchController.text.isNotEmpty ? GestureDetector(
                      onTap: () {
                        setState(() {
                          searchController.clear();
                          currentPage = 1;
                          isLastPage = false;
                          getPaymentHistory();
                        });
                      },
                      child: const Icon(Icons.close_rounded, color: secondaryColor),
                    ) : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: lowSecondaryColor
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: lowSecondaryColor
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: lowSecondaryColor
                      )
                    )
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Filter by date",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (selectedDate != 'All time') {
                            setState(() {
                              selectedDate = 'All time';
                              historyData.clear();
                              currentPage = 1;
                              isLastPage = false;
                              getPaymentHistory();
                            });
                          }else{
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2101)
                            ).then((value) {
                              setState(() {
                                selectedDate = formatStringDate(value.toString());
                                currentPage = 1;
                                isLastPage = false;
                                searchDataByDate(value.toString());
                              });
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              selectedDate,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            const SizedBox(width: 10),
                            selectedDate == 'All time' ? 
                            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.black)
                            : const Icon(Icons.close_rounded, size: 14, color: Colors.black)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView.builder(
                itemCount: historyData.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < historyData.length) {
                    final item = historyData[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/profile/transaction_history/detail', arguments: item);
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 2),
                                    blurRadius: 5
                                  )
                                ]
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['gym']['name'],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          formatStringDate(item['created_at']),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    item['bundle'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    if (!isLoading && !isLastPage && searchController.text.isEmpty && selectedDate == 'All time') {
                      return GestureDetector(
                        onTap: () {
                          getPaymentHistory();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 2),
                                blurRadius: 5
                              )
                            ]
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_downward),
                              SizedBox(width: 10),
                              Text(
                                "Load More",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if(historyData.isEmpty){
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 5
                            )
                          ]
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.warning_rounded, color: Colors.red),
                            SizedBox(width: 10),
                            Text(
                              "Data is Empty",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.warning_rounded, color: Colors.red),
                          ],
                        ),
                      );
                    }else if (isLastPage || searchController.text.isNotEmpty || selectedDate != 'All time') {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 5
                            )
                          ]
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.warning_rounded, color: Colors.red),
                            SizedBox(width: 10),
                            Text(
                              "No More Data",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.warning_rounded, color: Colors.red),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 5
                            )
                          ]
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Loading...",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ),
        ],
      )
    );
  }
}