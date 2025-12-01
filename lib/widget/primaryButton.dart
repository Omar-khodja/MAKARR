import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
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
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.fun,
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),

      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: widget.isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                )
              : Row(
                  mainAxisAlignment: .center,
                  children: [
                    if (widget.leadIcon != null)
                      Icon(
                        widget.leadIcon,
                        size: 24,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    const SizedBox(width: 5),
                    Text(
                      widget.label,
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (widget.tailIcon != null)
                      Icon(
                        widget.tailIcon,
                        size: 24,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
