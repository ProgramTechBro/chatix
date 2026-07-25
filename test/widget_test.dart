import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chatix/config/app.dart';

void main() {
  testWidgets('ChatixApp renders', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: ChatixApp()));

    expect(find.text('Chatix'), findsOneWidget);
  });
}
