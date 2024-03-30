import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_flutter/models/grocery.dart';
import 'package:riverpod_flutter/screens/users/cart.dart';

import '../../providers/provider.dart';

class GroceryScreeen extends ConsumerStatefulWidget {
  const GroceryScreeen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GroceryScreeenState();
}

class _GroceryScreeenState extends ConsumerState<GroceryScreeen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final isDarkTheme = ref.watch(isDarkThemeProvider);
    //Dark Mode Button
    Widget darkModeButton() {
      return isDarkTheme
          ? Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                  onPressed: () {
                    ref.read(isDarkThemeProvider.notifier).state = false;
                  },
                  icon: const Icon(
                    Icons.light_mode,
                    size: 30,
                  )),
            )
          : Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                  onPressed: () {
                    ref.read(isDarkThemeProvider.notifier).state = true;
                  },
                  icon: const Icon(
                    Icons.dark_mode,
                    size: 30,
                  )),
            );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Grocery List"),
        centerTitle: true,
        actions: [
          darkModeButton(),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    //Navigate to cart screen
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 4,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.pink,
                    child: Text(
                      cartItems.length.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: grocerylist.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        grocerylist[index]['image'].toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name: ${grocerylist[index]["name"].toString()}",
                            style: GoogleFonts.poppins()),
                        Text(
                          "Category: ${grocerylist[index]["category"].toString()}",
                          style: GoogleFonts.poppins(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        cartItems.contains(index)
                            ? ElevatedButton(
                                style: const ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.red),
                                    fixedSize: MaterialStatePropertyAll(
                                        Size(180, 30))),
                                onPressed: () {
                                  ref.read(cartProvider.notifier).remove(index);
                                },
                                child: Text(
                                  "Remove from cart",
                                  style: GoogleFonts.poppins(),
                                ),
                              )
                            : ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.pink),
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.white),
                                    fixedSize: MaterialStatePropertyAll(
                                        Size(180, 30))),
                                onPressed: () {
                                  ref.read(cartProvider.notifier).add(index);
                                },
                                child: Text(
                                  "Add to Cart",
                                  style: GoogleFonts.poppins(),
                                ))
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
