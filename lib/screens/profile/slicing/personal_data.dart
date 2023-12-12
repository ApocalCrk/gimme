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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = dataUser['name'];
    _emailController.text = dataUser['email'];
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
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            elevation: 0,
            floating: true,
            pinned: true,
            centerTitle: true,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false, arguments: 4);
              },
            ),
            title: const Text(
              "Personal Data",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  buildInformationText(),
                  const SizedBox(height: 10),
                  buildTextField("Name", _nameController, Icons.person),
                  const SizedBox(height: 10),
                  buildTextField("Email", _emailController, Icons.email),
                  const SizedBox(height: 10),
                  buildTextField("Phone Number", _phoneController, Icons.phone),
                  const SizedBox(height: 10),
                  buildDateField("Date of Birth", _dateController),
                  const SizedBox(height: 10),
                  buildTextField("Address", _addressController, Icons.location_on),
                  const SizedBox(height: 10),
                  buildTextField("Height", _heightController, Icons.height),
                  const SizedBox(height: 10),
                  buildTextField("Weight", _weightController, Icons.line_weight),
                  SizedBox(height: 20),
                  buildEditButton(context),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          )
        ],
      ),
    );    
  }

  Widget buildInformationText() {
    return const Text(
      "Gimme menggunakan informasi ini untuk verifikasi identitas Anda dan Menjaga Keamanan komunitas kami.Anda yang menentukan detail pribadi yang dapat dilihat orang lain.",
      style: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontFamily: "Montserrat",
      ),
      textAlign: TextAlign.justify,
    );
  }

  Widget buildDateField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5)),
          child: TextFormField(
            style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400),
            controller: controller,
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
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.calendar_today,
                  color: Color(0xFF707070)),
              labelStyle: const TextStyle(
                  color: secondaryColor,
                  fontSize: 15,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600),
              hintText: "Enter Your $label",
              hintStyle: const TextStyle(
                  color: secondaryColor,
                  fontSize: 15,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextField(String label, TextEditingController controller, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w400,
            ),
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter Your $label",
              prefixIcon: Icon(icon, color: const Color(0xFF707070)),
              labelStyle: const TextStyle(
                color: secondaryColor,
                fontSize: 15,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
              ),
              hintStyle: const TextStyle(
                color: secondaryColor,
                fontSize: 15,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEditButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () {
          Map<String, String> body = {
            "username": dataUser['username'],
            "name": _nameController.text,
            "email": _emailController.text,
            "dateofbirth": _dateController.text,
            "phone_number": _phoneController.text,
            "address": _addressController.text,
            "height": _heightController.text,
            "weight": _weightController.text,
          };
            put(Uri.http(url, "$endpoint/user/updateUser"), body: body).then((value) {
            if (value.statusCode == 200) {
              SharedPref.saveStr('name', _nameController.text);
              SharedPref.saveStr('email', _emailController.text);
              SharedPref.saveStr('phoneNumber', _phoneController.text);
              SharedPref.saveStr('address', _addressController.text);
              SharedPref.saveStr('dateofbirth', _dateController.text);
              SharedPref.saveStr('height', _heightController.text);
              SharedPref.saveStr('weight', _weightController.text);
              dataUser['name'] = _nameController.text;
              dataUser['email'] = _emailController.text;
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
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
