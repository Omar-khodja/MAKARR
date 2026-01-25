import 'package:flutter/material.dart';

class CoustomElevatedbutton extends StatefulWidget {
  const CoustomElevatedbutton({
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
  State<CoustomElevatedbutton> createState() => _CoustomElevatedbuttonState();
}

class _CoustomElevatedbuttonState extends State<CoustomElevatedbutton>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final darktheme = Theme.of(context).brightness == Brightness.dark;

    return ElevatedButton(
      onPressed: widget.fun,

      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: widget.isLoading
              ? const Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 8,
                    horizontal: 15,
                  ),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,

                    color: Colors.white,
                  ),
                )
              : Row(
                  mainAxisAlignment: .center,
                  children: [
                    if (widget.leadIcon != null)
                      Icon(
                        widget.leadIcon,
                        size: 24,
                        color: darktheme
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context).colorScheme.onPrimary,
                      ),
                    const SizedBox(width: 5),
                    Text(widget.label),
                    const SizedBox(width: 5),
                    if (widget.tailIcon != null)
                      Icon(
                        widget.tailIcon,
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
