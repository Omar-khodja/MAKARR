import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.fun,
    this.leadIcon,
    this.tailIcon,
  });
  final String label;
  final VoidCallback fun;
  final IconData? leadIcon;
  final IconData? tailIcon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: fun,
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),

      child: Row(
        mainAxisAlignment: .center,
        children: [
          if (leadIcon != null)  Icon(leadIcon, size: 24),
          const SizedBox(width: 5),
           Text(label, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 5),
          if (tailIcon != null)  Icon(tailIcon, size: 24),
        ],
      ),
    );
  }
}
