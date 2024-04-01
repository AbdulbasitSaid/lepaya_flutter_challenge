import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/application_layer/home_page.dart';
import 'package:flutter_assignment/application_layer/hot/bloc/hot_bloc.dart';
import 'package:flutter_assignment/application_layer/new/bloc/new_bloc.dart';
import 'package:flutter_assignment/application_layer/rising/bloc/rising_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHotBloc extends MockBloc<HotEvent, HotState> implements HotBloc {}

class MockNewBloc extends MockBloc<NewEvent, NewState> implements NewBloc {}

class MockRisingBloc extends MockBloc<RisingEvent, RisingState>
    implements RisingBloc {}

class HotStateFake extends Fake implements HotState {}

class HotEventFake extends Fake implements HotEvent {}

void main() {
  group('HomePage', () {
    setUpAll(() {
      registerFallbackValue(HotStateFake());
      registerFallbackValue(HotEventFake());
    });
    setUp(() {});
    testWidgets(
      "home page an app bar",
      (WidgetTester tester) async {
        final hotBloc = MockHotBloc();
        final newBloc = MockNewBloc();
        final risingBloc = MockRisingBloc();
        when(() => hotBloc.state).thenReturn(const HotState());
        await tester.pumpWidget(MultiBlocProvider(
            providers: [
              BlocProvider<HotBloc>(
                create: (context) => hotBloc..add(HotListingFetched()),
              ),
              BlocProvider<NewBloc>(
                create: (context) => newBloc..add(NewListingFetched()),
              ),
              BlocProvider<RisingBloc>(
                create: (context) => risingBloc..add(RisingListingFetched()),
              ),
            ],
            child: const MaterialApp(
              home: HomePage(),
            )));
        expect(find.byType(AppBar), findsOneWidget);
      },
    );
  });
}
