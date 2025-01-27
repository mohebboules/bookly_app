import 'package:bookly_app/core/utilities/functions/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> customLaunchUrl(BuildContext context, String? url) async {
  if (url == null) {
    showSnackBar(context, 'Could not launch URL');
  } else {
    Uri? uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      if (context.mounted) {
        showSnackBar(context, url);
      }
    }
  }
}
