import 'package:flutter/widgets.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget child;

  SlidePageRoute({
    required this.child,
  }) : super(
            transitionDuration: Duration(milliseconds: 350),
            pageBuilder: (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(begin: Offset(-2, 0), end: Offset.zero)
            .animate(animation),
        child: child,
      );
}
