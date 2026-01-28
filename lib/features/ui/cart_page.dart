import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/features/bloc/bloc/cart/bloc/cart_bloc.dart';
import 'package:shopify/features/bloc/bloc/cart/bloc/cart_event.dart';
import 'package:shopify/features/bloc/bloc/cart/bloc/cart_state.dart';
import 'package:shopify/features/ui/card_upi_page.dart';
import 'package:shopify/features/ui/cash_on_delivery_page.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartUpdatedState) {
            if (state.items.isEmpty) {
              return const Center(child: Text('Cart is empty'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];

return ListTile(
  
  title: Text(item.product.title),
  subtitle: Text('\$${item.product.price}'),
  trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    IconButton(
      icon: const Icon(Icons.remove),
      onPressed: () {
        context.read<CartBloc>().add(
          DecreaseQtyEvent(item.product),
        );
      },
    ),

    Text(
      item.quantity.toString(),
      style: const TextStyle(fontSize: 16),
    ),

    IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        context.read<CartBloc>().add(
          IncreaseQtyEvent(item.product),
        );
      },
    ),

    const SizedBox(width: 6),
    ElevatedButton(
  onPressed: () {
    _showPaymentPopup(context, item.product);
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    padding: const EdgeInsets.symmetric(horizontal: 12),
  ),
  child: const Text("Buy"),
),


  ],
),

);

                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Total: \$${state.totalPrice}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            context
                                .read<CartBloc>()
                                .add(ClearCartEvent());

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Checkout successful'),
                              ),
                            );

                            Navigator.pop(context);
                          },
                          child: const Text('Checkout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

void _showPaymentPopup(BuildContext parentContext, product) {
  showDialog(
    context: parentContext,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text("Select Payment Method"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 45),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);

                parentContext
                    .read<CartBloc>()
                    .add(RemoveFromCartEvent(product));

                Navigator.push(
                  parentContext,
                  MaterialPageRoute(
                    builder: (_) => const CashOnDeliveryPage(),
                  ),
                );
              },
              child: const Text("Cash on Delivery"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 45),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);

                parentContext
                    .read<CartBloc>()
                    .add(RemoveFromCartEvent(product));

                Navigator.push(
                  parentContext,
                  MaterialPageRoute(
                    builder: (_) => const CardUpiPage(),
                  ),
                );
              },
              child: const Text("Card / UPI"),
            ),
          ],
        ),
      );
    },
  );
}
