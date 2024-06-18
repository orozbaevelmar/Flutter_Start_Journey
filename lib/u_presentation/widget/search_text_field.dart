// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomSearchTextField extends StatefulWidget {
  final String hintText;
  final double fontSize;
  final TextEditingController controller;
  final VoidCallback onTap;
  final ValueChanged<String>? onChanged;

  const CustomSearchTextField({
    Key? key,
    required this.hintText,
    required this.fontSize,
    required this.controller,
    required this.onTap,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87, // _height
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      child: TextField(
        style: TextStyle(
          fontSize: widget.fontSize,
        ),
        controller: widget.controller,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          prefixIcon: const Icon(Icons.search_outlined),
          hintText: widget.hintText,
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: widget.onTap,
          ),
        ),
        onTapOutside: (event) {
          //FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: widget.onChanged,
      ),
    );
  }
}
