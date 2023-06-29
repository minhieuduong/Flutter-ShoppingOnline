import 'package:flutter/material.dart';

class DiscountWidget extends StatelessWidget {
  final int discount;

  DiscountWidget({super.key, required this.discount});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Stack(
        children: [
          Icon(
            Icons.bookmark,
            color: Colors.yellowAccent,
            size: 45,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              "$discount\%",
              style: TextStyle(
                  fontSize: 13, color: Colors.red, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
