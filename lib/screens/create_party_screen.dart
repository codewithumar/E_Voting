import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/input_field.dart';
import 'package:e_voting/widgets/signup_login_button.dart';
import 'package:flutter/material.dart';

class CreatePartyScreen extends StatelessWidget {
  const CreatePartyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create Party"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: Constants.colors,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 70,
                  width: 70,
                  // foregroundDecoration: (users[0].url != 'null')
                  //     ? BoxDecoration(
                  //         image: DecorationImage(
                  //           image: NetworkImage(users[0].url),
                  //           fit: BoxFit.fill,
                  //         ),
                  //       )
                  //     : null,
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
                    onPressed: () {
                      // selectFile(users[0].id);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 59),
            const InputField(
              labeltext: 'Party Name  ',
              hintText: "Example",
              //controller: doeController,
            ),
            const SizedBox(height: 23),
            SignupLoginButton(
              isLoading: false,
              btnText: 'Add',
              function: () {},
            ),
          ],
        ),
      ),
    );
  }
}
