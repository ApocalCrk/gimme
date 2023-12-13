// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:gimme/constants.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  int countTask = 0;
  String date = "${DateFormat('EEEE').format(DateTime.now())}, ${DateFormat('MMMM yyyy').format(DateTime.now())}";
  List<dynamic> listTask = [];
  bool _isLoading = false;

  getNumberofTask(String date) async {
    await get(Uri.http(url, "$endpoint/user/countTask/${dataUser['uid']}/$date")).then((value) {
      setState(() {
        countTask = int.parse(value.body);
      });
    });
  }

  Future<void> getListTask() async {
    await get(Uri.http(url, "$endpoint/user/getAllTaskbyDate/${dataUser['uid']}/${DateFormat('yyyy-MM-dd').format(DateTime.now())}")).then((value) {
      setState(() {
        listTask = jsonDecode(value.body)['data'] as List<dynamic>;
      });
    });
  }

  String convertMinuteToHour(int minute) {
    var hour = minute ~/ 60;
    var minuteTemp = minute % 60;
    String minuteString = minuteTemp < 10 ? '0$minuteTemp' : '$minuteTemp';
    return '$hour:$minuteString';
  }

  @override
  void initState() {
    super.initState();
    getNumberofTask(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    getListTask();
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
          "Daily Plan",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600
                  ),
                ),
                Text(
                  "You have $countTask tasks to do",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    setState(() {
                    _isLoading = true;
                      
                    });
                    await get(Uri.http(url, "$endpoint/user/getAllTaskbyDate/${dataUser['uid']}/${DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: index)))}")).then((value) {
                      setState(() {
                        date = "${DateFormat('EEEE').format(DateTime.now().add(Duration(days: index)))}, ${DateFormat('MMMM yyyy').format(DateTime.now().add(Duration(days: index)))}";
                        getNumberofTask(DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: index))));
                        listTask = jsonDecode(value.body)['data'] as List<dynamic>;
                      });
                    });
                    setState(() {
                      
                    _isLoading = false;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10, left: 20, top: 10, bottom: 10),
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const[
                        BoxShadow(
                          color: lowSecondaryColor,
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('dd').format(DateTime.now().add(Duration(days: index))),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          DateFormat('EEE').format(DateTime.now().add(Duration(days: index))),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              final TextEditingController _titleController = TextEditingController();
              final TextEditingController _caloriesController = TextEditingController();
              final TextEditingController _durationController = TextEditingController();
              final TextEditingController _dateController = TextEditingController();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text("Create Task"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            hintText: "Title",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1
                              )
                            ),
                            label: Text("Title"),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _caloriesController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            suffix: Text("Kcal"),
                            hintText: "Calories",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1
                              )
                            ),
                            label: Text("Calories"),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _durationController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            suffix: Text("Minutes"),
                            hintText: "Duration",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1
                              )
                            ),
                            label: Text("Duration"),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _dateController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            hintText: "Date",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1
                              )
                            ),
                            label: Text("Date"),
                          ),
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 6)),
                            ).then((value) {
                              _dateController.text = DateFormat('yyyy-MM-dd').format(value!);
                            });
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (_titleController.text.isEmpty || _caloriesController.text.isEmpty || _durationController.text.isEmpty || _dateController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all field")));
                            return;
                          }
                          await post(Uri.http(url, "$endpoint/user/createTask"), body: {
                            "title": _titleController.text,
                            "calories": _caloriesController.text,
                            "duration": _durationController.text,
                            "date": _dateController.text,
                            "uid": dataUser['uid'].toString()
                          }).then((value) {
                            if (value.statusCode == 200) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Success create task"), backgroundColor: successColor));
                              getListTask();
                            }
                          });
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  );
                }
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const[
                  BoxShadow(
                    color: lowSecondaryColor,
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  ),
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: primary2Color
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Create Task",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.add),
                ],
              ),
            ),
          ),
          _isLoading ?
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(10),
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
          )
          :
          Expanded(
            child: ListView.builder(
              itemCount: listTask.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => BottomSheet(
                        onClosing: () {},
                        builder: (context) {
                          return Container(
                            color: Colors.white,
                            height: 120,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.edit),
                                  title: const Text("Edit"),
                                  onTap: () {
                                    Navigator.pop(context);
                                    final TextEditingController _titleController = TextEditingController(text: listTask[index]['title']);
                                    final TextEditingController _caloriesController = TextEditingController(text: listTask[index]['calories'].toString());
                                    final TextEditingController _durationController = TextEditingController(text: listTask[index]['duration'].toString());
                                    final TextEditingController _dateController = TextEditingController(text: listTask[index]['date']);
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: const Text("Edit Task"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                controller: _titleController,
                                                decoration: const InputDecoration(
                                                  hintText: "Title",
                                                  hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w400
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 1
                                                    )
                                                  ),
                                                  label: Text("Title"),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              TextField(
                                                controller: _caloriesController,
                                                keyboardType: TextInputType.number,
                                                decoration: const InputDecoration(
                                                  hintText: "Calories",
                                                  suffix: Text("Kcal"),
                                                  hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w400
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 1
                                                    )
                                                  ),
                                                  label: Text("Calories"),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              TextField(
                                                controller: _durationController,
                                                keyboardType: TextInputType.number,
                                                decoration: const InputDecoration(
                                                  hintText: "Duration",
                                                  suffix: Text("Minutes"),
                                                  hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w400
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 1
                                                    )
                                                  ),
                                                  label: Text("Duration"),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              TextField(
                                                controller: _dateController,
                                                readOnly: true,
                                                decoration: const InputDecoration(
                                                  hintText: "Date",
                                                  hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w400
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 1
                                                    )
                                                  ),
                                                  label: Text("Date"),
                                                ),
                                                onTap: () {
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime.now().add(const Duration(days: 6)),
                                                  ).then((value) {
                                                    _dateController.text = DateFormat('yyyy-MM-dd').format(value!);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                if (_titleController.text.isEmpty || _caloriesController.text.isEmpty || _durationController.text.isEmpty || _dateController.text.isEmpty) {
                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all field")));
                                                  return;
                                                }
                                                await put(Uri.http(url, "$endpoint/user/updateTask/${listTask[index]['id']}"), body: {
                                                  "title": _titleController.text,
                                                  "calories": _caloriesController.text,
                                                  "duration": _durationController.text,
                                                  "date": _dateController.text,
                                                }).then((value) {
                                                  if (value.statusCode == 200) {
                                                    Navigator.pop(context);
                                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Success update task"), backgroundColor: successColor));
                                                    getListTask();
                                                  }
                                                });
                                              },
                                              child: const Text("Save"),
                                            ),
                                          ],
                                        );
                                      }
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.delete),
                                  title: const Text("Delete"),
                                  onTap: () async {
                                    await delete(Uri.http(url, "$endpoint/user/deleteTask/${listTask[index]['id']}")).then((value) {
                                      if (value.statusCode == 200) {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Success delete task")));
                                        getListTask();
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const[
                        BoxShadow(
                          color: lowSecondaryColor,
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ]
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: primary2Color
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  listTask[index]['title'],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              formatStringDate(listTask[index]['date']),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w400
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${listTask[index]['calories']} Kcal",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  const Text(
                                    "Calories Burn",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${convertMinuteToHour(listTask[index]['duration'])} Hours",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  const Text(
                                    "Duration",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}