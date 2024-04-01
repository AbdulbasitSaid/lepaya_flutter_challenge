import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'widgets/bottom_loader_widget.dart';

class ListingDetailsPage extends StatefulWidget {
  const ListingDetailsPage({
    Key? key,
    required this.pageTitle,
    required this.postUrl,
    required this.id,
  }) : super(key: key);
  final String pageTitle, postUrl, id;

  @override
  State<ListingDetailsPage> createState() => _ListingDetailsPageState();
}

class _ListingDetailsPageState extends State<ListingDetailsPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
      ),
      body: Stack(
        children: [
          WebView(
            onWebViewCreated: (controller) => _controller.complete(controller),
            initialUrl: 'https://www.reddit.com${widget.postUrl}',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finished) {
              setState(() {
                _isLoading = false;
              });
            },
          ),
          _isLoading ? const BottomLoader() : const SizedBox.shrink()
        ],
      ),
    );
  }
}
