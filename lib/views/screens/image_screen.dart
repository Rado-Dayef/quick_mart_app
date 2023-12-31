import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.rado.quick_mart/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageScreen extends StatelessWidget {
  final List<String> imageUrls;
  final int imageIndex;

  ImageScreen(this.imageUrls, this.imageIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: PhotoViewGallery.builder(
        itemCount: imageUrls.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(imageUrls[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered,
            basePosition: Alignment.center,
            heroAttributes: PhotoViewHeroAttributes(
              tag: imageUrls[index],
            ),
          );
        },
        scrollPhysics: ClampingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          color: AppColors.darkBlue,
        ),
        allowImplicitScrolling: true,
        pageController: PageController(
          initialPage: imageIndex,
        ),
      ),
    );
  }
}
