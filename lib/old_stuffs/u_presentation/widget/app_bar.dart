import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback backButtonPressed;
  const CustomAppBar({
    super.key,
    required this.backButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            iconSize: 35,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 35,
              color: Colors.black,
            ),
            onPressed: backButtonPressed,
          ),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'images/nature.jpg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
