import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onpressed;
  final String title;
  final Color? textColor;

  const PrimaryButton({
    Key? key,
    required this.onpressed,
    required this.title,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[900],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero
          )
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
