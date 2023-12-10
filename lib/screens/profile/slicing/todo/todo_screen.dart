import 'package:flutter/material.dart';
import 'package:gimme/controller/todoController.dart';
import 'package:gimme/data/ToDo.dart';
import 'package:gimme/screens/profile/slicing/todo/todo_list.dart';
import 'package:gimme/constants.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

TextEditingController nama_todoController = TextEditingController();

class _ToDoScreenState extends State<TodoScreen> {
  var nama_todo = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Montserrat",
          ),
        ),
        centerTitle: true,
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
      body: FutureBuilder<List<ToDo>>(
        future: ToDoController().getToDoByUser(int.parse(dataUser['uid'])),
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
                                borderRadius: BorderRadius.circular(10)),
                            title: const Text('To-Do List',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                )),
                            content: Builder(builder: (context) {
                              var width =
                                  MediaQuery.of(context).size.width * 0.8;
                              return Container(
                                width: width,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: nama_todoController,
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        nama_todo = value;
                                      },
                                      decoration: const InputDecoration(
                                          hintText: 'Name of your To-Do List'),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            actions: <Widget>[
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
                                  ToDoController().createToDoByUser(
                                      int.parse(dataUser['uid']),
                                      nama_todoController.text);
                                  nama_todoController.clear();
                                  Navigator.of(context).pop();
                                  Navigator.pushNamed(
                                      context, '/profile/todolist');
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
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
                          ]),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [const Icon(Icons.add)],
                      ),
                    )),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ToDoList(
                            id_todo: snapshot.data![index].id_todo,
                            nama_todo: snapshot.data![index].nama_todo,
                            id_user: snapshot.data![index].id_user,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [const Icon(Icons.add)],
                  ),
                ));
          }
        },
      ),
    );
  }
}
