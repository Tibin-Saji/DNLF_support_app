import 'package:dnlf_support_app/firestore_functions.dart';
import 'package:flutter/material.dart';

class PrayerTopicsContainer extends StatefulWidget {
  const PrayerTopicsContainer({super.key});

  @override
  State<PrayerTopicsContainer> createState() => _PrayerTopicsContainerState();
}

class _PrayerTopicsContainerState extends State<PrayerTopicsContainer> {
  List topics = [];
  int topicsIndex = 0;

  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();

    _gettopics();
    super.initState();
  }

  _gettopics() async {
    topics = await getPrayerTopics();
    setState(() {
      topics.isNotEmpty ? setTextFields(0) : addPrayerTopics();
    });
    print("In topics");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Color.fromARGB(255, 241, 241, 241),
          height: MediaQuery.of(context).size.height,
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemBuilder: ((context, index) => topicsButton(index)),
              itemCount: topics.length,
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
                      topics.removeAt(topicsIndex);

                      setState(() {
                        topics.isNotEmpty ? setTextFields(0) : addPrayerTopics();
                        topicsIndex = 0;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      addPrayerTopics();
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
                        maxLines: null,
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
                          topics[topicsIndex] = _controller.text;
                          setState(() {
                            setTextFields(topicsIndex);
                          });
                        },
                        child: Text("Add")),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setPrayerTopics(topics);
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
    );
  }

  Widget topicsButton(int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
          onPressed: () {
            topicsIndex = i;
            setTextFields(i);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              topics[i],
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          )),
    );
  }

  void setTextFields(int i) {
    _controller.text = topics[i] ?? "";
  }

  void addPrayerTopics(){
    
                        topics.add("");

                        topicsIndex = topics.length - 1;
                        setState(() {
                          setTextFields(topicsIndex);
                        });
  }
}
