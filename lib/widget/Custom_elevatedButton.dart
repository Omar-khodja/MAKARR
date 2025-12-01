import 'package:flutter/material.dart';

class CustomElevatedbutton extends StatelessWidget {
  const CustomElevatedbutton({
    super.key,
    required this.label,
    required this.fun,
    this.leadIcon,
    this.tailIcon,
    this.isLoading = false,
  });
  final String label;
  final VoidCallback fun;
  final IconData? leadIcon;
  final IconData? tailIcon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: fun,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),

      child: Row(
        mainAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          if (leadIcon != null)
            Icon(
              leadIcon,
              size: 24,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 5),
          if (tailIcon != null)
            Icon(
              tailIcon,
              size: 24,
              color: Theme.of(context).colorScheme.onSurface,
            ),
        ],
      ),
    );
  }
}
