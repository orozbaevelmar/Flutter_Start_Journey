import 'package:flutter/material.dart';

class CustomCategories extends StatelessWidget {
  const CustomCategories({
    super.key,
    required this.fontSizeSmall,
    required this.yourWishes,
  });

  final double fontSizeSmall;
  final List<String> yourWishes;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            //
            // Will be deleted in the future
            // StatefulWidget

            Container(
              margin: EdgeInsets.only(
                right: 20,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.green, // reWrote
                border: Border.all(
                  color: Colors.green, // reWrote
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {},
                child: Text(
                  "Near You",
                  style: TextStyle(
                    fontSize: fontSizeSmall,
                    color: Colors.white, // rewrote
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Until here(_DELETE_)

            for (int i = 0; i < yourWishes.length; i++)
              Container(
                margin: EdgeInsets.only(
                  right: 20,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    yourWishes[i],
                    style: TextStyle(
                        fontSize: fontSizeSmall,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
