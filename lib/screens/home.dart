import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/home_professor_tab.dart';
import 'package:project/screens/home_subjects_tab.dart';
import 'drawerScreen.dart';
import '../config/globalState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Firestore firestore = Firestore.instance;

class InfoHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<InfoHome> {
  GlobalState store = GlobalState.instance;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
          length: 2,
          child: Scaffold(
              drawer: DrawerScreen(),
              backgroundColor: Colors.white,
              appBar: new AppBar(
                title: Text("InfoProvas"),
                elevation: 2.0,
                bottom: new TabBar(indicatorColor: Colors.white, tabs: [
                  new Tab(text: "Disciplina"),
                  new Tab(text: "Professor"),
                ]),
              ),
              body: TabBarView(children: [
                SubjectsTab(),
                ProfessorTab(),
              ])
      ),
    );
  }
}

