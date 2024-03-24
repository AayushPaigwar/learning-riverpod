import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/providers/provider.dart';

class MyUsers extends ConsumerStatefulWidget {
  const MyUsers({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyUsersState();
}

class _MyUsersState extends ConsumerState<MyUsers> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(userprovider).when(data: (data) {
      return Scaffold(
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index].name),
                subtitle: Text(data[index].email),
              );
            }),
      );
    }, error: (error, stackTrace) {
      return const Scaffold(
        body: Center(
          child: Text("Error : loading data failed"),
        ),
      );
    }, loading: () {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
