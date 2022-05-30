import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class ClippWidget extends StatelessWidget {
  const ClippWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Device.screenWidth,
      height: Device.screenHeight,
      child: Stack(
        children: [
          ClipPath(
            clipper: _AppBarClipper1(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red.shade200,
              ),
            ),
          ),
          ClipPath(
            clipper: _AppBarClipper2(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBarClipper2 extends CustomClipper<Path> {
  _AppBarClipper2();

  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(size.width * 0.2342757, size.height * 0.2760777);
    path0.cubicTo(
        size.width * 0.2798598,
        size.height * 0.3315664,
        size.width * 0.3596963,
        size.height * 0.3594987,
        size.width * 0.4235981,
        size.height * 0.3686717);
    path0.cubicTo(
        size.width * 0.5023364,
        size.height * 0.3664160,
        size.width * 0.5670327,
        size.height * 0.2978947,
        size.width * 0.6835514,
        size.height * 0.2997744);
    path0.cubicTo(
        size.width * 0.7781776,
        size.height * 0.2965539,
        size.width * 0.8007243,
        size.height * 0.3202256,
        size.width * 0.8550935,
        size.height * 0.3372055);
    path0.quadraticBezierTo(size.width * 0.9480374, size.height * 0.3382331,
        size.width, size.height * 0.2888847);
    path0.lineTo(size.width, size.height * 0.1264912);
    path0.lineTo(size.width * 0.4657477, size.height * 0.1259273);
    path0.quadraticBezierTo(size.width * 0.2212150, size.height * 0.1519674,
        size.width * 0.2342757, size.height * 0.2760777);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class _AppBarClipper1 extends CustomClipper<Path> {
  _AppBarClipper1();

  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(size.width * 0.1927103, size.height * 0.2776441);
    path0.cubicTo(
        size.width * 0.2382944,
        size.height * 0.3331328,
        size.width * 0.3181308,
        size.height * 0.3610652,
        size.width * 0.3820327,
        size.height * 0.3702381);
    path0.cubicTo(
        size.width * 0.4607710,
        size.height * 0.3679825,
        size.width * 0.5254673,
        size.height * 0.2994612,
        size.width * 0.6419860,
        size.height * 0.3013409);
    path0.cubicTo(
        size.width * 0.7366121,
        size.height * 0.2981203,
        size.width * 0.7706542,
        size.height * 0.3294110,
        size.width * 0.8135280,
        size.height * 0.3387719);
    path0.quadraticBezierTo(size.width * 0.8497664, size.height * 0.3266917,
        size.width, size.height * 0.3102632);
    path0.lineTo(size.width, size.height * 0.1269298);
    path0.lineTo(size.width * 0.4241822, size.height * 0.1274937);
    path0.quadraticBezierTo(size.width * 0.1796495, size.height * 0.1535338,
        size.width * 0.1927103, size.height * 0.2776441);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
