import 'package:flutter/material.dart';
import 'package:gimme/controller/todoController.dart';
import 'package:gimme/controller/todoItemController.dart';
import 'package:gimme/data/ToDo.dart';
import 'package:gimme/data/ToDoItem.dart';
import 'package:sprintf/sprintf.dart';

class ToDoDetails extends StatefulWidget {
  final int id_todo;
  final String nama_todo;
  final int id_user;
  const ToDoDetails(
      {Key? key,
      required this.id_todo,
      required this.nama_todo,
      required this.id_user})
      : super(key: key);

  @override
  State<ToDoDetails> createState() => _ToDoDetailsState();
}

TextEditingController todo_nameController = TextEditingController();
TextEditingController todo_itemController = TextEditingController();
TextEditingController timeController = TextEditingController();

class _ToDoDetailsState extends State<ToDoDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 20),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  todo_nameController.text = widget.nama_todo;
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        title: const Text('Edit To-Do'),
                        content: Builder(builder: (context) {
                          var width = MediaQuery.of(context).size.width * 0.8;
                          return Container(
                            width: width,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: todo_nameController,
                                  decoration: const InputDecoration(
                                    hintText: "To-Do Name",
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        actions: [
                          TextButton(
                            child: const Text('CANCEL',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                )),
                            onPressed: () {
                              todo_itemController.clear();
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: const Text('SUBMIT',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                )),
                            onPressed: () {
                              ToDoController().updateToDo(
                                  widget.id_todo, todo_nameController.text);
                              todo_nameController.clear();
                              Navigator.of(context).pop();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => ToDoDetails(
                                          id_todo: widget.id_todo,
                                          nama_todo: widget.nama_todo,
                                          id_user: widget.id_user)));
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  widget.nama_todo,
                  style: const TextStyle(
                      color: Color(0xff000000),
                      fontSize: 20,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Expanded(
              child: FutureBuilder(
                future:
                    ToDoItemController().getToDoItemByToDoId(widget.id_todo),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  } else if (snapshot.hasData) {
                    return Column(
                      children: [
                        InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    title: const Text('Add To-Do Activity'),
                                    content: Builder(builder: (context) {
                                      // var height = MediaQuery.of(context).size.height * 0.8;
                                      var width =
                                          MediaQuery.of(context).size.width *
                                              0.8;
                                      return Container(
                                        // height: height,
                                        width: width,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextField(
                                              controller: todo_itemController,
                                              decoration: const InputDecoration(
                                                hintText: "To-Do Activity",
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            //textfield with timepicker
                                            TextField(
                                              controller: timeController,
                                              keyboardType:
                                                  TextInputType.datetime,
                                              decoration: const InputDecoration(
                                                hintText: "Time",
                                              ),
                                              onTap: () {
                                                //24 hour time picker
                                                showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                  builder:
                                                      (BuildContext context,
                                                          Widget? child) {
                                                    return MediaQuery(
                                                      data: MediaQuery.of(
                                                              context)
                                                          .copyWith(
                                                              alwaysUse24HourFormat:
                                                                  true),
                                                      child: child!,
                                                    );
                                                  },
                                                ).then((value) {
                                                  if (value == null) return;
                                                  timeController.text = sprintf(
                                                      '%02d:%02d', [
                                                    value.hour,
                                                    value.minute
                                                  ]);
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                                    actions: [
                                      TextButton(
                                        child: const Text('CANCEL',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Montserrat",
                                            )),
                                        onPressed: () {
                                          todo_itemController.clear();
                                          timeController.clear();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ElevatedButton(
                                        child: const Text('SUBMIT',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Montserrat",
                                            )),
                                        onPressed: () {
                                          // do something with the input text
                                          ToDoItemController()
                                              .createToDoItemByToDoId(
                                                  widget.id_todo,
                                                  todo_itemController.text,
                                                  timeController.text);
                                          todo_itemController.clear();
                                          timeController.clear();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ToDoDetails(
                                                          id_todo:
                                                              widget.id_todo,
                                                          nama_todo:
                                                              widget.nama_todo,
                                                          id_user:
                                                              widget.id_user)));
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10.0),
                              decoration: BoxDecoration(
                                color: const Color(0xffFFFFFF),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 0.1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [const Icon(Icons.add)],
                              ),
                            )),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  //edit todo activity
                                  todo_itemController.text =
                                      snapshot.data![index].todo_item;
                                  timeController.text =
                                      formatedTime(snapshot.data![index].time);
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        title: const Text('Edit To-Do Activity',
                                            style: TextStyle(
                                              color: Color(0xff000000),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Montserrat",
                                            )),
                                        content: Builder(builder: (context) {
                                          // var height = MediaQuery.of(context).size.height * 0.8;
                                          var width = MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8;
                                          return Container(
                                            // height: height,
                                            width: width,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller:
                                                      todo_itemController,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: "To-Do Activity",
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                //textfield with timepicker
                                                TextField(
                                                  controller: timeController,
                                                  keyboardType:
                                                      TextInputType.datetime,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: "Time",
                                                  ),
                                                  onTap: () {
                                                    //24 hour time picker
                                                    showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                      builder:
                                                          (BuildContext context,
                                                              Widget? child) {
                                                        return MediaQuery(
                                                          data: MediaQuery.of(
                                                                  context)
                                                              .copyWith(
                                                                  alwaysUse24HourFormat:
                                                                      true),
                                                          child: child!,
                                                        );
                                                      },
                                                    ).then((value) {
                                                      if (value == null) return;
                                                      timeController.text =
                                                          sprintf('%02d:%02d', [
                                                        value.hour,
                                                        value.minute
                                                      ]);
                                                      ;
                                                    });
                                                  },
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                        actions: [
                                          TextButton(
                                            child: const Text('CANCEL',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Montserrat",
                                                )),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('SUBMIT',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Montserrat",
                                                )),
                                            onPressed: () {
                                              // do something with the input
                                              ToDoItemController()
                                                  .updateToDoItem(
                                                      snapshot.data![index]
                                                          .id_todo_item,
                                                      todo_itemController.text,
                                                      timeController.text);
                                              todo_itemController.clear();
                                              timeController.clear();
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ToDoDetails(
                                                              id_todo: widget
                                                                  .id_todo,
                                                              nama_todo: widget
                                                                  .nama_todo,
                                                              id_user: widget
                                                                  .id_user)));
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffFFFFFF),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 0.1,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    // title: const Text('Delete To-Do Item'),
                                                    content: const Text(
                                                        'Are you sure you want to delete this To-Do Activity?'),
                                                    actions: [
                                                      TextButton(
                                                        child: const Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "Montserrat",
                                                            )),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xffFF0000),
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "Montserrat",
                                                            )),
                                                        onPressed: () {
                                                          ToDoItemController()
                                                              .deleteToDoItem(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .id_todo_item);
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                              builder: (context) => ToDoDetails(
                                                                  id_todo: widget
                                                                      .id_todo,
                                                                  nama_todo: widget
                                                                      .nama_todo,
                                                                  id_user: widget
                                                                      .id_user)));
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: Color(0xff000000),
                                              size: 14,
                                            ),
                                          ),
                                          Text(snapshot.data![index].todo_item,
                                              style: const TextStyle(
                                                  color: Color(0xff000000),
                                                  fontSize: 12,
                                                  fontFamily: "Montserrat",
                                                  fontWeight: FontWeight.w600))
                                        ],
                                      ),
                                      Text(snapshot.data![index].formatedTime(),
                                          style: const TextStyle(
                                              color: Color(0xff000000),
                                              fontSize: 12,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text("No Data"),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String formatedTime(TimeOfDay? time) {
    return '${time!.hour}:${time.minute}';
  }
}
