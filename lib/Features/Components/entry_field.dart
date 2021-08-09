import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String? hint;
  final Widget? prefixIcon;
  final Color? color;
  final TextEditingController? controller;
  final String? initialValue;
  final bool? readOnly;
  final TextAlign? textAlign;
  final IconData? suffixIcon;
  final TextInputType? textInputType;
  final String? label;
  final int? maxLines;
  final bool? isDense;
  final bool? isHidden;
  final VoidCallback? onTap;
  final Function(String? text)? onSaved;
  final String? Function(String? text)? onValidate;
  final FocusNode?focusNode;
  final FocusNode?OwnFocusNode;
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
    this.isDense,
    this.onTap,
    this.isHidden,
    this.onSaved,
    this.onValidate,
    this.focusNode,
    this.OwnFocusNode
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        label != null
            ? Text(
          '\n' + label! + '\n',
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
        )
            : SizedBox.shrink(),
        TextFormField(
          onTap: onTap,
          focusNode: this.OwnFocusNode,
          onFieldSubmitted: (value){
            FocusScope.of(context).requestFocus(this.focusNode);
          },
          controller: controller,
          initialValue: initialValue,
          readOnly: readOnly ?? false,
          maxLines: maxLines ?? 1,
          obscureText: isHidden ?? false,
          textAlign: textAlign ?? TextAlign.start,
          keyboardType: textInputType,
          decoration: InputDecoration(
            isDense: isDense ?? false,
            prefixIcon: prefixIcon != null
                ?
              prefixIcon
                : null,
            suffixIcon: Icon(suffixIcon),
            hintText: hint,
            filled: true,
            fillColor: color ?? Theme.of(context).primaryColorLight,
            errorStyle: TextStyle(fontWeight: FontWeight.bold),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            errorBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.red)
            ),
            focusedErrorBorder: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.red)
            ),
          ),
          onSaved: onSaved,
          validator: onValidate,
        ),
      ],
    );
  }
}