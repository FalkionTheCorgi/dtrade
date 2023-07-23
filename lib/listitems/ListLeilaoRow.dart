import 'package:dtrade/bottomsheet/denunciar/DenounceView.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:dtrade/listitems/DialogBet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ListLeilaoRow extends ConsumerStatefulWidget {
  final String name;
  final String ip;
  final String category;
  final String initial;
  final String value;
  final List<String> description;

  const ListLeilaoRow(
      {required this.name,
      required this.ip,
      required this.category,
      required this.initial,
      required this.value,
      required this.description});

  @override
  ListLeilaoRowState createState() => ListLeilaoRowState();
}

class ListLeilaoRowState extends ConsumerState<ListLeilaoRow> {
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
      padding: const EdgeInsets.all(8),
      child: Card(
          child: Padding(
              padding: EdgeInsets.all(16),
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
                                Text("Inicial: ${widget.initial}",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(fontSize: 16))),
                                const Spacer(),
                                Text("Atual: ${widget.value}",
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
                        if (showCard) SizedBox(height: 16),
                        if (showCard)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.zero),
                                onPressed: () => showModalBottomSheet(
                                    showDragHandle: true,
                                    isDismissible: false,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DenounceView();
                                    }),
                                child: Text(
                                  'DENUNCIAR',
                                  style: GoogleFonts.roboto(
                                      textStyle:
                                          const TextStyle(color: Colors.red)),
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                style: TextButton.styleFrom(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.zero),
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => Dialog(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        DialogBet(
                                          value: widget.value,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'DAR LANCE',
                                  style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                          color: ColorTheme.colorFirst)),
                                ),
                              ),
                            ],
                          ),
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
