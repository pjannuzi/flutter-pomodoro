import 'package:flutter/material.dart';

class CronometroBotao extends StatelessWidget {

  final String texto;
  final IconData icone;
  final void Function()? click;

  const CronometroBotao({Key? key,
    required this.texto,
    required this.icone,
    this.click,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 23,
        ),
        textStyle: TextStyle(fontSize: 20),
      ),
      onPressed: click,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              icone,
            ),
          ),
          Text(texto)
        ],
      ),
    );
  }
}
