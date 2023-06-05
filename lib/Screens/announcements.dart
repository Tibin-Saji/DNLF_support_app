import 'package:dnlf_support_app/firestore_functions.dart';
import 'package:flutter/material.dart';

class AnnouncementsContainer extends StatefulWidget {
  const AnnouncementsContainer({super.key});

  @override
  State<AnnouncementsContainer> createState() => _AnnouncementsContainerState();
}

class _AnnouncementsContainerState extends State<AnnouncementsContainer> {
  List announcements = [];
  int announcementsIndex = 0;

  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();

    _getannouncements();
    super.initState();
  }

  _getannouncements() async {
    announcements = await getAnnouncements();
    setState(() {
      announcements.isNotEmpty ? setTextFields(0) : addAnnouncements();
    });
    print(announcements.length);
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
                itemBuilder: ((context, index) => announcementsButton(index)),
                itemCount: announcements.length,
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
                        announcements.removeAt(announcementsIndex);

                        setState(() {
                          announcements.isNotEmpty ? setTextFields(0) : addAnnouncements();
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        addAnnouncements();
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
                            announcements[announcementsIndex] = _controller.text;
                            setState(() {
                              setTextFields(announcementsIndex);
                            });
                          },
                          child: Text("Add")),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setAnnouncements(announcements);
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

  Widget announcementsButton(int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
          onPressed: () {
            announcementsIndex = i;
            setTextFields(i);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              announcements[i],
              style: TextStyle(fontSize: 26, color: Colors.black),
            ),
          )),
    );
  }

  void setTextFields(int i) {
    _controller.text = announcements[i] ?? "";
  }

  void addAnnouncements(){
    
                        announcements.add("");

                        announcementsIndex = announcements.length - 1;
                        setState(() {
                          setTextFields(announcementsIndex);
                        });
  }
}
