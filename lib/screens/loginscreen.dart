import 'package:e_voting/utils/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 52),
              const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff027314),
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff001403),
                ),
              ),
              const Center(),
              const SizedBox(
                height: 47,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(3, 10, 0, 0),
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff027314),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    labelStyle: const TextStyle(
                      fontSize: 18,
                    ),
                    prefixText: "  ",
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Constants.buttontextcolor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 14),
                  ),
                  //controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(3, 10, 0, 0),
                child: Text(
                  "Password",
                  style: TextStyle(
                    color: Color(0xff027314),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: "*************",
                    labelStyle: const TextStyle(
                      fontSize: 18,
                    ),
                    prefixText: "  ",
                    suffixIcon: const Icon(Icons.remove_red_eye),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 14),
                  ),
                  //controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(3, 10, 0, 0),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color(0xff027314),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    color: Constants.primarycolor,
                    textColor: Constants.buttontextcolor,
                    onPressed: () {},
                    child: const Text("Sign In"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    "Dont have an account?",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      " Sign up",
                      style: TextStyle(
                        color: Constants.primarycolor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
