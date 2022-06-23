import 'package:flutter/material.dart';
import 'package:flutter_assignment/application_layer/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../di/get_it.dart';
import 'hot/bloc/hot_bloc.dart';
import 'new/bloc/new_bloc.dart';
import 'rising/bloc/rising_bloc.dart';

class App extends MaterialApp {
  App({Key? key})
      : super(
          key: key,
          theme: ThemeData(
              appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.0,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: GoogleFonts.lato(
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            centerTitle: false,
          )),
          home: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => HotBloc(redditRepository: getItInstance())
                  ..add(HotListingFetched()),
              ),
              BlocProvider(
                create: (context) => NewBloc(redditRepository: getItInstance())
                  ..add(NewListingFetched()),
              ),
              BlocProvider(
                create: (context) =>
                    RisingBloc(redditRepository: getItInstance())
                      ..add(RisingListingFetched()),
              ),
            ],
            child: const HomePage(),
          ),
        );
}
