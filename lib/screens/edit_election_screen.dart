import 'package:e_voting/models/election_model.dart';
import 'package:e_voting/providers/firestore_provider.dart';

import 'package:e_voting/utils/constants.dart';
import 'package:e_voting/widgets/dropdownmenu.dart';
import 'package:e_voting/widgets/input_field.dart';
import 'package:e_voting/widgets/signup_login_button.dart';
import 'package:e_voting/widgets/toast.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditElectionScreen extends StatefulWidget {
  const EditElectionScreen({required this.data, super.key});
  final ElectionModel data;

  @override
  State<EditElectionScreen> createState() => _EditElectionScreenState();
}

final _toast = FToast();
final _electionnamecontroller = TextEditingController();
final _electiondatecontroller = TextEditingController();
final _electionstarttimecontroller = TextEditingController();
final _electionendtimecontroller = TextEditingController();
final _electionmaxvotetimecontroller = TextEditingController();

class _EditElectionScreenState extends State<EditElectionScreen> {
  @override
  void initState() {
    _toast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _electionnamecontroller.text = widget.data.electioname;
    _electiondatecontroller.text = widget.data.electiondate;
    _electionstarttimecontroller.text = widget.data.electionstarttime;
    _electionendtimecontroller.text = widget.data.electionendtime;
    _electionmaxvotetimecontroller.text = widget.data.electionmaxvotetime;
    final editelectionformkey = GlobalKey<FormState>();
    return Form(
      key: editelectionformkey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.data.electioname),
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
                InputField(
                  labeltext: 'Election name',
                  hintText: "General Election",
                  errormessage: "Pelase input election name",
                  controller: _electionnamecontroller,
                ),
                InputField(
                  labeltext: 'Date',
                  hintText: "Example",
                  fieldmessage: FieldMsgs.doe,
                  readOnly: true,
                  errormessage: "Pelase input election date",
                  controller: _electiondatecontroller,
                ),
                InputField(
                  controller: _electionstarttimecontroller,
                  readOnly: true,
                  labeltext: 'Start Time',
                  hintText: "10:52 AM",
                  fieldmessage: FieldMsgs.electiontime,
                  errormessage: "Pelase input election start time",
                ),
                InputField(
                  controller: _electionendtimecontroller,
                  readOnly: true,
                  labeltext: 'End Time',
                  hintText: "10:52 AM",
                  fieldmessage: FieldMsgs.electiontime,
                  errormessage: "Pelase input election end time",
                ),
                InputField(
                  controller: _electionmaxvotetimecontroller,
                  labeltext: 'Max Votes',
                  hintText: "120",
                  errormessage: "Pelase input total vote count limit",
                ),
                const DropDownMenu(),
                const SizedBox(height: 23),
                SignupLoginButton(
                  formkey: editelectionformkey,
                  isLoading: true,
                  btnText: 'update',
                  function: () async {
                    await updateelection();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateelection() async {
    if (_electionstarttimecontroller.text == _electionendtimecontroller.text) {
      _toast.showToast(
        child: buildtoast("Time cannot be same", "error"),
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    final data = ElectionModel(
      id: widget.data.id,
      electioname: _electionnamecontroller.text,
      electiondate: _electiondatecontroller.text,
      electionstarttime: _electionstarttimecontroller.text,
      electionendtime: _electionendtimecontroller.text,
      electionmaxvotetime: _electionmaxvotetimecontroller.text,
    );
    await context.read<FirestoreProvider>().updateElection(data);
  }
}
