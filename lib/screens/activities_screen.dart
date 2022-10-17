import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_move/providers/activities_provider.dart';
import 'package:we_move/screens/activities_screen_details.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff141d41),
        body: Center(
          child: FlatButton(
            child: Text("Load Data"),
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.white, width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ActivitiesScreenDetails()),
              );
            },
          ),
        ));
  }
}
