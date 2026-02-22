import 'package:ecommerce/core/them_light/App_color_light.dart';
import 'package:flutter/material.dart';

class infofield extends StatefulWidget {
  final String labtex;
  final IconData icon;
  final TextEditingController Cont;
  final String? Function(String?)? validator;

  infofield({
    super.key,
    required this.labtex,
    required this.icon,
    required this.Cont,
    this.validator,
  });

  @override
  State<infofield> createState() => _infofieldState();
}

class _infofieldState extends State<infofield> {
  late FocusNode fn;
  Color iconcolor = AppColorsLight.textPrimary;

  @override
  void initState() {
    super.initState();
    fn = FocusNode();
    fn.addListener(
      () => setState(() {
        iconcolor = fn.hasFocus
            ? AppColorsLight.accent
            : AppColorsLight.textPrimary;
      }),
    );
  }

  @override
  void dispose() {
    fn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.Cont,
      focusNode: fn,
      decoration: InputDecoration(
        labelText: widget.labtex,
        prefixIcon: Icon(
          widget.icon,
          color: iconcolor,
          size: MediaQuery.of(context).size.width * 0.05,
        ),
      ),
    );
  }
}
