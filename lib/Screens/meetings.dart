import 'package:dnlf_support_app/firestore_functions.dart';
import 'package:flutter/material.dart';

class MeetingsContainer extends StatefulWidget {
  const MeetingsContainer({super.key});

  @override
  State<MeetingsContainer> createState() => _MeetingsContainerState();
}

class _MeetingsContainerState extends State<MeetingsContainer> {
  List meetings = [];
  int meetingsIndex = 0;

  late TextEditingController _controllerName;
  late TextEditingController _controllerDays;
  late TextEditingController _controllerTime;
  late TextEditingController _controllerLink;
  late TextEditingController _controllerId;
  late TextEditingController _controllerPassword;
  late TextEditingController _controllerNote;

  @override
  void initState() {
    _controllerName = TextEditingController();
    _controllerDays = TextEditingController();
    _controllerTime = TextEditingController();
    _controllerLink = TextEditingController();
    _controllerId = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerNote = TextEditingController();
    _getMeetings();
    super.initState();
  }

  _getMeetings() async {
    meetings = await getMeetings();
    setState(() {
      meetings.isNotEmpty ? setTextFields(0) : addMeetings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            color: Color.fromARGB(255, 241, 241, 241),
            height: MediaQuery.of(context).size.height,
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemBuilder: ((context, index) => meetingsButton(index)),
                itemCount: meetings.length,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 400,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        meetings.removeAt(meetingsIndex);

                        setState(() {
                          meetings.isNotEmpty ? setTextFields(0) : addMeetings();
                          meetingsIndex = 0;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        addMeetings();
                      },
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Name"),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          controller: _controllerName,
                          onChanged: (String value) {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Days"),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          controller: _controllerDays,
                          onChanged: (String value) {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Time"),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          controller: _controllerTime,
                          onChanged: (String value) {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Link"),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          controller: _controllerLink,
                          onChanged: (String value) {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Id"),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          controller: _controllerId,
                          onChanged: (String value) {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Password"),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          controller: _controllerPassword,
                          onChanged: (String value) {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Note"),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          controller: _controllerNote,
                          onChanged: (String value) {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 350,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            meetings[meetingsIndex]["Name"] = _controllerName.text;
                            meetings[meetingsIndex]["Day"] = _controllerDays.text;
                            meetings[meetingsIndex]["Time"] = _controllerTime.text;
                            meetings[meetingsIndex]["Link"] = _controllerLink.text;
                            meetings[meetingsIndex]["Id"] = _controllerId.text;
                            meetings[meetingsIndex]["Password"] =
                                _controllerPassword.text;
                            meetings[meetingsIndex]["Note"] = _controllerNote.text;

                            setState(() {
                              setTextFields(meetingsIndex);
                            });
                          },
                          child: Text("Add")),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setMeetings(meetings);
                          },
                          child: Text("Confirm Save")),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical : 20.0, horizontal: 20),
                child: Text("NOTE: If the meeting is offline, leave link and other unneccessary fields empty"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget meetingsButton(int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
          onPressed: () {
            meetingsIndex = i;
            setTextFields(i);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              meetings[i]["Name"],
              style: TextStyle(fontSize: 26, color: Colors.black),
            ),
          )),
    );
  }

  void setTextFields(int i) {
    _controllerName.text = meetings[i]["Name"] ?? "";
    _controllerDays.text = meetings[i]["Day"] ?? "";
    _controllerTime.text = meetings[i]["Time"] ?? "";
    _controllerLink.text = meetings[i]["Link"] ?? "";
    _controllerId.text = meetings[i]["Id"] ?? "";
    _controllerPassword.text = meetings[i]["Password"] ?? "";
    _controllerNote.text = meetings[i]["Note"] ?? "";
  }

  void addMeetings(){
    Map<String, dynamic> temp = {
                          "Name": "",
                          "Day": "",
                          "Time": "",
                          "Link": "",
                          "Id": "",
                          "Password": "",
                          "Note": "",
                        };
                        meetings.add(temp);

                        meetingsIndex = meetings.length - 1;
                        setState(() {
                          setTextFields(meetingsIndex);
                        });
  }
}
