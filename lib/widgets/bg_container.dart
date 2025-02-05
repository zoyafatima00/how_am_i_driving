import 'package:flutter/cupertino.dart';

class BGContainer extends StatelessWidget {
  const BGContainer({super.key, required this.child, this.h});
  final Widget child;
  final double? h;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: h ?? height,
      width: width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(1.00, -0.00),
          end: Alignment(-1, 0),
          colors: [
            Color(0xFF488A99),
            Color(0xFF488A99),
          ],
        ),
      ),
      child: child,
    );
  }
}
