import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/input_field.dart';
import 'package:e_voting/widgets/signup_login_button.dart';
import 'package:flutter/material.dart';

class CreateElectionScreen extends StatelessWidget {
  const CreateElectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create Election"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: Constants.colors,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 42),
              const InputField(
                labeltext: 'Election name',
                hintText: "General Election",
              ),
              const InputField(
                labeltext: 'Date',
                hintText: "Example",
                fieldmessage: FieldMsgs.doe,
                readOnly: true,
              ),
              const InputField(
                labeltext: 'Start Time',
                hintText: "10:52 AM",
                fieldmessage: FieldMsgs.time,
              ),
              const InputField(
                labeltext: 'End Time',
                hintText: "10:52 AM",
                fieldmessage: FieldMsgs.time,
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
      ),
    );
  }
}
