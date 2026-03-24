import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/cyber_colors.dart';
import 'shared/layout/main_layout.dart';
import 'features/store/store_screen.dart';
import 'features/game_detail/game_detail_screen.dart';
import 'features/checkout/checkout_screen.dart';
import 'features/library/library_screen.dart';
import 'features/orders/orders_screen.dart';
import 'features/orders/orders_screen.dart';

// Temporary placeholder until we build the real screens next
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Center(
    child: Text(title, style: const TextStyle(color: CyberColors.green, fontSize: 24, fontFamily: 'Orbitron')),
  );
}

final _router = GoRouter(
  initialLocation: '/store',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/store',
          builder: (context, state) => const StoreScreen(), // <-- Update this!
        ),
        GoRoute(
          path: '/game/:id',
          builder: (context, state) {
            final gameId = int.parse(state.pathParameters['id']!);
            return GameDetailScreen(gameId: gameId);
          },
        ),
        GoRoute(
          path: '/library',
          builder: (context, state) => const LibraryScreen(),
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const CheckoutScreen(),
        ),
        GoRoute(
          path: '/orders',
          builder: (context, state) => const OrdersScreen(),
        ),
      ],
    ),
  ],
);

class TheGameShopApp extends StatelessWidget {
  const TheGameShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TheGameShop',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        scaffoldBackgroundColor: CyberColors.bg,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: CyberColors.text,
          displayColor: CyberColors.text,
        ),
      ),
    );
  }
}