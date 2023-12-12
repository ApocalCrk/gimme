import 'package:flutter/material.dart';
import 'package:gimme/constants.dart';
import 'package:gimme/controller/generatorController.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}
class _MembershipScreenState extends State<MembershipScreen> {
  List<dynamic> dataMembership = [];

  showMembership(uid) async {
    var allData = await GeneratorController().showAllMembership(uid);
    setState(() {
      dataMembership = allData;
    });
  }

  @override
  void initState() {
    super.initState();
    showMembership(dataUser['uid']);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Membership',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: dataMembership.isEmpty ? Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: lowSecondaryColor,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ]
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'You don\'t have any membership',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'You can buy membership in the gym that you want to join',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          )
                        )
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/dashboard', arguments: 3);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          'Find Gym',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ) :
              ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dataMembership.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: lowSecondaryColor,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      dataMembership[index]['gym']['name'],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      dataMembership[index]['gym']['place'],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          formatStringDate(dataMembership[index]['start_date']),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          formatStringDate(dataMembership[index]['end_date']),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                dataMembership[index]['transaction']['type_membership'] == '1 Month Membership' ? 
                                Navigator.pushNamed(context, '/gym/checkout', arguments: {
                                  'id_transaction': dataMembership[index]['transaction']['id_transaction'],
                                  'id_gym': dataMembership[index]['gym']['id_gym'],
                                  'bundle': dataMembership[index]['transaction']['bundle'],
                                  'name': dataMembership[index]['gym']['name'],
                                  'place': dataMembership[index]['gym']['place'],
                                  'price': dataMembership[index]['gym']['packages'][
                                    dataMembership[index]['transaction']['bundle'] == 'Gold Membership' ? 
                                    'Gold' : dataMembership[index]['transaction']['bundle'] == 'Silver Membership' ?
                                    'Silver' : 'Bronze'
                                  ]['price']['yearly'],
                                  'type': 'Membership',
                                  'duration_update': '1 Year Membership',
                                  "status": "update"
                                })
                                :
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('You can\'t update this membership'),
                                    backgroundColor: errorColor,
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Center(
                                  child: Text(
                                    'Update Plan',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context, 
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Cancel Membership",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      content: const Text("Are you sure want to cancel this membership?",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text(
                                            "No",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await GeneratorController().cancelMembership(dataMembership[index]['id']).then((value) {
                                              if (value == 'success') {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Membership canceled'),
                                                    backgroundColor: successColor,
                                                  ),
                                                );
                                                setState(() {
                                                  showMembership(dataUser['uid']);
                                                });
                                              }else{
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Failed to cancel membership'),
                                                    backgroundColor: errorColor,
                                                  ),
                                                );
                                              }
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Yes",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: errorColor,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Center(
                                  child: Text(
                                    'Cancel Plan',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  );
                },
              ),
            )
          ],
        )
      ),
    );
  }
}
