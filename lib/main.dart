import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_flutter/providers/provider.dart';

import 'screens/users/grocery_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          useMaterial3: true,
        ),
        home: const GroceryScreeen());
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);
    final counter = ref.watch(counterChangeNotifierProvider);
    // log("proivder called");
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "You have pressd the button this many times",
                style: TextStyle(fontSize: 24),
              ),
              Text(
                counter.count.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              Switch(
                  value: isDarkTheme,
                  onChanged: (value) {
                    ref.read(isDarkThemeProvider.notifier).state = value;
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // log("Pressed provider");
          ref.read(counterChangeNotifierProvider.notifier).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
