import 'dart:ui';

import 'package:ecommerce/them_light/App_color_light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpClipper extends CustomClipper<Path> {
  final double curveFactor;

  SignUpClipper(this.curveFactor);
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * curveFactor);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * curveFactor,
      size.width * 0.6,
      size.height * 0.75,
    );

    path.quadraticBezierTo(
      size.width * curveFactor + 0.15,
      size.height * curveFactor,
      size.width,
      size.height * 0.7,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  @override
  bool shouldReclip(covariant SignUpClipper oldClipper) {
    return oldClipper.curveFactor != curveFactor;
  }
}

// class MyTween<T> {
//   T begin;
//   T end;
//   MyTween({required this.begin, required this.end});
// }

class Bmi extends StatefulWidget {
  @override
  State<Bmi> createState() => _BmiState();
}

class _BmiState extends State<Bmi> with SingleTickerProviderStateMixin {
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          spacing: h * 0.05,
          children: [
            Curveanimation(curveValue: curveValue),
            FormLogin(keform: keyform),
            Row(
              children: [
                checkbox(),
                Text("Remember me", style: TextStyle(fontSize: w * 0.035)),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(fontSize: w * 0.035),
                  ),
                ),
              ],
            ),
            gradientbutton(w: w, h: h),
          ],
        ),
      ),
    );
  }
}

class gradientbutton extends StatelessWidget {
  const gradientbutton({super.key, required this.w, required this.h});

  final double w;
  final double h;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w * 0.6,
      height: h * 0.05,
      decoration: BoxDecoration(
        gradient: AppColorsLight.primaryGradient2,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {},
          child: Center(
            child: Text(
              "Log in",
              style: TextStyle(
                color: AppColorsLight.background,
                fontWeight: FontWeight.bold,
                fontSize: w * 0.05,
              ),
            ),
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

GlobalKey<FormState> keyform = GlobalKey();

class FormLogin extends StatefulWidget {
  final GlobalKey<FormState> keform;
  const FormLogin({super.key, required this.keform});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Form(
      child: Column(
        spacing: h * 0.05,
        children: [
          infofield(labtex: "User Name", icon: Icons.person),
          password(),
        ],
      ),
    );
  }
}

class infofield extends StatefulWidget {
  final String labtex;
  final IconData icon;
  infofield({super.key, required this.labtex, required this.icon});

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
    return TextField(
      focusNode: fn,
      decoration: InputDecoration(
        labelText: widget.labtex,
        prefixIcon: Icon(widget.icon, color: iconcolor),
      ),
    );
  }
}

class password extends StatefulWidget {
  const password({super.key});

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
    return TextField(
      focusNode: focusNode,
      obscureText: ishidden,
      decoration: InputDecoration(
        label: Text("Password"),
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

class Curveanimation extends StatelessWidget {
  const Curveanimation({super.key, required this.curveValue});

  final double curveValue;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 2),
      builder: (context, value, child) {
        return ClipPath(
          clipper: SignUpClipper(value),
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.3,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff2C3E50), Color(0xff00B4DB)],
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "welcome back!",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  "Log in",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      tween: Tween<double>(begin: 0.7, end: curveValue),
      curve: Curves.easeInOutBack,
    );
  }
}
