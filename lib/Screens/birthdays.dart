import 'package:dnlf_support_app/firestore_functions.dart';
import 'package:flutter/material.dart';

class BirthdaysContainer extends StatefulWidget {
  const BirthdaysContainer({super.key});

  @override
  State<BirthdaysContainer> createState() => _BirthdaysContainerState();
}

class _BirthdaysContainerState extends State<BirthdaysContainer> {
  List birthdays = [];
  int birthdaysIndex = 0;
  int fixedLength = 0;

  late TextEditingController _controllerName;
  late TextEditingController _controllerDate;


  @override
  void initState() {
    _controllerName = TextEditingController();
    _controllerDate = TextEditingController();
    _getBirthdays();
    super.initState();
  }

  _getBirthdays() async {
    birthdays = await getBirthdays();
    fixedLength = birthdays.length;
    setState(() {
      birthdays.isNotEmpty ? setTextFields(0) : addBirthdays();
      birthdaysIndex = 0;
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
                itemBuilder: ((context, index) => birthdaysButton(index)),
                itemCount: birthdays.length,
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
                      onPressed:
                      birthdaysIndex >= fixedLength ?
                      (){
                        birthdays.removeAt(birthdaysIndex);

                        setState(() {
                          birthdays.isNotEmpty ? setTextFields(0) : addBirthdays();
                          birthdaysIndex = 0;
                        });
                      }
                      : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        addBirthdays();
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
                          readOnly: birthdaysIndex < fixedLength,
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
                        child: Text("Date"),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          readOnly: birthdaysIndex < fixedLength,
                          controller: _controllerDate
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
                            birthdays[birthdaysIndex]["Name"] = _controllerName.text;
                            birthdays[birthdaysIndex]["Date"] = _controllerDate.text;

                            setState(() {
                              setTextFields(birthdaysIndex);
                            });
                          },
                          child: Text("Add")),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            List newList = [];
                            for (int i = fixedLength; i < birthdays.length; i++) {
                              newList.add(birthdays[i]);
                            }
                            setBirthdays(birthdays, newList);
                          },
                          child: Text("Confirm Save")),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical : 20.0, horizontal: 20),
                child: Text(""),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget birthdaysButton(int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
          onPressed: () {
            birthdaysIndex = i;
            setTextFields(i);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              birthdays[i]["Name"],
              style: TextStyle(fontSize: 26, color: Colors.black),
            ),
          )),
    );
  }

  void setTextFields(int i) {
    _controllerName.text = birthdays[i]["Name"] ?? "";
    _controllerDate.text = birthdays[i]["Date"] ?? "";
  }

  void addBirthdays(){
    Map<String, dynamic> temp = {
                          "Name": "",
                          "Date": "",
                        };
                        birthdays.add(temp);

                        birthdaysIndex = birthdays.length - 1;
                        setState(() {
                          setTextFields(birthdaysIndex);
                        });
  }
}
