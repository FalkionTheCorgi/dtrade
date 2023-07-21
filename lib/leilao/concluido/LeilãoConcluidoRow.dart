import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LeilaoConcluidoRow extends ConsumerStatefulWidget {
  final String name;
  final String ip;
  final String category;
  final String winner;
  final String value;
  final List<String> description;

  const LeilaoConcluidoRow(
      {required this.name,
      required this.ip,
      required this.category,
      required this.winner,
      required this.value,
      required this.description});

  @override
  LeilaoConcluidoRowState createState() => LeilaoConcluidoRowState();
}

class LeilaoConcluidoRowState extends ConsumerState<LeilaoConcluidoRow> {
  bool showCard = false;

  void toggleExpand() {
    setState(() {
      showCard = !showCard;
    });
  }

  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
          child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Column(
                        children: [
                          SizedBox(
                            width: 72,
                            height: 72,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://picsum.photos/id/237/200/300'),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(children: [
                                Text(
                                  widget.name,
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(fontSize: 16)),
                                ),
                                const Spacer(),
                                Text('IP: ${widget.ip}',
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(fontSize: 16))),
                              ]),
                              const SizedBox(height: 8),
                              Row(children: [
                                Text("Categoria: ${widget.category}",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(fontSize: 16))),
                                const Spacer(),
                              ]),
                              const SizedBox(height: 8),
                              Row(children: [
                                Text("Vencedor: ${widget.winner}",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(fontSize: 16))),
                                const Spacer(),
                                Text("Valor: ${widget.value}",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(fontSize: 16)))
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimatedSize(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 400),
                    child: Column(
                      children: [
                        if (showCard)
                          for (var desc in widget.description)
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [Text(desc)]),
                      ],
                    ),
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          toggleExpand();
                        },
                        child: Icon(
                            showCard ? Icons.expand_less : Icons.expand_more),
                      ),
                    ],
                  )
                ],
              ))),
    );
  }
}
