//import 'package:ayto_driver_x/home.dart';
import 'package:ayto_driver_x/progressdialogue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';

import 'brand_colors.dart';
import 'home.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final GlobalKey<ScaffoldState> scaffoldkey= GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth =FirebaseAuth.instance;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var addressController=TextEditingController();
  void showSnackBar(String title){
  final snackBar = SnackBar(content: Text(title, textAlign: TextAlign.center,style: const TextStyle(
  fontSize: 15,
  ),));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void registerUser() async{
    final User user=_auth.currentUser!;
    final id=user.uid;

  showDialog(
  barrierDismissible: false,
  context: context,
  builder: (BuildContext context) => ProgressDialog(status: 'Registering you...',),
  );
  DatabaseReference dref = FirebaseDatabase.instance.ref().child("Driver/${user.uid}");
  Map map={
  'FirstName':firstNameController.text,
    'LastName':lastNameController.text,
    'Address':addressController.text,
    'Email':emailController.text,
    'AlternatePhoneNumber':user.phoneNumber,
};
    dref.set(map);

  }


  @override
  Widget build(BuildContext context) {


  return  Scaffold(
  body: SingleChildScrollView(
  child: Column(
  children: [
  const SizedBox(
  width: 350,
  height: 50,
  ),
  const Center(
  child: Text("Sign Up",style: TextStyle(
  fontSize: 28,
  color: BrandColors.enterphonenumber
  ),),
  ),
  /*EditTextMy.space,
  Image.asset("assets/images/login1.png",
  fit: BoxFit.cover,
  height: 100,),*/
  EditTextMy.space,
  Container(
  width: 250,
  height: 50,
  decoration: BoxDecoration(
  color: BrandColors.editText,
  borderRadius: BorderRadius.circular(5),
  ),
  child: Padding(
  padding: const EdgeInsets.all(10),
  child: TextFormField(
  controller: firstNameController,
  decoration: const InputDecoration(
  hintText: "First Name",
  hintStyle: TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w600
  )
  ),
  ),
  ),
  ),
  EditTextMy.space,
  Container(
  width: 250,
  height: 50,
  decoration: BoxDecoration(
  color: BrandColors.editText,
  borderRadius: BorderRadius.circular(5),
  ),
  child: Padding(
  padding: const EdgeInsets.all(10),
  child: TextFormField(
  controller: lastNameController,
  decoration: const InputDecoration(
  hintText: "Last Name",
  hintStyle: TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w600
  )
  ),
  ),
  ),
  ),
    EditTextMy.space,
    Container(
      width: 250,
      height: 50,
      decoration: BoxDecoration(
        color: BrandColors.editText,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: addressController,
          decoration: const InputDecoration(
              hintText: "Address",
              hintStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600
              )
          ),
        ),
      ),
    ),
  /*EditTextMy.space,
  Container(
  width: 250,
  height: 50,
  decoration: BoxDecoration(
  color: BrandColors.editText,
  borderRadius: BorderRadius.circular(5),
  ),
  child: Padding(
  padding: const EdgeInsets.all(10),
  child: TextFormField(
  controller: phoneController,
  decoration: const InputDecoration(
  hintText: "Alternate Phone Number",
  hintStyle: TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w600
  )
  ),
  )
  ),
  ),*/
  EditTextMy.space,
  Container(
  width: 250,
  height: 50,
  decoration: BoxDecoration(
  color: BrandColors.editText,
  borderRadius: BorderRadius.circular(5),
  ),
  child: Padding(
  padding: const EdgeInsets.all(10),
  child: TextFormField(
  controller: emailController,
  decoration: const InputDecoration(
  hintText: "Email ID",
  hintStyle: TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w600
  )
  ),
  )
  ),
  ),

  EditTextMy.space,
  EditTextMy.space,
  SizedBox(
  width: 100,
  height: 35,
  child: ElevatedButton(
  onPressed: (){

 /* if(phoneController.text.length !=10){
  showSnackBar("Invalid Phone Number");
  return;
  }*/
  if(firstNameController.text.isEmpty){
  showSnackBar("This field cannot be empty");
  return;

  }
  if(addressController.text.isEmpty){
    showSnackBar("This field cannot be empty");
    return;

  }
  if(!emailController.text.contains("@")){
  showSnackBar("Invaild Email ID");
  return;

  }

  registerUser();

  //DatabaseReference dref =FirebaseDatabase.instance.ref().child("Driver");
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const Home(),
    ),
  );
  },

  child: const Text("Proceed"),
  style: ElevatedButton.styleFrom(
  primary: BrandColors.button,
  onPrimary: Colors.black


  ),
  ))
  ],
  ),



  ),
  );
  }

  }
  class EditTextMy{
  static const space = SizedBox(
  width:28,
  height: 28,
  );

  }