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
  final TextEditingController _usernameController = TextEditingController();
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
    _usernameController.text = dataUser['username'];
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
        physics: ClampingScrollPhysics(),
        slivers: [
          const SliverAppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            elevation: 0,
            floating: true,
            pinned: true,
            centerTitle: true,
            leading: BackButton(
              color: Colors.black,
            ),
            title: Text(
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
                  buildTextField("Username", _usernameController, Icons.person),
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
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (rect) => const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
          ).createShader(rect),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
            ),
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
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (rect) => const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF9DCEFF), Color(0xFF92A3FD)],
          ).createShader(rect),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
            ),
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
          primary: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () {
          // Implement your button logic here
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
