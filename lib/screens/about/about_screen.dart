import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/styles/github_icon.dart';
import 'package:infoprovas/styles/facebook_icon.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class AboutScreen extends StatelessWidget {
  Future<void> _launchURL(BuildContext context, String url) async {
    try {
      await launch(
        url,
        option: CustomTabsOption(
          toolbarColor: Style.mainTheme.primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsAnimation(
            startEnter: 'slide_up',
            startExit: 'android:anim/fade_out',
            endEnter: 'android:anim/fade_in',
            endExit: 'slide_down',
          ),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
          ],
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.mainTheme.accentColor,
        title: Text("Sobre"),
        elevation: 2.0,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: SingleChildScrollView(
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 16.0,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset(
                    "assets/devmob-logo.png",
                    width: 80,
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "App desenvolvido por DevMob UFRJ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Divider(
                color: Colors.black45,
                height: 28,
              ),
              Text(
                "Infoprovas",
                style: TextStyle(
                  fontSize: 20,
                  color: Style.mainTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  "O InfoProvas é um projeto do CAInfo, Centro Acadêmico do curso de Ciência da Computação. "
                  "Anteriormente, consistindo apenas de um site.\nO InfoProvas conta com provas antigas de "
                  "professores e disciplinas, com o objetivo principal de auxiliar os alunos nos estudos, "
                  "permitindo uma preparação mais efetiva e objetiva, trazendo resultados melhores pros alunos, "
                  "pro curso, e pra universidade.",
                  textAlign: TextAlign.justify,
                ),
              ),
              Divider(
                color: Colors.black45,
                height: 28,
              ),
              Text(
                "DevMob",
                style: TextStyle(
                  fontSize: 20,
                  color: Style.mainTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  "O aplicativo foi desenvolvido pelo DevMob, Grupo de Desenvolvimento de Aplicativos do "
                  "Departamento de Ciência da Computação da UFRJ. O app foi desenvolvido em Flutter, e o seu "
                  "código fonte está aberto, disponível no GitHub do grupo.",
                  textAlign: TextAlign.justify,
                ),
              ),
              Divider(
                color: Colors.black45,
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Facebook.facebook),
                    iconSize: 40,
                    onPressed: () => _launchURL(
                        context, "http://facebook.com/devmobufrj"),
                  ),
                  IconButton(
                    icon: Icon(Git.github),
                    iconSize: 40,
                    onPressed: () => _launchURL(
                        context, "https://github.com/DevMobUFRJ"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
