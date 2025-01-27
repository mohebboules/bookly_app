import 'package:bookly_app/core/utilities/functions/launch_url.dart';
import 'package:bookly_app/core/widgets/custom_button.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:flutter/material.dart';

class BooksAction extends StatelessWidget {
  const BooksAction({super.key, required this.book});
  final BookModel book;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
              child: CustomButton(
            backgroundColor:
                getBuyState(book) ? Colors.white : Colors.grey.shade400,
            textColor: Colors.black,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            title: getBuyState(book) ? 'Free' : 'Not available',
            onPressed: () async {
              if (!getBuyState(book)) {
                null;
              } else {
                customLaunchUrl(context, book.saleInfo?.buyLink);
              }
            },
          )),
          Expanded(
              child: CustomButton(
            backgroundColor: getPreviewState(book)
                ? const Color(0xffef8262)
                : const Color(0xffef8262).withValues(alpha: 0.8),
            textColor: Colors.white,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            fontSize: 16,
            title: getPreviewState(book) ? 'Preview' : 'Not available',
            onPressed: () async {
              if (!getPreviewState(book)) {
                null;
              } else {
                customLaunchUrl(context, book.volumeInfo.previewLink);
              }
            },
          )),
        ],
      ),
    );
  }

  bool getBuyState(BookModel book) {
    if (book.saleInfo == null || book.saleInfo!.buyLink == null) {
      return false;
    } else {
      return true;
    }
  }

  bool getPreviewState(BookModel book) {
    if (book.volumeInfo.previewLink == null) {
      return false;
    } else {
      return true;
    }
  }
}
