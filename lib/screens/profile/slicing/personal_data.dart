import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gimme/constants.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({Key? key}) : super(key: key);

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  bool isSwitched = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.text = dataUser['phoneNumber'];
    _heightController.text = dataUser['height'];
    _dateController.text = dataUser['dateofbirth'];
    _addressController.text = dataUser['address'];
    _weightController.text = dataUser['weight'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Personal Data',
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
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: Text(
                "Gimme menggunakan informasi ini untuk verifikasi identitas Anda dan Menjaga Keamanan komunitas kami.Anda yang menentukan detail pribadi yang dapat dilihat orang lain.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: "Montserrat",
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.only(left: 30,right: 30),
                        child: 
                          ShaderMask(
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (rect) =>
                                const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF9DCEFF),
                                Color(0xFF92A3FD)
                              ],
                            ).createShader(rect),
                            child: const Text(
                            "Phone Number",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600),
                          ),
                          ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.only(left: 30,right: 30),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(5)),
                        child: TextFormField(
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400
                          ),
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Your Phone Number",
                            prefixIcon: Icon(Icons.phone, color: Color(0xFF707070)),
                            labelStyle: TextStyle(
                                color: secondaryColor,
                                fontSize: 15,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600),
                            hintStyle: TextStyle(
                                color: secondaryColor,
                                fontSize: 15,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 30,right: 30),
                    child: 
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (rect) =>
                            const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF9DCEFF),
                            Color(0xFF92A3FD)
                          ],
                        ).createShader(rect),
                        child: const Text(
                        "Date of Birth",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        ),
                      ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 30,right: 30),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400),
                      controller: _dateController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd')
                                  .format(pickedDate);
                          setState(() {
                            _dateController.text = formattedDate;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.calendar_today,
                            color: Color(0xFF707070)),
                        labelStyle: TextStyle(
                            color: secondaryColor,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        hintText: "Enter Your Date of Birth",
                        hintStyle: TextStyle(
                            color: secondaryColor,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 30,right: 30),
                    child: 
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (rect) =>
                            const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF9DCEFF),
                            Color(0xFF92A3FD)
                          ],
                        ).createShader(rect),
                        child: const Text(
                        "Address",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        ),
                      ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 30,right: 30),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400),
                      controller: _addressController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Your Address",
                        prefixIcon: Icon(Icons.location_city,
                            color: Color(0xFF707070)),
                        labelStyle: TextStyle(
                            color: secondaryColor,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        hintStyle: TextStyle(
                            color: secondaryColor,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 30,right: 30),
                    child: 
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (rect) =>
                            const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF9DCEFF),
                            Color(0xFF92A3FD)
                          ],
                        ).createShader(rect),
                        child: const Text(
                        "Height",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        ),
                      ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 30,right: 30),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400),
                      controller: _heightController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        suffixText: 'Cm',
                        hintText: "Enter Your Height",
                        prefixIcon: Icon(Icons.height_rounded,
                            color: Color(0xFF707070)),
                        labelStyle: TextStyle(
                            color: secondaryColor,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        hintStyle: TextStyle(
                            color: secondaryColor,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 30,right: 30),
                    child: 
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (rect) =>
                            const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF9DCEFF),
                            Color(0xFF92A3FD)
                          ],
                        ).createShader(rect),
                        child: const Text(
                        "Weight",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        ),
                      ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 30,right: 30),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400),
                      controller: _weightController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        suffixText: 'Kg',
                        hintText: "Enter Your Weight",
                        prefixIcon: Icon(Icons.scale_rounded,
                            color: Color(0xFF707070)),
                        labelStyle: TextStyle(
                            color: secondaryColor,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600),
                        hintStyle: TextStyle(
                            color: secondaryColor,
                            fontSize: 15,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                   Container(
                    margin: const EdgeInsets.only(left: 30,right: 30),
                     child:
                       SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                              )
                            )
                          ),
                          onPressed: () {
                            Map<String, String> body = {
                              "username": dataUser['username'],
                              "name": dataUser['name'],
                              "email": dataUser['email'],
                              "dateofbirth": _dateController.text,
                              "phone_number": _phoneController.text,
                              "address": _addressController.text,
                              "height": _heightController.text,
                              "weight": _weightController.text,
                            };
                             put(Uri.http(url, "$endpoint/user/updateUser"), body: body).then((value) {
                              if (value.statusCode == 200) {
                                SharedPref.saveStr('phoneNumber', _phoneController.text);
                                SharedPref.saveStr('address', _addressController.text);
                                SharedPref.saveStr('dateofbirth', _dateController.text);
                                SharedPref.saveStr('height', _heightController.text);
                                SharedPref.saveStr('weight', _weightController.text);
                                dataUser['phoneNumber'] = _phoneController.text;
                                dataUser['address'] = _addressController.text;
                                dataUser['dateofbirth'] = _dateController.text;
                                dataUser['height'] = _heightController.text;
                                dataUser['weight'] = _weightController.text;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Data updated successfully"),
                                    backgroundColor: Colors.green,
                                  )
                                );
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Failed to update data"),
                                    backgroundColor: Colors.red,
                                  )
                                );
                              }
                            });
                          },
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                  ),
                   ),
              ],
            ),
            SizedBox(height: 100),
          ],
      ),
    ),
    );
  }
}
