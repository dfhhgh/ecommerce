import 'dart:ui';

import 'package:ecommerce/them_light/App_color_light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'signhup.dart';

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
  bool shouldReclip(covariant SignUpClipper oldClipper) {
    return oldClipper.curveFactor != curveFactor;
  }
}

// class MyTween<T> {
//   T begin;
//   T end;
//   MyTween({required this.begin, required this.end});
// }

class Signup extends StatefulWidget {
  static const String routeName = "/signup";
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with SingleTickerProviderStateMixin {
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
              Curveanimation(curveValue: curveValue),
              FormLogin(keform: keyform),
              Container(
                width: w * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
              ),
              Text("Or via ", style: TextStyle(fontSize: w * 0.035)),
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
                    "already have email ",
                    style: TextStyle(fontSize: w * 0.035),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/",
                        (route) => false,
                      );
                    },
                    child: Text(
                      "Sign In",
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

class gradientbutton extends StatelessWidget {
  final GlobalKey<FormState> keyform;
  const gradientbutton({
    super.key,
    required this.w,
    required this.h,
    required this.keyform,
  });

  final double w;
  final double h;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w * 0.5,
      height: h * 0.06,
      decoration: BoxDecoration(
        gradient: AppColorsLight.primaryGradient2,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            keyform.currentState!.validate();
          },
          child: Center(
            child: Text(
              "Sign Up",
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

class FormLogin extends StatefulWidget {
  final GlobalKey<FormState> keform;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController Confirmpass = TextEditingController();

  FormLogin({super.key, required this.keform});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  @override
  void dispose() {
    widget.username.dispose();
    widget.pass.dispose();
    widget.email.dispose();
    widget.Confirmpass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Form(
      key: widget.keform,

      child: Column(
        spacing: h * 0.03,
        children: [
          infofield(
            labtex: "Email",
            icon: Icons.mail,
            Cont: widget.email,
            validator: (value) {
              RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (value!.isEmpty) {
                return "you can't leave this field empy";
              } else if (!value.contains("@") || emailRegex.hasMatch(value)) {
                return "please enter a valid email";
              }
            },
          ),
          infofield(
            labtex: "User Name",
            icon: Icons.person,
            Cont: widget.username,
            validator: (value) {
              if (value!.isEmpty) {
                return "you can't leave this field empy";
              }
            },
          ),
          password(
            pass: widget.pass,
            labtex: "Password",
            validator: (value) {
              if (value!.isEmpty) {
                return "you can't leave this field empy";
              } else if (value.length < 8) {
                return "password must be at least 8 characters";
              }
            },
          ),
          password(
            pass: widget.Confirmpass,
            labtex: "Confirm Password",
            validator: (value) {
              if (value!.isEmpty) {
                return "you can't leave this field empy";
              } else if (value.length < 8) {
                return "password must be at least 8 characters";
              } else if (value != widget.pass.text) {
                return "passwords do not match";
              }
            },
          ),
          Row(
            children: [
              checkbox(),
              Text("I accept the ", style: TextStyle(fontSize: w * 0.035)),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Terms and Conditions",
                  style: TextStyle(fontSize: w * 0.035),
                ),
              ),
            ],
          ),
          gradientbutton(w: w, h: h, keyform: widget.keform),
        ],
      ),
    );
  }
}

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

class password extends StatefulWidget {
  final TextEditingController pass;
  final String labtex;
  final String? Function(String?)? validator;

  const password({
    super.key,
    required this.pass,
    required this.labtex,
    this.validator,
  });

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
      validator: widget.validator,
      controller: widget.pass,
      focusNode: focusNode,
      obscureText: ishidden,
      decoration: InputDecoration(
        labelText: widget.labtex,
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
                  "welcome ",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  "Sign Up",
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
