import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scanning_effect/scanning_effect.dart';

class QRScreen extends StatefulWidget {
  static const routeName = '/QRScan';

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? results;
  QRViewController? qrcontroller;

  bool qrScanner = false;
  bool qrScanCode = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/club7_logo.png',
              height: size.height * 0.1,
              width: size.width * 0.9,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Scan QR Code',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              //height: size.height * 0.75,
              width: size.width * 0.9,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(width: 2, color: Colors.black),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 50,
                        color: Colors.red,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      if (qrScanner)
                        Column(
                          children: [
                            Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                border: Border.all(width: 2, color: Colors.red),
                              ),
                              child: ScanningEffect(
                                scanningColor: Colors.red,
                                borderLineColor: Colors.red,
                                child: QRView(
                                  key: qrKey,
                                  onQRViewCreated: _onQRViewCreated,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      if (qrScanner == false)
                        Container(
                          height: 250,
                          width: 250,
                          child: Icon(
                            Icons.qr_code_scanner_sharp,
                            size: 230,
                          ),
                        ),
                      // SizedBox(
                      //   height: 90,
                      // ), 
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.red),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.white),
                          onPressed: () {
                            setState(() {
                              qrScanner = !qrScanner;
                              qrScanCode = !qrScanCode;
                            });
                          },
                          child: Text(
                            qrScanner ? 'Done' : 'Scan QR Code',
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          ),
                        ),
                      ),
                      if (qrScanCode)
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: Colors.red),
                          ),
                          child: Center(
                            child: qrScanner
                                ? Expanded(
                                    child: Text(
                                      'Code : ${(results != null) ? results!.code.toString() : ""}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Builder(
                                    builder: (context) {
                                      results =
                                          null; // Reset the value of results
                                      return Text(
                                        'SCAN TO VERIFY',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.qrcontroller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        results = scanData;
      });
    });
  }

  @override
  void dispose() {
    qrcontroller?.dispose();
    super.dispose();
  }
}
