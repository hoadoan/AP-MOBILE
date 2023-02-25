import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/utilities/color_constant.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:photo_view/photo_view.dart';

class CustomPhotoViewPage extends StatelessWidget {
  final Uint8List byteData;

  const CustomPhotoViewPage({
    Key? key,
    required this.byteData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'photo_view',
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              PhotoView(
                imageProvider: MemoryImage(
                  byteData,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    PhosphorIcons.arrow_left_bold,
                    color: ColorConstant.kWhiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
