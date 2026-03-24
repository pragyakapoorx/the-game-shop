import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_game_shop/app.dart';

void main() {
  testWidgets('App load smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Wrapped in ProviderScope because the app uses Riverpod
    await tester.pumpWidget(
      const ProviderScope(
        child: TheGameShopApp(),
      ),
    );

    // Verify that the app starts (checking for the main app widget)
    expect(find.byType(TheGameShopApp), findsOneWidget);
  });
}
