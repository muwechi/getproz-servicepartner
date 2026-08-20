import 'package:flutter_test/flutter_test.dart';
import 'package:servicepartner/main.dart';

void main() {
  testWidgets('GoServices Partner App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const GoServicesPartnerApp());
    expect(find.text('GoServices Partner'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
  });
}
