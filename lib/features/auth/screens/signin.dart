import 'dart:ui';

import 'package:ecommerce/core/them_light/App_color_light.dart';
import 'package:ecommerce/features/auth/screens/signhup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecommerce/features/auth/screens/ForgetPassword.dart';

import 'package:ecommerce/features/auth/widgets/Gradbutton.dart';
import '../widgets/curveanimation.dart';
import '../screens/ForgetPassword.dart';
import '../widgets/InfoField.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
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
              Curveanimation(curveValue: curveValue, text: "Sign In"),
              FormLogin(keform: keyform),
              Container(
                width: w * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
              ),
              Text("Or log in with", style: TextStyle(fontSize: w * 0.035)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: w * 0.1,
                children: [
                  PicButton(
                    image: Image.asset(
                      "assets/images/icons8-apple-48.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  PicButton(
                    image: Image.asset(
                      "assets/images/icons8-google-48 (1).png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  PicButton(
                    image: Image.asset(
                      "assets/images/icons8-facebook-50.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: w * 0.035),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Signup.routeName);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: w * 0.035),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PicButton extends StatelessWidget {
  final Image image;
  const PicButton({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {},
      child: Container(
        width: w * 0.1,
        height: w * 0.1,
        child: image,
        decoration: BoxDecoration(
          color: AppColorsLight.background,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          border: Border.all(color: Colors.grey),
          boxShadow: [
            BoxShadow(
              color: AppColorsLight.textPrimary.withAlpha(100),
              offset: Offset(0, 5),
            ),
          ],
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
            labtex: "User Name",
            icon: Icons.person,
            Cont: widget.username,
            validator: (value) {
              if (value!.isEmpty) {
                return "you can't leave this field empty";
              }
            },
          ),
          password(pass: widget.pass),
          Row(
            children: [
              checkbox(),
              Text("Remember me", style: TextStyle(fontSize: w * 0.035)),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ForgetPassword.routeName);
                },
                child: Text(
                  "Forgot password?",
                  style: TextStyle(fontSize: w * 0.035),
                ),
              ),
            ],
          ),
          gradientbutton(w: w, h: h, keyform: widget.keform, text: "Sign In"),
        ],
      ),
    );
  }
}

class password extends StatefulWidget {
  final TextEditingController pass;

  const password({super.key, required this.pass});

  @override
  State<password> createState() => _passwordState();
}

class _passwordState extends State<password> {
  IconData? icon = Icons.visibility_off;
  bool ishidden = true;
  late FocusNode focusNode;
  Color Coloricon = Colors.black;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    focusNode.addListener(() {
      setState(() {
        Coloricon = focusNode.hasFocus
            ? AppColorsLight.accent
            : AppColorsLight.textPrimary;
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "you can't leave this field empy";
        } else if (value.length < 8) {
          return "password must be at least 8 characters";
        }
      },
      controller: widget.pass,
      focusNode: focusNode,
      obscureText: ishidden,
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: Icon(
          Icons.lock,
          color: Coloricon,
          size: MediaQuery.of(context).size.width * 0.05,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              if (ishidden) {
                ishidden = false;
                icon = Icons.visibility;
              } else {
                ishidden = true;
                icon = Icons.visibility_off;
              }
            });
          },
          icon: Icon(
            icon,
            color: Coloricon,
            size: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
      ),
    );
  }
}
