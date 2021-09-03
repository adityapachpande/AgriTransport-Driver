import 'package:flutter/material.dart';

class EarningsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Earnings',
        style: TextStyle(
        fontSize: 15,
        fontFamily: 'Brand-Bold',
        color: Colors.black,
        fontWeight: FontWeight.bold,
    ),
    ),
    ),
        body: Center(child: Text("No Earning"))
        );
  }
}
