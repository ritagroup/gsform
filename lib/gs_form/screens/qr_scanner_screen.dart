import 'package:flutter/material.dart';
import 'package:gsform/gs_form/core/form_style.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerScreen extends StatelessWidget {
  QrScannerScreen({required this.callback, Key? key}) : super(key: key);

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final ValueSetter<Barcode> callback;

  @override
  Widget build(BuildContext context) {
    var scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 300.0 : 450.0;
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
      body: QRView(
        key: qrKey,
        onQRViewCreated: (con) {
          _onQRViewCreated(context, con);
        },
        overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea,
        ),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
    );
  }

  void _onQRViewCreated(BuildContext context, QRViewController controller) {
    controller.resumeCamera();
    controller.scannedDataStream.listen(
      (scanData) {
        callback.call(scanData);
        Navigator.pop(context);
      },
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
