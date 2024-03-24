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
    final isDarkTheme = ref.watch(isDarkThemeProvider);
    return ref.watch(userprovider).when(data: (data) {
      //Dark Mode Button
      Widget darkModeButton() {
        return isDarkTheme
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                    onPressed: () {
                      ref.read(isDarkThemeProvider.notifier).state = false;
                    },
                    icon: const Icon(Icons.light_mode)),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                    onPressed: () {
                      ref.read(isDarkThemeProvider.notifier).state = true;
                    },
                    icon: const Icon(Icons.dark_mode)),
              );
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text("Riverpod API Fetch"),
          centerTitle: true,
          actions: [
            darkModeButton(),
          ],
        ),
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
