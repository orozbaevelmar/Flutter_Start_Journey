import 'package:flutter/material.dart';
import 'package:start_journey/home_categories/store_abstract_class/attraction.dart';

class ShowImageOnTap extends StatefulWidget {
  final int _index;
  final String _whichElement;
  final Attraction _store;
  final int? _countFilesInFolder;
  ShowImageOnTap(
      this._store, this._whichElement, this._index, this._countFilesInFolder);

  @override
  State<ShowImageOnTap> createState() => _ShowImageOnTapState();
}

class _ShowImageOnTapState extends State<ShowImageOnTap> {
  late PageController _pageController =
      PageController(initialPage: widget._index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
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