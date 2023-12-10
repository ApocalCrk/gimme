import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ActivityHistory extends StatefulWidget {
  const ActivityHistory({super.key});

  @override
  State<ActivityHistory> createState() => _ActivityHistoryState();
}

class _ActivityHistoryState extends State<ActivityHistory> {
  List<Text> myText = [
    const Text("Chest Workout"),
    const Text("Leg Workout"),
    const Text("Back Workout"),
    const Text("Shoulder Workout"),
    const Text("Arm Workout"),
    const Text("Chest Workout"),
    const Text("Leg Workout"),
    const Text("Back Workout"),
    const Text("Shoulder Workout"),
    const Text("Arm Workout"),
    const Text("Chest Workout"),
    const Text("Leg Workout"),
    const Text("Back Workout"),
    const Text("Shoulder Workout"),
    const Text("Arm Workout"),
    const Text("Chest Workout"),
    const Text("Leg Workout"),
    const Text("Back Workout"),
    const Text("Shoulder Workout"),
    const Text("Arm Workout"),
    const Text("Chest Workout"),
    const Text("Leg Workout"),
    const Text("Back Workout"),
    const Text("Shoulder Workout"),
    const Text("Arm Workout"),
  ];
  List<String> myImage = [
    
        "https://cdn0-production-images-kly.akamaized.net/tLqQ9BQmDFMQIEm7gYIpZ4jik-4=/0x41:783x482/800x450/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3551902/original/078763900_1629962940-chika01.JPG",
        "https://cdn0-production-images-kly.akamaized.net/tLqQ9BQmDFMQIEm7gYIpZ4jik-4=/0x41:783x482/800x450/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3551902/original/078763900_1629962940-chika01.JPG",
        "https://cdn0-production-images-kly.akamaized.net/tLqQ9BQmDFMQIEm7gYIpZ4jik-4=/0x41:783x482/800x450/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3551902/original/078763900_1629962940-chika01.JPG",
        "https://cdn0-production-images-kly.akamaized.net/tLqQ9BQmDFMQIEm7gYIpZ4jik-4=/0x41:783x482/800x450/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3551902/original/078763900_1629962940-chika01.JPG",
        "https://cdn0-production-images-kly.akamaized.net/tLqQ9BQmDFMQIEm7gYIpZ4jik-4=/0x41:783x482/800x450/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3551902/original/078763900_1629962940-chika01.JPG",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activity History',
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
      body: ListView.builder(
          itemCount: myText.length,
          itemBuilder: (context, index) {
            return Container(
              height: 200,
              child: TimelineTile(
                alignment: TimelineAlign.manual,
                lineXY: 0.2,
                isLast: index == myText.length - 1 ? true : false,
                startChild: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text("15 Oct"),
                ),
                endChild: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.1,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: myImage.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                              height: 140,
                              width: 80,
                              padding: EdgeInsets.only(top: 10),
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage(
                                          myImage[index]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                    child:
                                      Text(
                                        "chest workout",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600
                                        ),
                                        textAlign: TextAlign.center
                                      ),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    )),
              ),
            );
          }),
    );
  }
}
