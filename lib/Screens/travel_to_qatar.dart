import 'package:dnlf_support_app/firestore_functions.dart';
import 'package:flutter/material.dart';

class TravelToQatarContainer extends StatefulWidget {
  const TravelToQatarContainer({super.key});

  @override
  State<TravelToQatarContainer> createState() => _TravelToQatarContainerState();
}

class _TravelToQatarContainerState extends State<TravelToQatarContainer> {
  List list = [];
  int listIndex = 0;

  late TextEditingController _controllerName;
  late TextEditingController _controllerDate;

  @override
  void initState() {
    _controllerName = TextEditingController();
    _controllerDate = TextEditingController();

    _getlist();
    super.initState();
  }

  _getlist() async {
    list = await getTravelToQatar();
    setState(() {
      list.isNotEmpty ? setTextFields(0) : addTravelToQatar();
    });
    print(list.length);
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
                itemBuilder: ((context, index) => listButton(index)),
                itemCount: list.length,
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
                        list.removeAt(listIndex);

                        setState(() {
                          list.isNotEmpty ? setTextFields(0) : addTravelToQatar();
                          listIndex = 0;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        addTravelToQatar();
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
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          controller: _controllerName,
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
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          controller: _controllerDate,
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
                            list[listIndex]["Name"] = _controllerName.text;
                            setState(() {
                              setTextFields(listIndex);
                            });
                          },
                          child: Text("Add")),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setTravelToQatar(list);
                          },
                          child: Text("Confirm Save")),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical : 20.0, horizontal: 20),
                child: Text(" "),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget listButton(int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
          onPressed: () {
            listIndex = i;
            setTextFields(i);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              list[i]["Name"],
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          )),
    );
  }

  void setTextFields(int i) {
    _controllerName.text = list[i]["Name"] ?? "";
    _controllerDate.text = list[i]["Date"] ?? "";
  }

  void addTravelToQatar(){
    
                        list.add({"Name" : "", "Date" : "",});

                        listIndex = list.length - 1;
                        setState(() {
                          setTextFields(listIndex);
                        });
  }
}
