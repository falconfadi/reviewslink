import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:reviews_link_v2/constant/constant.dart';
import 'package:reviews_link_v2/pages/main_page/controller.dart';
import 'package:reviews_link_v2/res/app_theme.dart';
import 'package:reviews_link_v2/res/color.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/widgets/header/internal_header.dart';
import 'package:reviews_link_v2/widgets/loading/custom_loading.dart';

class QRViewPage extends StatefulWidget {

  const QRViewPage({super.key});

  @override
  State<StatefulWidget> createState() => _QRViewPageState();
}

class _QRViewPageState extends State<QRViewPage> with WidgetsBindingObserver {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final MainPageController mainPageController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller == null) return;
    if (state == AppLifecycleState.paused) {
      controller!.pauseCamera();
    } else if (state == AppLifecycleState.resumed) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (mainPageController.loading.value) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: InternalHeader(),
        body: Stack(
          children: [
            Column(
              children: <Widget>[
                Expanded(flex: 3, child: _buildQrView(context)),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      if (result != null)
                        Text(
                          'Barcode Type: ${result!.format.name} \n Data: ${result!.code}',
                          textAlign: TextAlign.center,
                          style: AppTheme.bodyLarge.copyWith(fontSize: 18.sp),
                        )
                      else Text(
                          'Scan a code',
                          style: AppTheme.bodyLarge.copyWith(fontSize: 18.sp)
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(8),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () async {
                                await controller?.toggleFlash();
                                setState(() {});
                              },
                              child: FutureBuilder(
                                future: controller?.getFlashStatus(),
                                builder: (context, snapshot) {
                                  return Padding(
                                    padding: Constant.isTablet(context) ?
                                    EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h) : EdgeInsets.zero,
                                    child: Text(
                                      'Flash: ${(snapshot.data == true) ? 'On' : 'Off'}',
                                      style: AppTheme.bodyLarge.copyWith(color: white),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.h),
                    ],
                  ),
                ),
              ],
            ),
            if (mainPageController.loading.value)
              Container(
                width: 1.sw,
                height: 1.sh,
                color: primaryColor.withAlpha(100),
                child: LoadingIndicator(color: white)
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: red,
        borderRadius: 10.r,
        borderLength: 35.h,
        borderWidth: 10.w,
        cutOutSize: 320.w,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    if (Platform.isIOS) {
      controller.resumeCamera();
    }
    controller.scannedDataStream.listen((scanData) async {
      await controller.pauseCamera();
      setState(() {
        result = scanData;
      });
      await mainPageController.claimCodeScan(context, scanData.code);
      if (mounted) {
        await controller.resumeCamera();
      }
    });
  }


  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('no Permission')));
    }
  }
}
