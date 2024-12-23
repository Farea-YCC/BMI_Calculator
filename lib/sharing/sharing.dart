import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
class ShareButton extends StatelessWidget {
  const ShareButton({Key? key}) : super(key: key);
  void _sharePressed() {
    const String message = '+967717281413......فارع الضلاع';
    Share.share(message);
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _sharePressed,
      icon: const Icon(Icons.share),
    );
  }
}
