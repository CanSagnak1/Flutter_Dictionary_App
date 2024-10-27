import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:camera/camera.dart';

import 'package:kidictionary/main.dart';

void main() async {
  // Test ortamında widget başlatmadan önce kameraları başlatın
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mevcut cihaz kameralarını alın
  final cameras = await availableCameras();
  final firstCamera = cameras.isNotEmpty ? cameras.first : null;

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Kameranız yoksa null güvenliğini kontrol edin
    if (firstCamera != null) {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp(camera: firstCamera));

      // Verify that our counter starts at 0.
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Verify that our counter has incremented.
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOneWidget);
    }
  });
}
