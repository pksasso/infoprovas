import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:infoprovas/model/subject.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/repository/subject_exam_repository.dart';
import 'package:infoprovas/screens/subject_exam_tab.dart';
import 'package:infoprovas/utils/main_functions.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class SubjectExam extends StatefulWidget {
  final Subject _subject;

  SubjectExam(this._subject);

  @override
  _SubjectExamState createState() => _SubjectExamState();
}

class _SubjectExamState extends State<SubjectExam>
    with TickerProviderStateMixin {
  List<Exam> _exams = <Exam>[];
  List<String> _types = [];
  bool hasFailed = false;

  @override
  void initState() {
    super.initState();
    listenForExams();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Style.mainTheme.primaryColor,
        title: Text("${widget._subject.name}"),
        elevation: 0,
      ),
      body: _types.isEmpty
          ? hasFailed
              ? Center(child: Text("Não há provas desta disciplina"))
              : Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: _types.length,
              child: Column(
                children: <Widget>[
                  Material(
                    elevation: 2.0,
                    child: Container(
                      width: screenWidth,
                      color: Style.mainTheme.primaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TabBar(
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: BubbleTabIndicator(
                              indicatorColor: Colors.white,
                              indicatorHeight: 20.0,
                              tabBarIndicatorSize: TabBarIndicatorSize.label,
                            ),
                            unselectedLabelColor: Colors.white,
                            labelColor: Style.mainTheme.primaryColor,
                            tabs: _types
                                .map((type) => Tab(child: Text(getShortType(type))))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: _types
                          .map((type) => SubjectExamTab(_exams
                              .where((Exam e) => e.type == type)
                              .toList()))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void listenForExams() async {
    final Stream<Exam> stream = await getSubjectExams(widget._subject.id);
    try {
      stream.toList().then((examList) {
        if (examList.isEmpty) {
          setState(() {
            hasFailed = true;
          });
        } else {
          setState(() {
            examList.forEach((exam) {
              exam.subject = widget._subject.name;
              _exams.add(exam);
              if (_types != null) {
                if (!_types.contains(exam.type)) {
                  _types.add(exam.type);
                }
              }
            });
          });
          sortTypesList(_types);
          _exams.sort((a, b) => a.compareTo(b));
        }
      });
    } catch (e) {
      onFailedConnection();
    }
  }

  onFailedConnection() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text("Não foi possível conectar a rede"),
        ),
        backgroundColor: Style.mainTheme.primaryColor,
        duration: Duration(minutes: 5),
        action: SnackBarAction(
          label: "Tentar novamente",
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              listenForExams();
            });
          },
        ),
      ),
    );
  }
}
