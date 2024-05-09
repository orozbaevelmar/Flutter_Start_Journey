import 'package:flutter/material.dart';
import 'package:start_journey/utils/store_abstract_class/attraction.dart';

class ShowImageOnTap extends StatefulWidget {
  final int _index;
  final String _whichElement;
  final Attraction _store;
  final int? _countFilesInFolder;
  const ShowImageOnTap(
      this._store, this._whichElement, this._index, this._countFilesInFolder,
      {super.key});

  @override
  State<ShowImageOnTap> createState() => _ShowImageOnTapState();
}

class _ShowImageOnTapState extends State<ShowImageOnTap> {
  late final PageController _pageController =
      PageController(initialPage: widget._index);

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
              itemCount: widget._countFilesInFolder, // FIX
              itemBuilder: (context, index) {
                return Center(
                  child: Image(
                    image: AssetImage(
                      widget._store.showImageOnTap(widget._whichElement, index),
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
/* GestureDetector(
        //onTap: () => Navigator.pop(context),
        onHorizontalDragUpdate: (details) {
          int sensitivity = 20;
          if (details.delta.dx > sensitivity) {
            setState(() {
              //Right Swipe
              widget._index--;
            });
          } else if (details.delta.dx < -sensitivity) {
            setState(() {
              //Left Swipe
              widget._index++;
            });
          }
        },
        child: Center(
          child: Image(
            image: AssetImage(
              widget._store.showImageOnTap(widget._whichElement, widget._index),
            ),
          ),
        ),
      ), */