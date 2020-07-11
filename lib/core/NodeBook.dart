import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

class NodeBook extends NodeWithSize {

  final Map background;
  final Size size;
  final bool isPDFRender;
  NodeBook(this.background, this.size, this.isPDFRender) : super(size) {
    
    // Start by adding a background.
    _background = new GradientNode(
      this.size,
      background,
      this.isPDFRender
    );
    addChild(_background);
  }

  GradientNode _background;
}

class GradientNode extends NodeWithSize {
  GradientNode(Size size, this.background, this.isPDFRender) : super(size);

  final Map background;
  final bool isPDFRender;
 
  @override
  void paint(Canvas canvas) {
    applyTransformForPivot(canvas);
    if (this.isPDFRender) {
      Rect rect = Offset.zero & size;
      Paint gradientPaint = new Paint()..shader = new LinearGradient(
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[Color(0x00000000), Color(0x00000000)],
        stops: <double>[0.0, 1.0]
      ).createShader(rect);

      canvas.drawRect(rect, gradientPaint);
      return;
    }
    var img = background['image'] ?? '';
    var color = background['color'];
    if (img != '') {
      paintImage(canvas: canvas, rect: Offset.zero & size, image: img, fit: BoxFit.fill);
    } else {
      Rect rect = Offset.zero & size;
      Paint gradientPaint = new Paint()..shader = new LinearGradient(
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[Color(color), Color(color)],
        stops: <double>[0.0, 1.0]
      ).createShader(rect);

      canvas.drawRect(rect, gradientPaint);
    }
  }
}