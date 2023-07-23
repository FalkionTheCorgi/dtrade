import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final listLeilaoViewModel = ChangeNotifierProvider((ref) => ListLeilaoViewModel());

class ListLeilaoViewModel extends ChangeNotifier {}
