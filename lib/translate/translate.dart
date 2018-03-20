import 'dart:convert';

import 'package:meta/meta.dart';

class Translate {
  final String translation;
  final String explains;
  final String webs;
  final String phonetic;
  final String us;
  final String uk;


  //构造函数
  Translate({
    @required this.translation,
    @required this.explains,
    @required this.webs,
    @required this.phonetic,
    @required this.us,
    @required this.uk,

  });


  static Translate allFromResponse(String json) {
    return fromMap(JSON.decode(json));
  }

  static Translate fromMap(Map map) {
    List translations = map['translation'];
    List explains = map['basic']['explains'];
    List webs = map['web'];
    List values;
    var p = map['basic']['phonetic'];
    var us = map['basic']['us-phonetic'];
    var uk = map['basic']['uk-phonetic'];

    var t = '';
    for (int i = 0; i < translations.length; i++) {
      if (i == 0) {
        t = t + translations[i];
      } else {
        t = t + ',' + translations[i];
      }
    }
    var e = '';
    for (int i = 0; i < explains.length; i++) {
      if (i == 0) {
        e = e + explains[i];
      } else {
        e = e + ',' + explains[i];
      }
    }
    var w = '';

    for (int i = 0; i < webs.length; i++) {
      values = webs[i]['value'];
      var v = '';
      for (int y = 0; y < values.length; y++) {
        if (y == 0) {
          v = v + values[y];
        } else {
          v = v + ',' + values[y];
        }
      }

      if (i == 0) {
        w = w + webs[i]['key'] + ':' + v;
      } else {
        w = w + ' ' + webs[i]['key'] + ':' + v;
      }
    }
    return new Translate(
      translation: t,
      explains: e,
      webs: w,
      phonetic: p,
      us: us,
      uk: uk,
    );
  }
}