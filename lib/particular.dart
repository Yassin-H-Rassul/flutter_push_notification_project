import 'package:flutter/material.dart';

class ParticularScreen extends StatefulWidget {
  const ParticularScreen({Key? key}) : super(key: key);

  @override
  _ParticularScreenState createState() => _ParticularScreenState();
}

class _ParticularScreenState extends State<ParticularScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Center(
        child: Text('user realated screen.'),
      ),
    );
  }
}
