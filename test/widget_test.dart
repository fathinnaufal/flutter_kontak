import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_contact/form_kontak.dart';
import 'package:flutter_contact/list_kontak.dart';

void main() {
  testWidgets('FormKontak UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FormKontak()));

    expect(find.text('Form Kontak'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(4));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('ListKontakPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ListKontakPage()));

    expect(find.text('Kontak App'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
