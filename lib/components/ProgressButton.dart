import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FkFProgressButton extends StatefulWidget {
  final Future<void> Function() onPressedCallback;
  final String title;
  final Color bgColorButton;
  final Color textColorButton;
  final Color colorProgress;

  const FkFProgressButton(
      {required this.onPressedCallback,
      required this.title,
      required this.bgColorButton,
      required this.textColorButton,
      required this.colorProgress});

  @override
  ProgressButtonState createState() => ProgressButtonState();
}

class ProgressButtonState extends State<FkFProgressButton> {
  bool isLoading = false;

  @override
  Widget build(Object context) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 18),
            minimumSize: const Size.fromHeight(42),
            backgroundColor: widget.bgColorButton,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            )),
        child: isLoading
            // ignore: dead_code
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24.0, // Defina o valor desejado para a largura
                    height: 24.0, // Defina o valor desejado para a altura
                    child: CircularProgressIndicator(
                      strokeWidth:
                          3.0, // Defina o valor desejado para a largura da linha
                      color: widget
                          .colorProgress, // Defina a cor desejada para o indicador
                    ),
                  ),
                  const SizedBox(width: 18),
                  Text(
                    'AGUARDAR',
                    style: TextStyle(color: widget.textColorButton),
                  )
                ],
              )
            : Text(widget.title,
                style: TextStyle(color: widget.textColorButton)),
        onPressed: () async {
          if (isLoading) return;

          setState(() => isLoading = true);
          await widget.onPressedCallback();
          setState(() => isLoading = false);
        },
      ),
    );
  }
}
