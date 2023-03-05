import 'package:flutter/material.dart';

class CardBaseWidget extends StatelessWidget {
  final Widget child;
  final Text title;
  final Color leadingColor;
  const CardBaseWidget({
    super.key,
    required this.child,
    required this.title,
    required this.leadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: Row(
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: leadingColor),
                            height: 32,
                            width: 16,
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          title,
                        ],
                      ),
                    )
                  ],
                ),
              ),
              child,
            ],
          ),
        ));
  }
}
