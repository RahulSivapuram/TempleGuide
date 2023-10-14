import 'package:flutter/material.dart';

class CardHolder extends StatefulWidget {
  final String imageloc;
  final String name;
  const CardHolder({super.key, required this.imageloc, required this.name});

  @override
  State<CardHolder> createState() => _CardHolderState();
}

class _CardHolderState extends State<CardHolder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          SizedBox(
            height: 70,
            width: 80,
            child: Image.asset(
              widget.imageloc,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            widget.name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
