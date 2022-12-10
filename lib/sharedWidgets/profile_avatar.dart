import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/config/palette.dart';

class ProfileAvatar extends StatelessWidget {

  final String imageUrl;
  final bool isActive;
  final bool hasBorder;
  final double radius;
  final double borderWidth;

  const ProfileAvatar({
    Key? key,
    required this.imageUrl,
    this.isActive = false,
    this.hasBorder = false,
    this.radius = 20.0,
    this.borderWidth = 17.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: Palette.mainColor,
          child: CircleAvatar(
            radius: hasBorder? borderWidth : radius,
            backgroundColor: Colors.grey[200],
            backgroundImage: ExtendedNetworkImageProvider(
              imageUrl,
              cache: true,
              cacheRawData: true
            ),
          ),
        ),
        isActive ? Positioned(
            bottom: 0.0,
            right: 0.0,
            child: Container(
              height: 15.0,
              width: 15.0,
              decoration: BoxDecoration(
                color: Palette.mainColor,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.0,
                  color: Colors.white,
                ),
              ),
            ),
        ) : const SizedBox.shrink(),
      ],
    );
  }
}
