import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chatix/app/chatix_app.dart';
import 'package:chatix/features/splash/presentation/screens/splash_screen.dart';

void main() {
  testWidgets('ChatixApp boots into SplashScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: ChatixApp()));

    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
