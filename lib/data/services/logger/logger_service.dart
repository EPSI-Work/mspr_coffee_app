import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:developer' as dev;

class LoggerService {
  late final File _logFile;

  LoggerService({String? fileName}) {
    _initLogFile(fileName ?? 'log.txt');
  }

  void _initLogFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    _logFile = File('${directory.path}/$fileName');
    if (!_logFile.existsSync()) {
      _logFile.createSync();
    }
  }

  void log(String message) {
    final now = DateTime.now();
    final formattedDate =
        "${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)}";
    final formattedTime =
        "${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}";
    final logMessage = "[$formattedDate $formattedTime] $message";
    dev.log(logMessage);

    //_logFile.writeAsStringSync('$logMessage\n', mode: FileMode.append);
  }

  String _twoDigits(int n) {
    if (n >= 10) {
      return "$n";
    } else {
      return "0$n";
    }
  }
}
