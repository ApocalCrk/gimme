import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';

class modalSlideUp extends StatelessWidget {
  const modalSlideUp({
    super.key,
    required this.data,
  });
  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
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
                  data['description_excercise'],
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
                    child: Text('${data['duration']} minutes',
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
                    child: Text('${data['kalori']} cals',
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
                    child: Text('${data['set']}',
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
                    for (int i = 0; i < int.parse(data['set']); i++)
                      Column(
                        children: [
                          Text(
                            data['set'],
                            style: TextStyle(
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 63.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 3,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (int i = 0; i < int.parse(data['set']); i++)
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
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 0.13,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Start",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(primaryColor)),
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
