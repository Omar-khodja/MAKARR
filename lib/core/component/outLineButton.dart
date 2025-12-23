import 'package:flutter/material.dart';

class OutLineButton extends StatelessWidget {
  const OutLineButton({
    super.key,
    required this.text,
    required this.fun,
    this.image,
    this.leadIcon,
    this.tailIcon,
  });
  final String text;
  final String? image;
  final VoidCallback fun;
  final IconData? leadIcon;
  final IconData? tailIcon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
        ),
      ),
      onPressed: fun,
      child: Row(
        mainAxisAlignment: .center,
        children: [
          if (image != null) Image.asset(image!, width: 24, height: 24),
          if (leadIcon != null) Icon(leadIcon, size: 24),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          if (tailIcon != null) Icon(tailIcon, size: 24),
        ],
      ),
    );
  }
}
