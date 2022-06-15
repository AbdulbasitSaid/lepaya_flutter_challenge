import 'package:flutter/material.dart';
import 'package:flutter_assignment/application_layer/hot/hot_listing_page.dart';
import 'package:flutter_assignment/application_layer/new/new_listing_page.dart';
import 'package:flutter_assignment/application_layer/rising/rising_listing_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '/r/FlutterDev',
          textAlign: TextAlign.center,
        ),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: const Color(0xff4E4CEC),
          labelColor: Colors.black,
          labelStyle: GoogleFonts.lato(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
          unselectedLabelStyle: GoogleFonts.lato(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.black.withOpacity(.6)),
          tabs: const [
            Tab(
              key: Key('hot-tab'),
              text: 'Hot',
            ),
            Tab(
              key: Key('new-tab'),
              text: 'New',
            ),
            Tab(
              key: Key('rising-tab'),
              text: 'Rising',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          HotListingPage(
            key: Key('hot-listing-page'),
          ),
          NewListingPage(),
          RisingListingPage(),
        ],
      ),
    );
  }
}
