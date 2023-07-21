import 'package:dtrade/extension/mocked.dart';
import 'package:dtrade/listitems/ListLeilaoRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListLeilao extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ListLeilaoState();
}

class ListLeilaoState extends ConsumerState<ListLeilao> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        for (var item in Mocked.items)
          ListLeilaoRow(
              name: item.name,
              ip: item.ip,
              category: item.category,
              initial: item.initialPrice,
              value: item.actualPrice,
              description: item.descriptionItem),
      ],
    );
  }
}
