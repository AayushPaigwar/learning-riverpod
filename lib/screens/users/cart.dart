import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_flutter/providers/provider.dart';

import '../../models/grocery.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Screen"),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text(
                "Cart is Empty!",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(fontSize: 18)),
              ),
            )
          : ListView.builder(
              itemCount: cartItems.length,
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
                            Text(
                                "Name: ${grocerylist[cartItems[index]]["name"].toString()}",
                                style: GoogleFonts.poppins()),
                            Text(
                              "Category: ${grocerylist[cartItems[index]]["category"].toString()}",
                              style: GoogleFonts.poppins(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              style: const ButtonStyle(
                                  foregroundColor:
                                      MaterialStatePropertyAll(Colors.red),
                                  fixedSize:
                                      MaterialStatePropertyAll(Size(180, 30))),
                              onPressed: () {
                                ref.read(cartProvider.notifier).remove(index);
                              },
                              child: Text(
                                "Remove from cart",
                                style: GoogleFonts.poppins(),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
    );
  }
}
