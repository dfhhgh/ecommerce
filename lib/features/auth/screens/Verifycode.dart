import 'dart:ui';

import 'package:ecommerce/features/auth/screens/Verifycode.dart';
import 'package:ecommerce/core/them_light/App_color_light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/curveanimation.dart';
import '../widgets/Gradbutton.dart';
import '../widgets/InfoField.dart';

class Verifycode extends StatefulWidget {
  static const String routeName = "Verfycode";
  @override
  State<Verifycode> createState() => _VerifycodeState();
}

class _VerifycodeState extends State<Verifycode>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> keyform = GlobalKey();
  double curveValue = 1.0;
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOutBack));
    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            spacing: h * 0.02,
            children: [
              Curveanimation(curveValue: curveValue, text: "Verify Code"),
              FormLogin(keform: keyform),
            ],
          ),
        ),
      ),
    );
  }
}

class checkbox extends StatefulWidget {
  const checkbox({super.key});

  @override
  State<checkbox> createState() => _checkboxState();
}

class _checkboxState extends State<checkbox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (val) {
        setState(() {
          isChecked = val!;
        });
      },
    );
  }
}

class FormLogin extends StatefulWidget {
  final GlobalKey<FormState> keform;
  TextEditingController username = TextEditingController();
  TextEditingController pass = TextEditingController();
  FormLogin({super.key, required this.keform});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  @override
  void dispose() {
    widget.username.dispose();
    widget.pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Form(
      key: widget.keform,
      child: Column(
        spacing: h * 0.05,
        children: [
          infofield(
            labtex: "Code",
            icon: Icons.domain_verification_rounded,
            Cont: widget.username,
            validator: (value) {
              if (value!.isEmpty) {
                return "you can't leave this field empty";
              }
            },
          ),

          gradientbutton(
            w: w,
            h: h,
            keyform: widget.keform,
            text: "Verifycode",
          ),
        ],
      ),
    );
  }
}
