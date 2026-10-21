import 'dart:convert';

import 'package:crypto/crypto.dart';

String hashPin(String pin) => sha256.convert(utf8.encode('kasa-pos:$pin')).toString();
