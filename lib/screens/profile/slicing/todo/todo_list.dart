import 'package:flutter/material.dart';
import 'package:gimme/controller/todoController.dart';
import 'package:gimme/controller/todoItemController.dart';
import 'package:gimme/data/ToDo.dart';
import 'package:gimme/data/ToDoItem.dart';
import 'package:gimme/screens/profile/slicing/todo/todo_detail.dart';

class ToDoList extends StatelessWidget {
  final int id_todo;
  final String nama_todo;
  final int id_user;
  const ToDoList(
      {super.key,
      required this.id_todo,
      required this.nama_todo,
      required this.id_user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nama_todo,
                style: const TextStyle(
                    color: Color(0xff000000),
                    fontSize: 18,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //edit button
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ToDoDetails(
                              id_todo: id_todo,
                              nama_todo: nama_todo,
                              id_user: id_user))
                      );
                    },
                    child:  Icon(
                      Icons.edit,
                      color: const Color(0xff000000),
                      size: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: const Text(
                                "Are you sure you want to delete this To-Do List?",
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 15,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w600)),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 15,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  ToDoController().deleteToDo(id_todo);
                                  Navigator.pushNamed(
                                      context, '/profile/todolist');
                                },
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 47, 47),
                                      fontSize: 15,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.delete,
                      color: const Color(0xff000000),
                      size: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            color: Color(0xff000000),
            thickness: 1,
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            margin: const EdgeInsets.only(bottom: 10),
            height: MediaQuery.of(context).size.height * 0.1,
            child: FutureBuilder(
              future: ToDoItemController().getToDoItemByToDoId(id_todo),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("error"),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No To-Do Item",
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 12,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600)
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              snapshot.data![index].todo_item,
                              style: const TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              snapshot.data![index].formatedTime(),
                              style: const TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      "No To-Do Item",
                      style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 12,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
