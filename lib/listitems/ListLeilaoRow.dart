import 'package:dtrade/bottomsheet/denunciar/DenounceView.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:dtrade/listitems/DialogBet.dart';
import 'package:dtrade/listitems/ListLeilaoViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ListLeilaoRow extends ConsumerStatefulWidget {
  final String idPub;
  final String name;
  final int category;
  final String ip;
  final String lastBet;
  final String initial;
  final String value;
  final String description;

  const ListLeilaoRow(
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
              padding: const EdgeInsets.all(16),
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
                              children: [Text(widget.description)]),
                        /*if (showCard) const SizedBox(height: 16),
                        if (showCard)
                          TextButton(
                              onPressed: () {
                                model.createFileFromString(widget.file);
                              },
                              child: textWithoutIcon("Baixar arquivo")),*/
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
                                          idPub: widget.idPub,
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

  Widget textWithoutIcon(String text) {
    return Text(text,
        style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 16)));
  }

  Widget textListItemAsset(String text, String image) {
    return Row(
      children: [
        Image.asset(image, width: 24, height: 24),
        const SizedBox(width: 4),
        Text(text,
            style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 16)))
      ],
    );
  }

  Widget textListItemIcon(String text, IconData image) {
    return Row(
      children: [
        Icon(image),
        const SizedBox(width: 4),
        Text(text,
            style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 16)))
      ],
    );
  }

  String returnImageType(int item) {
    switch (item) {
      case 1:
        return 'assets/hatchet.png';
      case 2:
        return 'assets/archer.png';
      case 3:
        return 'assets/kris.png';
      case 4:
        return 'assets/crossed_axes.png';
      case 5:
        return 'assets/mace.png';
      case 6:
        return 'assets/staff.png';
      case 7:
        return 'assets/staff.png';
      case 8:
        return 'assets/sword.png';
      case 9:
        return 'assets/sword.png';
      case 10:
        return 'assets/scythe.png';
      case 11:
        return 'assets/scythe.png';
      case 12:
        return 'assets/fantasy.png';
      case 13:
        return 'assets/mace.png';
      case 14:
        return 'assets/archer.png';
      case 15:
        return 'assets/greek_helmet.png';
      case 16:
        return 'assets/gloves.png';
      case 17:
        return 'assets/pants.png';
      case 18:
        return 'assets/boots.png';
      case 19:
        return 'assets/body_armor.png';
      case 20:
        return 'assets/skull.png';
      case 21:
        return 'assets/ring.png';
      case 22:
        return 'assets/necklace.png';
      default:
        return 'assets/question.png';
    }
  }
}
