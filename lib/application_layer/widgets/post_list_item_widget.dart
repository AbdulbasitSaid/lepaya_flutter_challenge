import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../listing_details_page.dart';
import '../models/listing_view_model.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({Key? key, required this.post}) : super(key: key);

  final ListingViewModel post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (builder) => ListingDetailsPage(
                    pageTitle: post.title,
                    postUrl: post.postUrl,
                    id: post.id,
                  ))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0),
                  blurRadius: 8,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(.08),
                )
              ],
              border: const Border(
                  top: BorderSide(
                width: 4,
                color: Color(0xffFEF074),
              ))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              post.title,
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            Text(
              post.postConent,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 3,
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
