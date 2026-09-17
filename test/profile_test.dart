import 'dart:convert';

import 'package:HAPPYPETS/models.dart';
import 'package:HAPPYPETS/screens/profile.dart';
import 'package:HAPPYPETS/services/pet_profile_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('Saved profile displays entered details and uploaded photo',
      (tester) async {
    final photo =
        (await rootBundle.load('assets/dog.jpeg')).buffer.asUint8List();
    final pet = PetDataModel(
        name: 'Milo',
        type: 'Dog',
        gender: 'Male',
        breed: 'Labrador',
        age: '2 years',
        food: 'Chicken',
        activity: 'Playing fetch');
    await PetProfileStore.save(pet, photo);
    final restored = await PetProfileStore.load();
    expect(restored!.name, 'Milo');
    expect(base64Decode(restored.image), photo);
    await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Milo'), findsWidgets);
    expect(find.text('Dog'), findsWidgets);
    expect(find.byType(Image), findsOneWidget);
    expect(tester.widget<Image>(find.byType(Image)).image, isA<MemoryImage>());
    for (final value in [
      '2 years',
      'Playing fetch',
      'Chicken',
      'Labrador',
      'Male'
    ]) {
      await tester.ensureVisible(find.text(value));
      expect(find.text(value), findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('Profile has an empty state before setup is saved',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));
    await tester.pumpAndSettle();
    expect(find.textContaining('No pet profile yet'), findsOneWidget);
  });

  testWidgets('Missing optional values and photo have placeholders',
      (tester) async {
    await PetProfileStore.save(
        PetDataModel(name: 'Luna', type: 'Cat', gender: 'Female'),
        Uint8List(0));
    await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Not provided'), findsWidgets);
    expect(find.byType(Image), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
