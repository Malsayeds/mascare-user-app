import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String? hint;
  final IconData? prefixIcon;
  final Color? color;
  final TextEditingController? controller;
  final String? initialValue;
  final bool? readOnly;
  final TextAlign? textAlign;
  final IconData? suffixIcon;
  final TextInputType? textInputType;
  final String? label;
  final int? maxLines;
  final Function? onTap;
  final IconData? suffix;

  EntryField({
    this.hint,
    this.prefixIcon,
    this.color,
    this.controller,
    this.initialValue,
    this.readOnly,
    this.textAlign,
    this.suffixIcon,
    this.textInputType,
    this.label,
    this.maxLines,
    this.onTap,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        label != null
            ? Text('\n' + label! + '\n',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Theme.of(context).disabledColor))
            : SizedBox.shrink(),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                initialValue: initialValue,
                readOnly: readOnly ?? false,
                maxLines: maxLines ?? 1,
                textAlign: textAlign ?? TextAlign.left,
                keyboardType: textInputType,
                decoration: InputDecoration(
                  prefixIcon:
                      Icon(prefixIcon, color: Theme.of(context).primaryColor),
                  suffixIcon: Icon(suffixIcon),
                  hintText: hint,
                  filled: true,
                  fillColor: color ?? Theme.of(context).backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                ),
                onTap: onTap as void Function()?,
              ),
            ),
            if (suffix != null)
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: 8),
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    suffix,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}
