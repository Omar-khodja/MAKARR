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
    final darktheme = Theme.of(context).brightness == Brightness.dark;

    return ElevatedButton(
      onPressed: fun,
      style: ElevatedButton.styleFrom(
        backgroundColor: darktheme
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.primary,
      ),

      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                )
              : Row(
                  mainAxisAlignment: .center,
                  children: [
                    if (leadIcon != null)
                      Icon(
                        leadIcon,
                        size: 24,
                        color: darktheme
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context).colorScheme.onPrimary,
                      ),
                    const SizedBox(width: 5),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 24,
                        color: darktheme
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (tailIcon != null)
                      Icon(
                        tailIcon,
                        size: 24,
                        color: darktheme
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context).colorScheme.onPrimary,
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
