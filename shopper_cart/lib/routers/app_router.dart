import 'package:go_router/go_router.dart';
import 'package:shopper_cart/screens/cart_screen.dart';
import 'package:shopper_cart/screens/login_screen.dart';
import 'package:shopper_cart/screens/product_screen.dart';

GoRouter router() {
  return GoRouter(initialLocation: '/login', routes: [
    GoRoute(
      path: '/login', 
      builder: (context, state) => LoginScreen()
    ),
    GoRoute(
      path: '/products', 
      builder: (context, state) => ProductScreen()
    ),
    GoRoute(
      path: '/cart', 
      builder: (context, state) => CartScreen()
    ),
  ]);
}
