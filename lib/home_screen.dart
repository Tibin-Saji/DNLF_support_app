import 'package:dnlf_support_app/Screens/anniversaries.dart';
import 'package:dnlf_support_app/Screens/announcements.dart';
import 'package:dnlf_support_app/Screens/birthdays.dart';
import 'package:dnlf_support_app/Screens/meetings.dart';
import 'package:dnlf_support_app/Screens/phone_number.dart';
import 'package:dnlf_support_app/Screens/prayer_topics.dart';
import 'package:dnlf_support_app/Screens/sermons.dart';
import 'package:dnlf_support_app/Screens/travel_from_qatar.dart';
import 'package:dnlf_support_app/Screens/travel_other.dart';
import 'package:dnlf_support_app/Screens/travel_to_qatar.dart';
import 'package:flutter/material.dart';


List containerList = [MeetingsContainer(), AnnouncementsContainer(), PrayerTopicsContainer(), BirthdaysContainer(), AnniversariesContainer(), TravelToQatarContainer(), TravelFromQatarContainer(), TravelOtherContainer(), SermonsContainer(), PhoneNumbersContainer()];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int containerValue = 0;
  @override
  Widget build(BuildContext context) {
    return 
     Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 51, 36, 31),
            title: const Text('DNLF Backend App'),
            centerTitle: true,
          ),
          body: Row(
            children: [
              Container(
                color: Colors.black,
                width: 300,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical : 20.0),
                        child: TextButton(
                          onPressed: (){
                            
                            setState(() {
                              containerValue = 0;
                            }); 
                          }, 
                          child: const Text(
                            "Meetings", 
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                              ),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical : 20.0),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              containerValue = 1;
                            }); 
                          },  
                          child: const Text(
                            "Announcements", 
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                              ),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical : 20.0),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              containerValue = 2;
                            }); 
                          }, 
                          child: const Text(
                            "Prayer Topics", 
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                              ),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical : 20.0),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              containerValue = 3;
                            }); 
                          },  
                          child: const Text(
                            "Birthdays", 
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                              ),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical : 20.0),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              containerValue = 4;
                            }); 
                          },  
                          child: const Text(
                            "Anniversaries", 
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                              ),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical : 20.0),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              containerValue = 5;
                            }); 
                          },  
                          child: const Text(
                            "Travel To Qatar", 
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                              ),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical : 20.0),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              containerValue = 6;
                            }); 
                          },  
                          child: const Text(
                            "Travel From Qatar", 
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                              ),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical : 20.0),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              containerValue = 7;
                            }); 
                          },  
                          child: const Text(
                            "Travel Other", 
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                              ),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical : 20.0),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              containerValue = 8;
                            }); 
                          },  
                          child: const Text(
                            "Sermon Playlists", 
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                              ),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical : 20.0),
                        child: TextButton(
                          onPressed: (){
                            setState(() {
                              containerValue = 9;
                            }); 
                          },  
                          child: const Text(
                            "Phone Number", 
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                              ),)),
                      ),
                    ],
                  ),
                ),
              ),
                      containerList[containerValue],
            ],
            )
        );
  }
}