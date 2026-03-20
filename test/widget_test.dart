import 'package:flutter_test/flutter_test.dart';
import 'package:retired_professionals_app/main.dart';

void main() {
  testWidgets('Login screen is shown', (WidgetTester tester) async {
    await tester.pumpWidget(const RetiredProfessionalsApp());
    expect(find.text('Retired Experience Platform'), findsOneWidget);
    expect(find.text('Send OTP'), findsOneWidget);
  });
}
