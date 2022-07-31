import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:http/http.dart' as http;

import 'chat_base.dart';
import 'chat_user.dart';
import 'events.dart';

class ContactsPageData extends EventBus {
  List<ChatBase> contacts = [];
  ContactsPageData() {
    //print("https://randomuser.me/api/?results=50");
    http.Client()
        .get(Uri.parse("https://randomuser.me/api/?results=50"))
        .then((response) {
      //print(response.body);
      String jsonContent = response.body;
      Map<String, dynamic> json = jsonDecode(jsonContent);
      List<dynamic> list = json['results'];
      for (var element in list) {
        contacts.add(ChatUser(
            gender: element['gender'],
            nickname: element['name']['first'] + element['name']['last'],
            account: element['login']['uuid'],
            avatar: element['picture']['thumbnail']));
      }
      contacts
          .sort((ChatBase a, ChatBase b) => a.nameIndex.compareTo(b.nameIndex));
      fire(DataChangeEvent(contacts));
    });
  }

  static ContactsPageData? mocked;
  static ContactsPageData mock() {
    mocked ??= ContactsPageData();
    return mocked!;
  }
}
