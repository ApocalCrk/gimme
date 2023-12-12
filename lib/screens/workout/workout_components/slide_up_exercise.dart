import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';

class modalSlideUp extends StatefulWidget {
  const modalSlideUp({
    super.key,
    required this.data,
  });
  final data;

  @override
  _modalSlideUpState createState() => _modalSlideUpState();
}

class _modalSlideUpState extends State<modalSlideUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  width: 30.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.grey.shade400),
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 35.0, left: 15.0, bottom: 10.0),
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  widget.data['description_excercise'],
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 40.0, top: 30.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1.3,
                    decoration: BoxDecoration(color: Colors.grey.shade600),
                  ),
                ),
              )
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text('Stand',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text('Burn',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Text('Sets',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text('${widget.data['duration']} minutes',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 14,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w700,
                        )),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text('${widget.data['kalori']} cals',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 14,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w700,
                        )),
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: Text('${widget.data['set']}',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 14,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w700,
                        )),
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 20.0, top: 40.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1.3,
                    decoration: BoxDecoration(color: Colors.grey.shade600),
                  ),
                ),
              )
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Reps",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int i = 0; i < int.parse(widget.data['set']); i++)
                      Column(
                        children: [
                          Text(
                            widget.data['set'],
                            style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 63.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 3,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int i = 0; i < int.parse(widget.data['set']); i++)
                      Column(
                        children: [
                          Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                color: Colors.grey),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
              child: SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.13,
                        child: TextButton(
                          onPressed: () {
                            if(tempDataPlan.isEmpty){
                              tempDataPlan = {
                                "id_workout": widget.data['id_workout'],
                                "exercise_name": widget.data['exercise_name'],
                                "kalori": widget.data['kalori'],
                                "duration": widget.data['duration'],
                                "status": "start"
                              };
                              Navigator.pushNamed(context, '/dashboard', arguments: 1);
                            } else if(tempDataPlan['exercise_name'] != widget.data['exercise_name']){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("You have an exercise plan"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }else{
                              setState(() {
                                tempDataPlan = {};
                              });
                            }
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(primaryColor)),
                          child: Text(
                            tempDataPlan.isEmpty ? 
                              "Start Exercise" : tempDataPlan['exercise_name'] == widget.data['exercise_name'] ? "Stop Exercise" : "Start Exercise",
                            style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
