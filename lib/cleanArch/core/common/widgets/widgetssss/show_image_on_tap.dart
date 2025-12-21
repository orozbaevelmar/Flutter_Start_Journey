import 'package:flutter/material.dart';
import 'package:start_journey/cleanArch/core/common/entity/photo_entity.dart';

class ShowImageOnTap extends StatefulWidget {
  final int index;
  final List<PhotosEntity> photos;
  const ShowImageOnTap({
    super.key,
    required this.index,
    required this.photos,
  });

  @override
  State<ShowImageOnTap> createState() => _ShowImageOnTapState();
}

class _ShowImageOnTapState extends State<ShowImageOnTap> {
  late final PageController _pageController =
      PageController(initialPage: widget.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 35,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.photos.length, // FIX
              itemBuilder: (context, index) {
                return Center(
                  child: Image(
                    image: AssetImage(
                      widget.photos[index].photo ?? '',
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
