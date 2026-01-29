
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shopify/features/bloc/bloc/home_bloc.dart';
// import 'package:shopify/features/bloc/bloc/home_event.dart';
// import 'package:shopify/features/bloc/bloc/home_state.dart';
// import 'package:shopify/features/ui/cart_page.dart';

// import '../model/product_model.dart';
// import 'product_detail_page.dart';

// class HomePage extends StatefulWidget {
//     final String userName;
//   const HomePage({super.key, required this.userName});

//   // const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final HomeBloc homeBloc = HomeBloc();

//   final categories = ['All', 'electronics', 'jewelery', "men", "women"];

//   @override
//   void initState() {
//     super.initState();
//     homeBloc.add(FetchProductsEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _appBar(),
//       body: BlocBuilder<HomeBloc, HomeState>(
//         bloc: homeBloc,
//         builder: (context, state) {
//           if (state is HomeLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is HomeLoadedState) {
//             return Column(
//               children: [
//                 _searchBar(),
//                 _categories(state.selectedCategory),
//                 Expanded(child: _grid(state.products)),
//               ],
//             );
//           }

//           return const Center(child: Text('Something went wrong'));
//         },
//       ),
//     );
//   }

//   AppBar _appBar(dynamic userName) => AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Shopify',
//           style: TextStyle(
//             color: Color(0xFF111418),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         leading:  Text(
//           "Welcome $userName ",
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         // leading: const Icon(Icons.menu, color: Color(0xFF111418)),
//         actions: [
//   IconButton(
//     icon: const Icon(Icons.shopping_cart),
//     onPressed: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) =>  CartPage(),
//         ),
//       );
//     },
//   ),
// ],

//       );

//   Widget _searchBar() => Padding(
//         padding: const EdgeInsets.all(16),
//         child: TextField(
//           decoration: InputDecoration(
//             hintText: 'Search products...',
//             prefixIcon: const Icon(Icons.search),
//             filled: true,
//             fillColor: Colors.grey.shade100,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(14),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ),
//       );

//   Widget _categories(String selected) => SizedBox(
//         height: 42,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           itemCount: categories.length,
//           itemBuilder: (context, index) {
//             final cat = categories[index];
//             final isSelected = cat == selected;

//             return GestureDetector(
//               onTap: () {
//                 homeBloc.add(FilterByCategoryEvent(cat));
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(right: 8),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.blue : Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   cat,
//                   style: TextStyle(
//                     color: isSelected ? Colors.white : Colors.black,
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       );

//   Widget _grid(List<ProductModel> products) => GridView.builder(
//         padding: const EdgeInsets.all(16),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 16,
//           crossAxisSpacing: 16,
//           childAspectRatio: 0.65,
//         ),
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final p = products[index];

//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => ProductDetailPage(product: p),
//                 ),
//               );
//             },
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8),
//                       child: Image.network(
//                         p.image,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: Text(
//                       p.title,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Text(
//                       '\$${p.price}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
// import 'package:http/http.dart' as box;
// import 'package:shopify/features/bloc/bloc/home_bloc.dart';
// import 'package:shopify/features/bloc/bloc/home_event.dart';
// import 'package:shopify/features/bloc/bloc/home_state.dart';
// import 'package:shopify/features/ui/cart_page.dart';
// import 'package:shopify/features/ui/login_page.dart';

// import '../model/product_model.dart';
// import 'product_detail_page.dart';

// class HomePage extends StatefulWidget {
//   final String userName;

//   const HomePage({
//     super.key,
//     required this.userName,
//   });

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final HomeBloc homeBloc = HomeBloc();

//   final List<String> categories = [
//     'All',
//     'electronics',
//     'jewelery',
//     "men's clothing",
//     "women's clothing",
//   ];

//   @override
//   void initState() {
//     super.initState();
//     homeBloc.add(FetchProductsEvent());
//   }

//   @override
//   void dispose() {
//     homeBloc.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//        final box = Hive.box('logindata');

//     return Scaffold(
//       appBar: _appBar(),
//       body: BlocBuilder<HomeBloc, HomeState>(
//         bloc: homeBloc,
//         builder: (context, state) {
//           if (state is HomeLoadingState) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is HomeLoadedState) {
//             return Column(
//               children: [
//                 _searchBar(),
//                 _categories(state.selectedCategory),
//                 Expanded(child: _grid(state.products)),
//               ],
//             );
//           }

//           return const Center(child: Text('Something went wrong'));
//         },
//       ),
//     );
//   }

//   // ================= APP BAR =================

//   AppBar _appBar() => AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
        
//         title: const Text(
//           'Shopify',
//           style: TextStyle(
//             color: Color(0xFF111418),
//             fontWeight: FontWeight.bold,
//           ),
          
//         ),
      
        
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 12),
//           child: Center(
//             child: Text(
//               "Hi, ${widget.userName}",
//               style: const TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.shopping_cart, color: Colors.black),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => CartPage()),
//               );
//             },
//           ),
//                     IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               box.delete('currentUser' );

//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const LoginPage(),
//                 ),
//                 (route) => false,
//               );
//             },
//           )

//         ],
//       );

//   // ================= SEARCH BAR =================

//   Widget _searchBar() => Padding(
//         padding: const EdgeInsets.all(16),
//         child: TextField(
//           decoration: InputDecoration(
//             hintText: 'Search products...',
//             prefixIcon: const Icon(Icons.search),
//             filled: true,
//             fillColor: Colors.grey.shade100,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(14),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ),
//       );

//   // ================= CATEGORIES =================

//   Widget _categories(String selected) => SizedBox(
//         height: 42,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           itemCount: categories.length,
//           itemBuilder: (context, index) {
//             final cat = categories[index];
//             final isSelected = cat == selected;

//             return GestureDetector(
//               onTap: () {
//                 homeBloc.add(FilterByCategoryEvent(cat));
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(right: 8),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: isSelected ? Colors.blue : Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   cat,
//                   style: TextStyle(
//                     color: isSelected ? Colors.white : Colors.black,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       );

//   // ================= PRODUCT GRID =================

//   Widget _grid(List<ProductModel> products) => GridView.builder(
//         padding: const EdgeInsets.all(16),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 16,
//           crossAxisSpacing: 16,
//           childAspectRatio: 0.65,
//         ),
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final product = products[index];

//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) =>
//                       ProductDetailPage(product: product),
//                 ),
//               );
//             },
//             child: Card(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8),
//                       child: Image.network(
//                         product.image,
//                         fit: BoxFit.contain,
//                         errorBuilder: (_, __, ___) =>
//                             const Icon(Icons.image_not_supported),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: Text(
//                       product.title,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Text(
//                       '\$${product.price}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import 'package:shopify/features/bloc/bloc/home_bloc.dart';
import 'package:shopify/features/bloc/bloc/home_event.dart';
import 'package:shopify/features/bloc/bloc/home_state.dart';
import 'package:shopify/features/ui/cart_page.dart';
import 'package:shopify/features/ui/login_page.dart';

import '../model/product_model.dart';
import 'product_detail_page.dart';

class HomePage extends StatefulWidget {
  final String userName;

  const HomePage({
    super.key,
    required this.userName,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = HomeBloc();
  late Box loginBox;

  final List<String> categories = [
    'All',
    'electronics',
    'jewelery',
    "men's clothing",
    "women's clothing",
  ];

  @override
  void initState() {
    super.initState();
    loginBox = Hive.box('logindata');
    homeBloc.add(FetchProductsEvent());
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeLoadedState) {
            return Column(
              children: [
                _searchBar(),
                _categories(state.selectedCategory),
                Expanded(child: _grid(state.products)),
              ],
            );
          }

          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  // ================= APP BAR =================

  AppBar _appBar() => AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Shopify',
          style: TextStyle(
            color: Color(0xFF111418),
            fontWeight: FontWeight.bold,
          ),
        ),

        // 👇 FIXED leading
        leading: SizedBox(
          width: 120,
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Center(
              child: Text(
                "Welcome, ${widget.userName}",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CartPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              loginBox.delete('currentUser');

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      );


  Widget _searchBar() => Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search products...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      );

  // ================= CATEGORIES =================

  Widget _categories(String selected) => SizedBox(
        height: 42,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final cat = categories[index];
            final isSelected = cat == selected;

            return GestureDetector(
              onTap: () {
                homeBloc.add(FilterByCategoryEvent(cat));
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  cat,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      );

  // ================= PRODUCT GRID =================

  Widget _grid(List<ProductModel> products) => GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.65,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(product: product),
                ),
              );
            },
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.network(
                        product.image,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      );
}
