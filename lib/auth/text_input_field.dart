import 'package:flutter/material.dart';
import 'package:todo_demo/my_theme/app_colors.dart';

class TextInputField extends StatefulWidget {
  final String label;
  final String? Function(String?) valid;
  final TextInputType keyboard;
  final TextEditingController controller;
  final bool ScureText;

  TextInputField({
    required this.label,
    required this.valid,
    this.keyboard = TextInputType.text,
    required this.controller,
    this.ScureText = false,
  });

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.ScureText;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: widget.label,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: width * 0.009,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.red,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.red,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          suffixIcon: widget.ScureText
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
        ),
        validator: widget.valid,
        keyboardType: widget.keyboard,
        controller: widget.controller,
        obscureText: _obscureText,
      ),
    );
  }
}
