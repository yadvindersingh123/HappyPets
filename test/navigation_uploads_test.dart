import 'package:HAPPYPETS/screens/home.dart';
import 'package:HAPPYPETS/screens/profile.dart';
import 'package:HAPPYPETS/screens/social meadia.dart';
import 'package:HAPPYPETS/screens/uploads.dart';
import 'package:HAPPYPETS/services/pet_upload_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('Four tabs open the correct screen without stacking routes',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Social()));
    expect(find.text('Search'), findsNothing);
    for (final tab in [
      ('Upload', UploadsScreen, 1),
      ('Profile', ProfileScreen, 3),
      ('Services', Home, 2),
      ('Home', Social, 0)
    ]) {
      await tester.tap(find.descendant(
          of: find.byType(BottomNavigationBar), matching: find.text(tab.$1)));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.byType(tab.$2), findsOneWidget);
      expect(
          tester
              .widget<BottomNavigationBar>(find.byType(BottomNavigationBar))
              .currentIndex,
          tab.$3);
      expect(
          Navigator.of(tester.element(find.byType(tab.$2))).canPop(), isFalse);
      expect(tester.takeException(), isNull);
    }
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('Saved photo and report appear after reopening uploads',
      (tester) async {
    final photo =
        (await rootBundle.load('assets/dog.jpeg')).buffer.asUint8List();
    final report = Uint8List.fromList('%PDF-1.4 report'.codeUnits);
    await PetUploadStore.save([
      PetUpload(name: 'Milo.jpg', isPhoto: true, bytes: photo),
      PetUpload(name: 'Vaccination.pdf', isPhoto: false, bytes: report),
    ]);
    final restored = await PetUploadStore.load();
    expect(restored.last.bytes, report);
    await tester.pumpWidget(const MaterialApp(home: UploadsScreen()));
    await tester.pumpAndSettle();
    expect(find.text('Milo.jpg'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    await tester.ensureVisible(find.text('Vaccination.pdf'));
    expect(find.text('Vaccination.pdf'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
