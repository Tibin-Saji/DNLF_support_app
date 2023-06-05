import 'dart:convert';

import 'package:firedart/firestore/firestore.dart';
import 'package:http/http.dart' as http;

Future getMeetings() async{
  var snapshot = await Firestore.instance
      .collection('Misc.').document("Meetings").get();
  var list = snapshot["Meetings"];
  // This returns a tpye similar to a map
  List meetings = [];
  for (var ele in list) {
    Map<String, dynamic> temp = {
      "Name": (ele["Name"] ?? "").toString(),
      "Day": (ele["Day"] ?? "").toString(),
      "Time": (ele["Time"] ?? "").toString(),
      "Link": (ele["Link"] ?? "").toString(),
      "Id": (ele["Id"] ?? "").toString(),
      "Password": (ele["Password"] ?? "").toString(),
      "Note": (ele["Note"] ?? "").toString(),
    };
    meetings.add(temp);
  }
  return meetings;
}

Future setMeetings(List data) async{
  data.removeWhere((element) => element["Name"].trim() == "");
  Firestore.instance.collection("Misc.").document("Meetings").update({"Meetings" : data});
}

Future getAnnouncements() async{
  var snapshot = await Firestore.instance
      .collection('Misc.').document("Announcements").get();
  
  // Returns a list
  List announcements = [];
  for (var ele in snapshot["Announcement"]) {
    announcements.add(ele.toString());
  }
  return announcements;
}

Future setAnnouncements(List data) async{
  data.removeWhere((ele) => ele.trim() == '');
  Firestore.instance.collection("Misc.").document("Announcements").update({"Announcement" : data});
}

Future getBirthdays() async{
  var snapshot = await Firestore.instance
      .collection('Misc.').document("Announcements").get();
    
  // Returns a list
  List birthdays = [];
  for (var ele in snapshot["Birthdays"]) {
    Map<String, dynamic> temp = {
      "Name" : ele["Name"],
      "Date" : ele["Date"]
    };
    birthdays.add(temp);

}
  return birthdays;
}

Future setBirthdays(List data, List newData) async{
  Firestore.instance.collection("Misc.").document("Announcements").update({"Birthdays" : data});

  for (int i = 0; i < newData.length; i++) {
    Map<String, dynamic> temp = {
      "Name" : newData[i]["Name"],
      "Date" : toDate(newData[i]["Date"])
    };
    Firestore.instance.collection("Birthdays").document(newData[i]["Name"]).set(temp);
  }

}

Future getAnniversaries() async{
  var snapshot = await Firestore.instance
      .collection('Misc.').document("Announcements").get();
    
  // Returns a list
  List anniversaries = [];
  for (var ele in snapshot["Anniversary"]) {
    Map<String, dynamic> temp = {
      "Husband Name" : ele["Husband Name"],
      "Wife Name" : ele["Wife Name"],
      "Date" : ele["Date"]
    };
    anniversaries.add(temp);

}
  return anniversaries;
}

Future setAnniversaries(List data, List newData) async{
  Firestore.instance.collection("Misc.").document("Announcements").update({"Anniversary" : data});

  for (int i = 0; i < newData.length; i++) {
    Map<String, dynamic> temp = {
      "Husband Name" : newData[i]["Husband Name"],
      "Wife Name" : newData[i]["Wife Name"],
      "Date" : toDate(newData[i]["Date"])
    };
    Firestore.instance.collection("Wedding Anniversary").document(newData[i]["Husband Name"]).set(temp);
  }
}

Future getPrayerTopics() async{
  var snapshot = await Firestore.instance
      .collection('Misc.').document("Announcements").get();
    
  // Returns a list
  List topics = [];
  for (var ele in snapshot["PrayerTopics"]) {
    topics.add(ele.toString());
  }
  return topics;
}

Future setPrayerTopics(List data) async{
  data.removeWhere((ele) => ele.trim() == '');
  Firestore.instance.collection("Misc.").document("Announcements").update({"PrayerTopics" : data});
}

Future getTravelFromQatar() async{
  var snapshot = await Firestore.instance
      .collection('Misc.').document("Announcements").get();

  // Returns a list 
  List topics = [];
  
  for (var ele in snapshot["TravelFromQatar"]) {
    Map temp = {};
    temp["Date"] = ele["Date"].toString();
    temp["Name"] = ele["Name"].toString();
    topics.add(temp);
  }

  return topics;
}

Future getTravelOther() async{
  var snapshot = await Firestore.instance
      .collection('Misc.').document("Announcements").get();

  // Returns a list 
  List topics = [];

  for (var ele in snapshot["TravelOther"]) {
    Map temp = {};
    temp["Date"] = ele["Date"].toString();
    temp["Desc"] = ele["Desc"].toString();
    temp["Name"] = ele["Name"].toString();
    topics.add(temp);
  }

  return topics;
}

Future getTravelToQatar() async{
  var snapshot = await Firestore.instance
      .collection('Misc.').document("Announcements").get();

  // Returns a list 
  List topics = [];
  for (var ele in snapshot["TravelToQatar"]) {
    Map temp = {};
    temp["Date"] = ele["Date"].toString();
    temp["Name"] = ele["Name"].toString();
    topics.add(temp);
  }

  return topics;
}

Future setTravelToQatar(List data) async{
  data.removeWhere((ele) => ele["Name"].trim() == '');

  Firestore.instance.collection("Misc.").document("Announcements").update({"TravelToQatar" : data});
}

Future setTravelFromQatar(List data) async{
  data.removeWhere((ele) => ele["Name"].trim() == '');

  Firestore.instance.collection("Misc.").document("Announcements").update({"TravelFromQatar" : data});
}

Future setTravelOther(List data) async{
  data.removeWhere((ele) => ele["Name"].trim() == '');

  Firestore.instance.collection("Misc.").document("Announcements").update({"TravelOther" : data});
}


Future getSermons() async{
  var snapshot = await Firestore.instance
      .collection('Misc.').document("Constants").get();
    
  // Returns a list
  List list = [];
  for (var ele in snapshot["SermonPlaylist"]) {
    Map<String, dynamic> temp = {
      "url": ele["url"],
      "thumbnail": ele["thumbnail"] ?? "",
      "name": ele["name"] ?? "",
    };
    list.add(temp);
  }
  return list;
} 

Future setSermons(List data) async{
  data.removeWhere((ele) => ele["url"].trim() == '');

  List list = [];

  for(var ele in data){
    list.add(await sermonMap(ele["url"])); 
  }

  Firestore.instance.collection("Misc.").document("Constants").update({"SermonPlaylist" : list});
}

Future getPhones() async{
  var snapshot = await Firestore.instance
      .collection('Misc.').document("MemberPhoneNo").get();
    
  // Returns a list
  List phones = [];
  for (var ele in snapshot["Numbers"]) {
    phones.add(ele.toString());
  }
  return phones;
}

Future setPhones(List data) async{
  data.removeWhere((ele) => ele.trim() == '');
  Firestore.instance.collection("Misc.").document("MemberPhoneNo").update({"Numbers" : data});
}


toDate(String dateStr){
  const monthsArray = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];
  var dateList = dateStr.split(' ');
  //return Timestamp.fromDateTime(DateTime(2022, monthsArray.indexOf(dateList[1]), int.parse(dateList[0])));
  return DateTime(2022, monthsArray.indexOf(dateList[1]), int.parse(dateList[0]));
}

Future<Map<String, dynamic>> sermonMap (String url) async{
  String vId = url.split("v=")[1].split("&")[0];
  String apiUrl = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2C%20contentDetails&id=" + vId + "&key=AIzaSyAOp83kFLQgoAkYAfCeIPpChj6fmH2IA60";
  final response = await http
      .get(Uri.parse(apiUrl));
  var data = jsonDecode(response.body);
  return {"thumbnail" : data["items"][0]["snippet"]["thumbnails"]["medium"]["url"], "name" : data["items"][0]["snippet"]["title"], "url" : url};
}
