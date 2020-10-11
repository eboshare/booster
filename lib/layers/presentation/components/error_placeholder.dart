import 'package:flutter/material.dart';

class ErrorPlaceholder extends StatelessWidget {
  final String message;

  const ErrorPlaceholder({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.warning,
          size: 50,
          color: Theme.of(context).accentColor,
        ),
        const SizedBox(height: 25),
        Text(
          message,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
