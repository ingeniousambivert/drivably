import 'package:flutter/material.dart';

removeUntil(context, className) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => className),
    (route) => false,
  );
}

pushToNext(context, className) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => className),
  );
}
