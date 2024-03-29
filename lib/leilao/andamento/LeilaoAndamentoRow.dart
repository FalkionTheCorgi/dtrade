import 'package:dtrade/api/data/AuctionItems.dart';
import 'package:dtrade/extension/Extension.dart';
import 'package:dtrade/leilao/andamento/DialogDelete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeilaoAndamentoRow extends ConsumerStatefulWidget {
  final String idPub;
  final String name;
  final int category;
  final String ip;
  final String sacred;
  final List<ImplicitAndAffixData> affixes;
  final List<ImplicitAndAffixData> implicit;
  final int armor;
  final int damagePerSecond;
  final int attackPerSecond;
  final int damagePerHitMin;
  final int damagePerHitMax;
  final int socket;
  final int itemLevel;
  final String lastBet;
  final String initial;
  final String value;

  const LeilaoAndamentoRow(
      {Key? key,
      required this.idPub,
      required this.name,
      required this.category,
      required this.ip,
      required this.armor,
      required this.damagePerSecond,
      required this.attackPerSecond,
      required this.damagePerHitMin,
      required this.damagePerHitMax,
      required this.lastBet,
      required this.initial,
      required this.value,
      required this.itemLevel,
      required this.affixes,
      required this.implicit,
      required this.socket,
      required this.sacred})
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
                                textListItemIcon('Last Bet: ${widget.lastBet}',
                                    Icons.emoji_events_outlined)
                              ]),
                              const SizedBox(height: 8),
                              textListItemIcon('Initial: ${widget.initial}',
                                  Icons.monetization_on_outlined),
                              const SizedBox(height: 8),
                              textListItemIcon('Actual: ${widget.value}',
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
                      child: showCard
                          ? showCardAnimation()
                          : const Column(
                              children: [],
                            )),
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

  Widget showCardAnimation() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            widget.sacred,
            style: const TextStyle(fontFamily: 'DiabloHeavy'),
          )
        ]),
        const SizedBox(height: 8),
        if (widget.armor > 0) showArmor(),
        if (widget.armor > 0) const SizedBox(height: 8),
        if (widget.damagePerSecond > 0) showDamagePerSecond(),
        if (widget.damagePerSecond > 0) const SizedBox(height: 8),
        if (widget.attackPerSecond > 0) showAttackPerSecond(),
        if (widget.attackPerSecond > 0) const SizedBox(height: 8),
        if (widget.damagePerHitMin > 0 || widget.damagePerHitMax > 0)
          showDamagePerHit(),
        if (widget.damagePerHitMin > 0 || widget.damagePerHitMax > 0)
          const SizedBox(height: 8),
        if (widget.implicit.isNotEmpty)
          const Row(
            children: [
              Text(
                'Implicit',
                style: TextStyle(fontFamily: 'DiabloHeavy'),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        if (widget.implicit.isNotEmpty) const SizedBox(height: 8),
        for (var element in widget.implicit)
          Row(
            children: [
              Expanded(
                child: Text(
                    '- ${element.effect.replaceAll('#', element.value)}',
                    style: const TextStyle(fontFamily: 'Diablo')),
              ),
              const SizedBox(height: 4),
            ],
          ),
        const SizedBox(height: 8),
        if (widget.affixes.isNotEmpty)
          const Row(children: [
            Text(
              'Affixes',
              style: TextStyle(fontFamily: 'DiabloHeavy'),
            ),
          ]),
        if (widget.affixes.isNotEmpty) const SizedBox(height: 8),
        for (var element in widget.affixes)
          Row(
            children: [
              Expanded(
                child: Text(
                    '- ${element.effect.replaceAll('#', element.value)}',
                    style: const TextStyle(fontFamily: 'Diablo')),
              ),
              const SizedBox(height: 4),
            ],
          ),
        const SizedBox(height: 8),
        Row(
          children: [
            Row(
              children: [
                const Text(
                  'Socket: ',
                  style: TextStyle(fontFamily: 'DiabloHeavy'),
                ),
                Text(
                  '${widget.socket}',
                  style: const TextStyle(fontFamily: 'Diablo'),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                const Text(
                  'Required Level: ',
                  style: TextStyle(fontFamily: 'DiabloHeavy'),
                ),
                Text(
                  '${widget.itemLevel}',
                  style: const TextStyle(fontFamily: 'Diablo'),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.zero),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                style: TextStyle(color: Colors.red, fontFamily: 'Diablo'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget showArmor() {
    return Wrap(
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const Text(
              'Armor:',
              style: TextStyle(fontFamily: 'DiabloHeavy'),
            ),
            Text(
              '${widget.armor}',
              style: const TextStyle(fontFamily: 'Diablo'),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget showDamagePerSecond() {
    return Wrap(
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const Text(
              'Damage Per Second:',
              style: TextStyle(fontFamily: 'DiabloHeavy'),
            ),
            Text(
              '${widget.damagePerSecond}',
              style: const TextStyle(fontFamily: 'Diablo'),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget showAttackPerSecond() {
    return Wrap(
      children: [
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            const Text(
              'Attack Per Second:',
              style: TextStyle(fontFamily: 'DiabloHeavy'),
            ),
            Text(
              '${widget.attackPerSecond}',
              style: const TextStyle(fontFamily: 'Diablo'),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget showDamagePerHit() {
    return Wrap(
      children: [
        const Text(
          'Damage Per Hit',
          style: TextStyle(fontFamily: 'DiabloHeavy'),
        ),
        Row(
          children: [
            const Text(
              'Min:',
              style: TextStyle(fontFamily: 'DiabloHeavy'),
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              '${widget.damagePerHitMin}',
              style: const TextStyle(fontFamily: 'Diablo'),
            ),
            const SizedBox(
              width: 8,
            ),
            const Text(
              'Max:',
              style: TextStyle(fontFamily: 'DiabloHeavy'),
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              '${widget.damagePerHitMax}',
              style: const TextStyle(fontFamily: 'Diablo'),
            ),
          ],
        ),
      ],
    );
  }
}
