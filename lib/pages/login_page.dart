import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/routes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!
        .validate()) //loginpage wil only go to homepage if all condtions are validated
    {
      setState(() {
        changeButton =
            true; // change button becomes true on ontap and setstate is called again
      });
      await Future.delayed(
          Duration(seconds: 1)); // wait for 1 second after ontap is executed
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: context.canvasColor,
        child: SingleChildScrollView(
          // allows screen to scroll so that bottom overflow error doesnt occur when widgets become of higher size
          child: Form(
            key: _formKey, // applied to both All TextFormField
            child: Column(
              //column has vertical as main axis
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/images/hey.png",
                  fit: BoxFit
                      .cover, //covers the entire target box cutting the image as less as possible
                ),
                // SizedBox(
                //   height: 20,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Welcome $name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                  child: Column(children: [
                    TextFormField(
                      //Textformfield provides validation , groups form entries(username,password,etc) together
                      decoration: InputDecoration(
                        hintText: "Enter Username",
                        labelText: "Username",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username cannot be empty";
                        }
                        return null; //means there is no error in value
                      },
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        }
                        if (value.length < 6) {
                          return "Password Length should be atleast 6  ";
                        }
                        return null; //means there is no error in value
                      },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Material(
                      //ancestor  of InkWell should be material
                      color: context.theme.splashColor,
                      borderRadius:
                          BorderRadius.circular(changeButton ? 50 : 8),
                      child: InkWell(
                        //InkWell works like container but gives effect
                        onTap: () => moveToHome(context),
                        child: AnimatedContainer(
                          //child should not have any decoration property, only ancestor should have
                          duration: Duration(seconds: 1),
                          height: 50,
                          width: changeButton
                              ? 50
                              : 130, //if change button is true do width=50 else 130.
                          alignment: Alignment.center,
                          child: changeButton
                              ? Icon(
                                  Icons.done,
                                  color: Colors.white,
                                )
                              : Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),

                          // shape: changeButton?BoxShape.circle:BoxShape.rectangle ,
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
