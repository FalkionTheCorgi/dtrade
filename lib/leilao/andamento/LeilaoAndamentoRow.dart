import 'package:dtrade/extension/Extension.dart';
import 'package:dtrade/leilao/andamento/DialogDelete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LeilaoAndamentoRow extends ConsumerStatefulWidget {
  final String idPub;
  final String name;
  final int category;
  final String ip;
  final String lastBet;
  final String initial;
  final String value;
  final String description;

  const LeilaoAndamentoRow(
      {Key? key,
      required this.idPub,
      required this.name,
      required this.category,
      required this.ip,
      required this.lastBet,
      required this.initial,
      required this.value,
      required this.description})
      : super(key: key);

  @override
  LeilaoAndamentoRowState createState() => LeilaoAndamentoRowState();
}

class LeilaoAndamentoRowState extends ConsumerState<LeilaoAndamentoRow> {
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
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(children: [
                                textListItemAsset(widget.name,
                                    returnImageType(widget.category)),
                                const Spacer(),
                                textListItemIcon(
                                    'IP: ${widget.ip}', Icons.bolt_outlined)
                              ]),
                              const SizedBox(height: 8),
                              Row(children: [
                                textListItemIcon(
                                    'Último Bet: ${widget.lastBet}',
                                    Icons.emoji_events_outlined)
                              ]),
                              const SizedBox(height: 8),
                              textListItemIcon('Inicial: ${widget.initial}',
                                  Icons.monetization_on_outlined),
                              const SizedBox(height: 8),
                              textListItemIcon('Atual: ${widget.value}',
                                  Icons.monetization_on_outlined),
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
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  widget.description,
                                  style: const TextStyle(fontFamily: 'Diablo'),
                                )
                              ]),
                        if (showCard) const SizedBox(height: 16),
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
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => Dialog(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        DialogDelete(
                                          idPub: widget.idPub,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'EXCLUIR',
                                  style: TextStyle(
                                      color: Colors.red, fontFamily: 'Diablo'),
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
