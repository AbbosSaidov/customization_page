import 'package:customization_page/pages/card_customization_page.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  SummaryRepository repo = SummaryRepository();
    //  repo.getSummary(CounterParties(), '123', '123');
    //  LoginRepository repo = LoginRepository();
    //  repo.getResult(LoginRequest(auth: Auth(login: 'asd', password: 'dsa')));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CardCustomizationPage(),
    );
  }
}
