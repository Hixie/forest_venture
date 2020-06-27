import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forest_venture/main.dart';
import 'package:forest_venture/world.dart';

void main() {
  testWidgets('Most basic world', (WidgetTester tester) async {
    await tester.pumpWidget(
      GamePage(source: TestWorldSource(World(1, <Cell>[Empty()], 0, 0))),
    );
    await tester.pump();
    await expectLater(
      find.byType(WorldCanvas),
      matchesGoldenFile('basic_world_1.png'),
    );
  });

  testWidgets('Movement', (WidgetTester tester) async {
    await tester.pumpWidget(
      GamePage(
          source: TestWorldSource(World(2, <Cell>[Empty(), Goal()], 0, 0))),
    );
    await tester.pump();
    //TODO: Check image
    await expectLater(
      find.byType(WorldCanvas),
      matchesGoldenFile('basic_world_move_before.png'),
    );
    await tester.tapAt(
      Offset(
        tester.getCenter(find.byType(WorldCanvas)).dx + 60.0,
        tester.getCenter(find.byType(WorldCanvas)).dy,
      ),
    );
    //TODO: Check image again
    await expectLater(
      find.byType(WorldCanvas),
      matchesGoldenFile('basic_world_move_after.png'),
    );
  });
}

@immutable
class TestWorldSource implements WorldSource {
  TestWorldSource(this.world);
  final World world;
  Future<World> initWorld() async {
    return world;
  }
}
