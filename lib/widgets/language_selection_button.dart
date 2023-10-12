import 'package:flutter/material.dart';

class LanguageSelectButton extends StatelessWidget {
  final String languageName;
  final VoidCallback onPressed;

  const LanguageSelectButton({
    Key? key,
    required this.languageName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 170,
        height: 55,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 60, 58, 58),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            languageName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
