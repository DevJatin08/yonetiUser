import 'dart:developer';

class ErrorDisplay {
  display(Object o, String url) {
    log('Start');
    log('==== Object Error Start ====');
    log(o.toString());
    log('==== Object Error End ====');
    log('==== Error URl ====');
    log(url);
    log('end');
  }
}
