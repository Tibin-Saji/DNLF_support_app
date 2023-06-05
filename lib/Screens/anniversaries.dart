import 'package:dnlf_support_app/firestore_functions.dart';
import 'package:flutter/material.dart';

class AnniversariesContainer extends StatefulWidget {
  const AnniversariesContainer({super.key});

  @override
  State<AnniversariesContainer> createState() => _AnniversariesContainerState();
}

class _AnniversariesContainerState extends State<AnniversariesContainer> {
  List anniversaries = [];
  int anniversariesIndex = 0;
  int fixedLength = 0;

  late TextEditingController _controllerHName;
  late TextEditingController _controllerWName;
  late TextEditingController _controllerDate;


  @override
  void initState() {
    _controllerHName = TextEditingController();
    _controllerWName = TextEditingController();
    _controllerDate = TextEditingController();
    _getAnniversaries();
    super.initState();
  }

  _getAnniversaries() async {
    anniversaries = await getAnniversaries();
    fixedLength = anniversaries.length;
    setState(() {
      anniversaries.isNotEmpty ? setTextFields(0) : addAnniversaries();
      anniversariesIndex = 0;
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
                itemBuilder: ((context, index) => anniversariesButton(index)),
                itemCount: anniversaries.length,
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
                      anniversariesIndex >= fixedLength ?
                      (){
                        anniversaries.removeAt(anniversariesIndex);

                        setState(() {
                          anniversaries.isNotEmpty ? setTextFields(0) : addAnniversaries();
                          anniversariesIndex = 0;
                        });
                      }
                      : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        addAnniversaries();
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
                        child: Text("Husband Name"),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          readOnly: anniversariesIndex < fixedLength,
                          controller: _controllerHName,
                          onChanged: (String value) {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("Wife Name"),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextField(
                          readOnly: anniversariesIndex < fixedLength,
                          controller: _controllerWName,
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
                          readOnly: anniversariesIndex < fixedLength,
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
                            anniversaries[anniversariesIndex]["Husband Name"] = _controllerHName.text;
                            anniversaries[anniversariesIndex]["Wife Name"] = _controllerWName.text;
                            anniversaries[anniversariesIndex]["Date"] = _controllerDate.text;

                            setState(() {
                              setTextFields(anniversariesIndex);
                            });
                          },
                          child: Text("Add")),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            List newAnni = [];
                            for (int i = fixedLength; i < anniversaries.length; i++) {
                              newAnni.add(anniversaries[i]);
                            }
                            setAnniversaries(anniversaries, newAnni);
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

  Widget anniversariesButton(int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
          onPressed: () {
            anniversariesIndex = i;
            setTextFields(i);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              anniversaries[i]["Husband Name"],
              style: TextStyle(fontSize: 26, color: Colors.black),
            ),
          )),
    );
  }

  void setTextFields(int i) {
    _controllerHName.text = anniversaries[i]["Husband Name"] ?? "";
    _controllerWName.text = anniversaries[i]["Wife Name"] ?? "";
    _controllerDate.text = anniversaries[i]["Date"] ?? "";
  }

  void addAnniversaries(){
    Map<String, dynamic> temp = {
                          "Husband Name": "",
                          "Wife Name": "",
                          "Date": "",
                        };
                        anniversaries.add(temp);

                        anniversariesIndex = anniversaries.length - 1;
                        setState(() {
                          setTextFields(anniversariesIndex);
                        });
  }
}
