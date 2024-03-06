import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black, // Change the color of drawer icon here
      ),
      title: RichText(
        text: const TextSpan(
          style: TextStyle(
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(
                blurRadius: 2,
                color: Colors.grey,
                offset: Offset(0, 1),
              ),
            ],
          ),
          children: [
            TextSpan(
              text: 'Fit',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Jost',
                fontSize: 30,
              ),
            ),
            TextSpan(
              text: 'Friend',
              style: TextStyle(
                color: Color(0xFFF54242),
                fontFamily: 'Jost',
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      //elevation: 0.0,
      toolbarHeight: 80.0,
      backgroundColor: const Color(0xFFE2E2E2),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(80.0);
}
