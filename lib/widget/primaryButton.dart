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
    return GestureDetector(
      onTap: widget.isLoading?null: widget.fun,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeOut,
        alignment: .center,
        child: TextButton(
          onPressed: null,
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),

          child: widget.isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                )
              : Row(
                  mainAxisAlignment: .center,
                  children: [
                    if (widget.leadIcon != null)
                      Icon(widget.leadIcon, size: 24, color: Colors.white),
                    const SizedBox(width: 5),
                    Text(
                      widget.label,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    const SizedBox(width: 5),
                    if (widget.tailIcon != null)
                      Icon(widget.tailIcon, size: 24, color: Colors.white),
                  ],
                ),
        ),
      ),
    );
  }
}
