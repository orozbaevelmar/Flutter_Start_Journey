import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:start_journey/cleanArch/core/utils/snackbar_service.dart';

void main() {
  group('SnackBarService', () {
    late SnackBarService snackBarService;

    setUp(() {
      snackBarService = SnackBarService();
    });

    testWidgets('should show success snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => snackBarService.showSuccess(
                  'Success message',
                ),
                child: const Text('Show SnackBar'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show SnackBar'));
      await tester.pump();

      expect(find.text('Success message'), findsOneWidget);
      expect(
        tester.widget<SnackBar>(find.byType(SnackBar)).backgroundColor,
        equals(Colors.green),
      );
    });

    testWidgets('should show error snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => snackBarService.showError('Error message'),
                child: const Text('Show SnackBar'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show SnackBar'));
      await tester.pump();

      expect(find.text('Error message'), findsOneWidget);
      expect(
        tester.widget<SnackBar>(find.byType(SnackBar)).backgroundColor,
        equals(Colors.red),
      );
    });

    testWidgets('should show warning snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => snackBarService.showWarning(
                  'Warning message',
                ),
                child: const Text('Show SnackBar'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show SnackBar'));
      await tester.pump();

      expect(find.text('Warning message'), findsOneWidget);
      expect(
        tester.widget<SnackBar>(find.byType(SnackBar)).backgroundColor,
        equals(Colors.orange),
      );
    });

    testWidgets('should show info snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => snackBarService.showInfo('Info message'),
                child: const Text('Show SnackBar'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show SnackBar'));
      await tester.pump();

      expect(find.text('Info message'), findsOneWidget);
      expect(
        tester.widget<SnackBar>(find.byType(SnackBar)).backgroundColor,
        equals(Colors.blue),
      );
    });

    testWidgets('should show custom snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => snackBarService.showCustomSnackBar(
                  context,
                  message: 'Custom message',
                  backgroundColor: Colors.purple,
                  duration: const Duration(seconds: 2),
                ),
                child: const Text('Show SnackBar'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show SnackBar'));
      await tester.pump();

      expect(find.text('Custom message'), findsOneWidget);
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.backgroundColor, equals(Colors.purple));
      expect(snackBar.duration, equals(const Duration(seconds: 2)));
    });
  });
}
