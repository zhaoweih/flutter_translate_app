import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:translate_flutter_app/translate/translate.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';

class TranslatePage extends StatefulWidget {

  @override
  TranslatePageState createState() => new TranslatePageState();
}

class TranslatePageState extends State<TranslatePage> {
  Translate translate;
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var content;
    if (translate == null) {
      var input = setInput();
      content = new Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
        child: new Scrollbar(
          child: new Column(
            children: <Widget>[
              input

            ],
          ),
        ),

      );
    } else {
      content = setData(translate);
      new Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
        child: new Scrollbar(
          child: content,

        ),
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("翻译君"),
      ),
      body: content,


    );
  }

  @override
  void initState() {
    super.initState();
  }

  getTranslateData(String word) async {
    String response = await createHttpClient().read(
        'http://fanyi.youdao.com/openapi.do?keyfrom=zhaotranslator&key=1681711370&type=data&doctype=json&version=1.1&q=' +
            word);

    setState(() {
      translate = Translate.allFromResponse(response);
    });
  }

  setInput() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new TextField(
          controller: _controller,
          decoration: new InputDecoration(
            hintText: '输入你要翻译的内容吧',
          ),
        ),
        new Container(
          padding: const EdgeInsets.only(top: 5.0),
        ),
        new RaisedButton(
          onPressed: () {
            getTranslateData(_controller.text);
          },
            color: Colors.blue,
          child: new Text('翻译',
          style: new TextStyle(
            color: Colors.white
          ),
          ),

        ),
      ],
    );
  }

  setData(Translate translate) {
    var input = setInput();
    var movieMsg = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Divider(),
        new Text(
          '翻译结果：' + translate.translation,
          textAlign: TextAlign.left,
          style: new TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18.0
          ),
        ),
        new Divider(),
        new Text('普通发音：' + translate.phonetic),
        new Text('美式发音：' + translate.us),
        new Text('英式发音：' + translate.uk),
        new Divider(),
        new Text(
          '翻译解析：' + translate.explains,
          style: new TextStyle(
            fontSize: 14.0,
            color: Colors.redAccent,),
        ),
        new Divider(),
        new Text('网络翻译：' + translate.webs),
        new Divider(),
      ],
    );


    return new Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
        bottom: 10.0,
      ),
      child: new Scrollbar(
        child: new Column(
          children: <Widget>[
            input,
            movieMsg,

          ],
        ),
      ),
    );
  }
}