import 'package:bookly_app/constants.dart';
import 'package:bookly_app/core/utilities/styles.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/book_rating_item.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/books_action.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection({super.key, required this.book});
  final BookModel book;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.2),
          child: CustomBookImage(
            imageUrl: book.volumeInfo.imageLinks?.thumbnail ??
                'https://books.google.com/books/content?id=_Sbju4F0AVAC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        Text(
          book.volumeInfo.title!,
          style: Styles.textStyle30
              .copyWith(fontFamily: kGtSectraFine, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          book.volumeInfo.authors?[0] ?? 'Unknown author',
          style: Styles.textStyle18.copyWith(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        BookRating(
          mainAxisAlignment: MainAxisAlignment.center,
          rating: book.volumeInfo.averageRating ?? 0,
          count: book.volumeInfo.ratingsCount ?? 0,
        ),
        const SizedBox(
          height: 20,
        ),
        BooksAction(
          book: book,
        ),
      ],
    );
  }
}
