import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final ValueSetter<BarcodeCapture> callback;
  QrScannerScreen({required this.callback, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('QR scanner', style: GSFormStyle().titleTextStyle),
        leading: SizedBox(
          width: 20,
          height: 20,
          child: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: MobileScanner(
        key: qrKey,
        onDetect: (barcode) {
          callback.call(barcode);
          Navigator.pop(context);
        },
      ),
    );
  }
}

// followed: https://github.com/juliansteenbakker/mobile_scanner/blob/master/example/lib/mobile_scanner_overlay.dart
class ScannerOverlay extends StatelessWidget {
  final Rect scanWindow;
  final double borderRadius;

  const ScannerOverlay({
    required this.scanWindow,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ScannerOverlayPainter(
          scanWindow: scanWindow, borderRadius: borderRadius),
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  final Rect scanWindow;
  final double borderRadius;

  _ScannerOverlayPainter({
    required this.scanWindow,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Offset.zero & size);

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(_ScannerOverlayPainter oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}
