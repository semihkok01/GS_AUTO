// Flutter imports:
import 'package:flutter/material.dart';

class M3FilledButton extends StatelessWidget {
  const M3FilledButton(
      {Key? key, required this.text, required this.onPressed, this.icon})
      : super(key: key);

  final String text;
  final void Function()? onPressed;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding:
            WidgetStateProperty.all(EdgeInsets.only(left: 24, right: 24)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            //side: BorderSide(
            //    color: AppColors.lightOutline)
          ),
        ),
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.primary.withOpacity(0.11)),
        foregroundColor:
            WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: icon,
            ),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
