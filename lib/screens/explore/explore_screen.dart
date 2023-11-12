import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gimme/constants.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:gimme/screens/dashboard/slicing/dashboard_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController controllerSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                Container(
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
                            offset: const Offset(0, 0))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Location",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 15,
                            fontFamily: "Montserrat"),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            "Kalasan, Sleman",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 30,
                  child: IconButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, "/explore/map"),
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.black.withOpacity(0.7),
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                SizedBox(height: 24),
                TextFormField(
                  controller: controllerSearch,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, "/explore/qrScanner"),
                      icon: Icon(
                        Icons.qr_code_scanner,
                        color: Colors.black.withOpacity(0.7),
                        size: 30,
                      ),
                    ),
                    labelText: "Search Here...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            buildCard(context),
            buildCard(context),
            buildCard(context),
            buildCard(context),
            buildCard(context),
            buildCard(context),
            buildCard(context),
          ],
        ),
      ),
    ));
  }
}

Card buildCard(BuildContext context) {
  var cardImage = NetworkImage(
      'https://images.pexels.com/photos/1954524/pexels-photo-1954524.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2');
  var supportingText =
      'Beautiful home to rent, recently refurbished with modern appliances...';
  return Card(
      elevation: 4.0,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            child: Ink.image(
              image: cardImage,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Fathur Gym",
                  style: TextStyle(
                    color: Colors.black.withOpacity(1),
                    fontSize: 25,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(), // Spacer untuk mengisi ruang kosong
                Row(
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (rect) => LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
                      ).createShader(rect),
                      child: Icon(
                        Icons.access_time_outlined,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "08.00-20.00",
                      style: TextStyle(
                        color: Colors.black.withOpacity(1),
                        fontSize: 15,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(right: 16.0, left: 10.0, top: 5.0),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 25,
                  color: Colors.black.withOpacity(0.5),
                ),
                Text(
                  "Jl.Buah Apel No.62,Kalasan",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 15,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
                right: 16.0, left: 16.0, bottom: 5.0, top: 10.0),
            alignment: Alignment.centerLeft,
            child: Text(supportingText,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600)),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 5),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("People Has Joined",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 12,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          )),
                      Stack(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                            child: ClipOval(
                                child: Image.network(
                              "https://images.pexels.com/photos/38630/bodybuilder-weight-training-stress-38630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                              fit: BoxFit.cover,
                            )),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                            child: ClipOval(
                                child: Image.network(
                              "https://images.pexels.com/photos/38630/bodybuilder-weight-training-stress-38630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                              fit: BoxFit.cover,
                            )),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 30),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                            child: ClipOval(
                                child: Image.network(
                              "https://images.pexels.com/photos/38630/bodybuilder-weight-training-stress-38630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                              fit: BoxFit.cover,
                            )),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 65, top: 7),
                            child: Text("+ 20 others",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontSize: 10,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF9DCEFF),
                            Color(0xFF92A3FD)
                          ], // Ganti warna sesuai keinginan
                        ),
                      ),
                      child: TextButton(
                        child: const Text(
                          'Detail',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, "/explore/gymDetails"),
                      ))
                ],
              )),
        ],
      ));
}

buildBox() {
  Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.white, width: 2)),
      child: ClipOval(
          child: Image.network(
              "https://images.pexels.com/photos/38630/bodybuilder-weight-training-stress-38630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
              fit: BoxFit.cover)));
}
