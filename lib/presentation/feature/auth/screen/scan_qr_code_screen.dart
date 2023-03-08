import 'package:flutter/material.dart';

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
                      onPressed: () {},
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
