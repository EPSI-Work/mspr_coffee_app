import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mspr_coffee_app/presentation/app/bloc/auth_bloc.dart';

class ScanQrCodeScreen extends StatelessWidget {
  const ScanQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              'assets/gifs/qrcode.gif',
              width: 256,
              height: 256,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Scan the QR Code',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        'Please finish the login process by simply scanning the QR code sent to your email',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ElevatedButton(
                      onPressed: () async {
                        await FlutterBarcodeScanner.scanBarcode(
                                '#ff6666', 'Cancel', true, ScanMode.QR)
                            .then((value) {
                          context.read<AuthBloc>().add(ScanQrCode(value));
                        });
                      },
                      child: Text(
                        'Scan QR Code',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                            ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
