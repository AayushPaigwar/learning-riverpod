import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_flutter/models/user.dart';

// Provider

// We can only use this value (can't change it)
//final counter = ref.watch(counterProvider);

final nameProvider = Provider<String>((ref) => 'Aayush Paigwar Provider');

//State Provider

// we can update the value by using
// 1.  ref.read(counterProvider.notifier)
//[ref.read when its outside of the Buildwidget otherwise ref.watch]

final counterProvider = StateProvider<int>((ref) => 0);

//StateNotifierProvider
final counterNotifierProvider = StateNotifierProvider((ref) => Counter());

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
}

//ChangeNotifierProviders (not recommended)
// - easy to migrate from proivder to riverpod

final counterChangeNotifierProvider =
    ChangeNotifierProvider((ref) => CounterNotifier());

class CounterNotifier extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

final isDarkThemeProvider = StateProvider((ref) => false);

//Future Provider
 /*ConsumerStatefulWidget - Give Directly Access to ref */
final userprovider = FutureProvider((ref) {
  return http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users'))
      .then((value) => usersFromJson(value.body));
});


 


  //Stream Provider


