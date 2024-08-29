import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String imagePath;
  final String text;
  final void Function()? onTap;
  const MyListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        leading: Image.asset(imagePath, width: 24, height: 24),
        onTap: onTap,
        title: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
