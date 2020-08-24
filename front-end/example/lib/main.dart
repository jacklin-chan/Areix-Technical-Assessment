import 'dart:io';

import 'package:flutter/material.dart' hide Actions;
// import 'package:platform/platform.dart';

import 'ui/home.dart';
import 'ui/new_expense.dart';
// import 'src/settings.dart';

void main() {
  runApp(LedgerApp());
}


class LedgerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ledger',
          theme: ThemeData(
                  primarySwatch: Colors.blueGrey,
                  accentColor: Colors.blueGrey,
                ),
          builder: (context, child) => Scaffold(
          // Global GestureDetector that will dismiss the keyboard
            body: GestureDetector(
              onTap: () {
                // When running in iOS, dismiss the keyboard when any Tap happens outside a TextField
                if (Platform.isIOS) hideKeyboard(context);
              },
              child: child,
            ),
          ),
          routes: <String, Widget Function(BuildContext)>{
            '/': (BuildContext context) => Home(),
            '/new_expense': (BuildContext context) => NewExpenseScreen(),
            // '/settings': (BuildContext context) => Settings(),
          },
        );
    }

    void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }
}
