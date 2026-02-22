import 'package:flutter/material.dart';

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
      size.width * 0.4,
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

class Curveanimation extends StatelessWidget {
  const Curveanimation({
    super.key,
    required this.curveValue,
    required this.text,
  });
  final String text;
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
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
