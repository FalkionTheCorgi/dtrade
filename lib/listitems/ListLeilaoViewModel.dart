import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final loginViewModel = ChangeNotifierProvider((ref) => ListLeilaoViewModel());

class ListLeilaoViewModel extends ChangeNotifier {}
