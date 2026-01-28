import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/features/bloc/bloc/cart/bloc/cart_bloc.dart';
import 'package:shopify/features/bloc/bloc/cart/bloc/cart_event.dart' show AddToCartEvent;
import '../model/product_model.dart';


class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
              ),
            ),
          ),

          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        product.description,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: 
                    ElevatedButton(
  onPressed: () {
    context.read<CartBloc>().add(AddToCartEvent(product));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product added to cart'),
      ),
    );
  },
  child: const Text('Add to Cart'),
)


                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
