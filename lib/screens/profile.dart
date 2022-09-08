import 'package:flutter/material.dart';

import 'package:e_voting/utils/constants.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late double height = MediaQuery.of(context).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Constants.primarycolor),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: <Widget>[
          MaterialButton(
            textColor: Colors.white,
            onPressed: () {},
            shape:
                const CircleBorder(side: BorderSide(color: Colors.transparent)),
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Constants.primarycolor,
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 70,
                      width: 70,
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
                    alignment: Alignment.center,
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
                    alignment: Alignment.center,
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
                // const InputField(
                //   label: 'Full Name',
                //   labelText: 'Your Full Name here',
                // ),
                // const InputField(
                //   label: 'Email',
                //   labelText: 'example@gmail.com',
                // ),
                // const InputField(
                //   label: 'Password',
                //   labelText: '***************',
                //   obscure: true,
                // ),
                // const InputField(
                //   label: 'CNIC',
                //   labelText: '37406-3675252-1',
                // ),
                // const InputField(
                //   label: 'Date of Expiry',
                //   labelText: '02/22',
                // ),
                // const InputField(
                //   label: 'Phone Number',
                //   labelText: '0900-78601',
                // ),
                // const InputField(
                //   label: "Mother's Name",
                //   labelText: "Alexa",
                // ),
                // const InputField(
                //   label: 'Permanent Adress',
                //   labelText: 'Rab Nawaz Colony',
                // ),
                // const InputField(
                //   label: 'Current Address',
                //   labelText: 'Mullah Ki Basti',
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
