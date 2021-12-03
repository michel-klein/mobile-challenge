import 'package:flutter/material.dart';
import 'package:mobile_challenge/models/filter_gender.dart';
import 'package:mobile_challenge/models/person_list.dart';
import 'package:mobile_challenge/screens/first_screen.dart';
import 'package:mobile_challenge/screens/main_screen.dart';
import 'package:provider/provider.dart';

import 'models/state_gender.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(fontFamily: 'Quicksand',);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (_) => PersonList(),),
        ChangeNotifierProvider(
        create: (_) => StateGender(),),
        ],
        child: MaterialApp(
          title: 'Pharma Inc.',
          theme: theme.copyWith(            
          colorScheme: theme.colorScheme.copyWith(
            primary: Color(0XFF003461),
            secondary: Color(0XFF0083CA),
            background: Color(0XFF00AFAD),
            error: Color(0XFFF26522),
          ),
        ),
          home: mainScreen(),
          debugShowCheckedModeBanner: false,
        ),
      );
  }
}
