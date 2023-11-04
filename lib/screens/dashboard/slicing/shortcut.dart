import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';

// ignore: must_be_immutable
class Shortcut extends StatelessWidget {
  Map<int, Map<dynamic, String>> shortcut;
  Shortcut({super.key, required this.shortcut});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: shortcut.length+1,
        itemBuilder: (context, index) {
          return 
          index == shortcut.length ?
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: lowSecondaryColor,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: const Center(
                  child: Icon(Icons.add, color: Colors.white, size: 30)
                ),
              ),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 15),
                child: const Text(
                  "Add",
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                  ),
                ),
              )
            ],
          )
          :
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(int.parse(shortcut[index+1]!["Color"]!)),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Center(
                  child: Image.asset(shortcut[index+1]!["icon"]!, width: 30, height: 30)
                ),
              ),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 15),
                child: Text(
                  shortcut[index + 1]!["title"]!,
                  style: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}