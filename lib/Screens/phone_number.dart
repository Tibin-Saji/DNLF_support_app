import 'package:dnlf_support_app/firestore_functions.dart';
import 'package:flutter/material.dart';


class PhoneNumbersContainer extends StatefulWidget {
  const PhoneNumbersContainer({super.key});

  @override
  State<PhoneNumbersContainer> createState() => _PhoneNumbersContainerState();
}

class _PhoneNumbersContainerState extends State<PhoneNumbersContainer> {
  List numbers = [];
  int numbersIndex = 0;

  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();

    _getnumbers();
    super.initState();
  }

  _getnumbers() async {
    numbers = await getPhones();
    setState(() {
      numbers.isNotEmpty ? setTextFields(0) : addPhoneNumbers();
    });
    print("In numbers");
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
              itemBuilder: ((context, index) => numbersButton(index)),
              itemCount: numbers.length,
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
                      numbers.removeAt(numbersIndex);

                      setState(() {
                        numbers.isNotEmpty ? setTextFields(0) : addPhoneNumbers();
                        numbersIndex = 0;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      addPhoneNumbers();
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
                        keyboardType: TextInputType.number,
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
                          numbers[numbersIndex] = _controller.text;
                          setState(() {
                            setTextFields(numbersIndex);
                          });
                        },
                        child: Text("Add")),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setPhones(numbers);
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

  Widget numbersButton(int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
          onPressed: () {
            numbersIndex = i;
            setTextFields(i);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              numbers[i],
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          )),
    );
  }

  void setTextFields(int i) {
    _controller.text = numbers[i] ?? "";
  }

  void addPhoneNumbers(){
    
                        numbers.add("");

                        numbersIndex = numbers.length - 1;
                        setState(() {
                          setTextFields(numbersIndex);
                        });
  }
}
