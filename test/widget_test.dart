// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:park_do_jao/Constants/Enums.dart';
import 'package:park_do_jao/Models/Lote.dart';
import 'package:park_do_jao/View/Home/components/OptionCard.dart';
import 'package:park_do_jao/View/Home/components/OptionList.dart';
import 'package:park_do_jao/View/Home/components/TopNameWidget.dart';
import 'package:park_do_jao/View/Park/ParkView.dart';
import 'package:park_do_jao/View/Park/components/ParkingSpot.dart';
import 'package:park_do_jao/View/Park/components/SelectedSpot.dart';
import 'package:park_do_jao/ViewModel/ParkViewModel.dart';
import 'package:park_do_jao/ViewModel/ReportViewModel.dart';
import 'package:park_do_jao/firebase_options.dart';

import 'package:park_do_jao/main.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  Get.testMode = true;
  group("Home Page Navigation Test", () {
    late NavigatorObserver mockObserver;
    setUp(() {
      mockObserver = MockNavigatorObserver();
    });
    testWidgets('Option Card Filled Teste', (WidgetTester tester) async {
      Get.put(ParkViewModel(isTest: true));
      await tester.pumpWidget(
        GetMaterialApp(
          home: OptionCard(
            TipoOperacao.entrada,
          ),
          navigatorObservers: [mockObserver],
        ),
      );

      expect(find.byType(Icon), findsOneWidget);
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any!, any));
      expect(find.byType(ParkView), findsOneWidget);
    });
  });
  testWidgets('Home Page Teste', (WidgetTester tester) async {
    Get.put(ParkViewModel(isTest: true));
    Get.put(ReportViewModel());
    await tester.pumpWidget(
      MyApp(),
    );
    expect(find.byType(TopNameWidget), findsOneWidget);
    expect(find.byType(OptionList), findsOneWidget);
  });
  testWidgets('Selected Spots Teste', (WidgetTester tester) async {
    Get.put(ParkViewModel(isTest: true));
    ParkViewModel s = Get.find();
    await tester.pumpWidget(
      GetMaterialApp(
        home: ParkingSpot(
          s.lotes[0],
        ),
      ),
    );

    expect(find.byKey(Key('selectedSpot')), findsWidgets);
  });
}
