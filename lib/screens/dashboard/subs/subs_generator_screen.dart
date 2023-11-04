import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';

class SubsGeneratorScreen extends StatefulWidget {
  const SubsGeneratorScreen({Key? key}) : super(key: key);

  
  @override
  _SubsGeneratorScreenState createState() => _SubsGeneratorScreenState();
}

class _SubsGeneratorScreenState extends State<SubsGeneratorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.black.withOpacity(0.7),
                      size: 40
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  Text(
                    "Generate  QR",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 25,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  const SizedBox(width: 30)
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Select Gyms",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: ((context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 5,
                            offset: const Offset(0, 0)
                          )
                        ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage("assets/images/gym_images/sonoma.jpg"),
                            radius: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama Gym",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 20,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Row(
                                children: [
                                  Transform(
                                    transform: Transform.translate(
                                      offset: const Offset(-5, 0)
                                    ).transform,
                                    child: const Icon(
                                      Icons.star_rounded,
                                      color: Colors.yellow,
                                      size: 25
                                    ),
                                  ),
                                  Transform(
                                    transform: Transform.translate(
                                      offset: const Offset(-5, 0)
                                    ).transform,
                                    child: Text("4.8", style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 15,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600
                                    ),),
                                  ),
                                ],
                              ),
                              index == 1 ?
                              const Text(
                                "Code Expired in 12:00:00",
                                style: TextStyle(
                                  color: errorColor,
                                  fontSize: 10,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600
                                ),
                              )
                              :
                              const SizedBox()
                            ],
                          ),
                          InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4,
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 30, bottom: MediaQuery.of(context).size.height / 30),
                              decoration: BoxDecoration(
                                color: (index == 1) ? warningColor : primaryColor,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text(
                                (index == 1) ? "Ongoing" : "Generate",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600
                                ),
                              )
                            ),
                            onTap: () => Navigator.pushNamed(context, '/subs/generate'),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
      
            ],
          ),
        ),
      ),
    );
  }
}