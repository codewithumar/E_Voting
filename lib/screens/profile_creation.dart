import 'package:e_voting/screens/login_screen.dart';
import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/sign_up_fields.dart';

import 'package:flutter/material.dart';

class ProfileCreation extends StatefulWidget {
  const ProfileCreation({super.key});

  @override
  State<ProfileCreation> createState() => _ProfileCreationState();
}

class _ProfileCreationState extends State<ProfileCreation> {
  late double height = MediaQuery.of(context).size.height;
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController mothernamecontroller = TextEditingController();
  TextEditingController currentaddresscontroller = TextEditingController();
  TextEditingController permanentaddresscontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.07,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Profile Creation",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Constants.primarycolor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Constants.greyColor,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add_photo_alternate_rounded,
                          color: Constants.primarycolor,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Your Name Here",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff027314),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "youremail@gmail.com",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Constants.greyColor,
                      ),
                    ),
                  ),
                ),
                InputField(
                  label: 'Phone Number',
                  labelText: '0900-78601',
                  controller: phonecontroller,
                ),
                InputField(
                  label: "Mother's Name",
                  labelText: "Alexa",
                  controller: mothernamecontroller,
                ),
                InputField(
                  label: 'Permanent Adress',
                  labelText: 'Rab Nawaz Colony',
                  controller: permanentaddresscontroller,
                ),
                InputField(
                  label: 'Email',
                  labelText: 'example@gmail.com',
                  controller: emailcontroller,
                ),
                InputField(
                  label: 'Current Address',
                  labelText: 'Mullah Ki Basti',
                  controller: currentaddresscontroller,
                ),
                //  const SignupLoginButton(btnText: 'Create Profile'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Constants.greyColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (Route<dynamic> route) => false);
                        },
                        child: const Text(
                          " Login",
                          style: TextStyle(
                            color: Constants.primarycolor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
