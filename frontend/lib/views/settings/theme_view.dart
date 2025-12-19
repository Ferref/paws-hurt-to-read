import 'package:flutter/material.dart';

class ThemeView extends StatefulWidget{
  const ThemeView({ super.key });

  @override
  State<StatefulWidget> createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green, child: Text("Hello"));
  }
}