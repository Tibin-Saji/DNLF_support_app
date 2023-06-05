import 'package:dnlf_support_app/firestore_functions.dart';
import 'package:flutter/material.dart';

class SermonsContainer extends StatefulWidget {
  const SermonsContainer({super.key});

  @override
  State<SermonsContainer> createState() => _SermonsContainerState();
}

class _SermonsContainerState extends State<SermonsContainer> {
  List list = [];
  int listIndex = 0;

  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();

    _getlist();
    super.initState();
  }

  _getlist() async {
    list = await getSermons();
    setState(() {
      list.isNotEmpty ? setTextFields(0) : addSermons();
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
                          list.isNotEmpty ? setTextFields(0) : addSermons();
                          // listIndex = 0;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        addSermons();
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
                        child: Text("Text"),
                      ),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          controller: _controller,
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
                            listIndex < list.length 
                            ? list[listIndex]["url"] = _controller.text
                            : list.add({"name": "", "url": "", "thumbnail": ""});
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
                            setSermons(list);
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
              list[i]["url"],
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          )),
    );
  }

  void setTextFields(int i) {
    _controller.text = list[i]["url"] ?? "";
  }

  void addSermons(){
    
                        list.add({"url" : ""});

                        listIndex = list.length - 1;
                        setState(() {
                          setTextFields(listIndex);
                        });
  }
}
