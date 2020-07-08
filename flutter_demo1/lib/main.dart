import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart'; 
import 'package:flutter/cupertino.dart';

void main() => runApp(new MyApp());   

class MyApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(

      title: 'FlutterDemo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "new_page_1":(context) => NewRoute(),
        "/":(context) => MyHomePage(title: 'Flutter Demo Home'),  // 注册路由
        "new_page_2":(context) => EchoRoute(),
        "tipsRoute":(context) {
          return TipRoute(text: ModalRoute.of(context).settings.arguments);
        },
        'TapBoxARoute':(context) => TapBoxA(),
        'ParentBox':(context) => ParentBox(),
        'ParenBoxC':(context) => ParentWidgetC(),
      },
      //在打开命名路由时可能会被调用，之所以说可能，是因为当调用Navigator.pushNamed(...)打开命名路由时，如果指定的路由名在路由表中已注册，则会调用路由表中的builder函数来生成路由组件；如果路由表中没有注册，才会调用onGenerateRoute来生成路由
      onGenerateRoute:(RouteSettings settings){
      return MaterialPageRoute(builder: (context){
           String routeName = settings.name;
           print('name------ is $routeName');
           print('The type of a is ${routeName.runtimeType}');

       // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
       // 引导用户登录；其它情况则正常打开路由。
     }
   );
  }
      // home: new MyHomePage(title: 'KINGSDEMO'),
    );
  }
}
 
class  MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override 
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _count = 0;
  
  void _incrementCount() {
    setState(() {
      _count ++;
      print('The type of _count is ${_count.runtimeType}'); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times'
            ),
            new Text(
              '$_count',
              style: Theme.of(context).textTheme.headline,
            ),
            FlatButton( 
            child: Text('open New Route'),
            color: Colors.blue,
            onPressed:(){
              Navigator.pushNamed(context, "ParenBoxC"); // 通过注册路由表跳转
              // Navigator.of(context).pushNamed("new_page_2",arguments:"hiKing");
              // Navigator.of(context).pushNamed("tipsRoute",arguments: "HiKing");
              // 导航到新的页面 普通跳转
              // Navigator.push(context,
              //  MaterialPageRoute(builder: (context){
                // return NewRoute();
                // return RouteTextRoute();
              // }));
            },
          ),
          RandomWordsWidget(),
          ],
        )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCount,            
        // onPressed: debugDumpApp, 
        tooltip: 'Increment',
        child:  new Icon(Icons.add),
      ),
    );
  }
}

  class NewRoute extends StatelessWidget { 
    @override 
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("New Route")
        ),
        body: Center(
          child: Text('This is new route'),
        ),
      );
    } 
  }

  class TipRoute extends StatelessWidget {
    TipRoute({
      Key  key, 
      @required this.text,
    }) : super(key: key);   
 
    final String text;
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('提示'),
        ),
        body: Padding(
          padding: EdgeInsets.all(18),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(text),
                RaisedButton(
                  onPressed: ()=>Navigator.pop(context, "我是返回值"), 
                  child: Text('返回'), 
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  class RouteTextRoute extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Center(
        child: Container(
          color: Colors.blue,
          child: Center(
            child: RaisedButton(onPressed: () async {
             // 打开`TipRoute`，并等待返回结果
              var result = await Navigator.push(
                context, 
                MaterialPageRoute(builder: (context){
                  return TipRoute(
                    text: '我是提示xxxxxx',
                  );
                  },
                ),
              );
              // 输出TipRoute 路由返回结果
             print('路由返回结果：$result');
             },
            child: Text('打开提示页面'),
            ),
          ),
        ),
      );
    }
  }

class EchoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context).settings.arguments;
  }
}

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 生成随机字符串
    final wordPair = new WordPair.random();  
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(wordPair.toString()),
    );
  }
}

class CupertinoTestRoutes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold (
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino Demp'),
      ),
      
      child: Center(
        child: CupertinoButton(
          color: Colors.blue,
          child: Text("Press"),
          onPressed: (){}
          ),
      ),
    );
  }
}

class TapBoxA extends StatefulWidget {

  TapBoxA({Key key}) : super (key : key);

  @override
  _TapBoxAState createState() => _TapBoxAState();
}

class _TapBoxAState extends State<TapBoxA> {
  bool _active = false;

  void _handleTap () {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active? 'Active' : 'Inactive',
            style: new TextStyle(
              fontSize: 32.0,
              color: Colors.white
            ),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color:_active ? Colors.lightGreen[700] : Colors.lightGreen[600],
        ),
      ),
    );
  }
}

class ParentBox extends StatefulWidget {
  @override
  _ParentBoxState createState() => _ParentBoxState();
}

class _ParentBoxState extends State<ParentBox> {

  bool _active = false;
  void _HandleTapBoxChanged(bool newValue) { 
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new TapBoxB(
        active : _active,
        onChanged: _HandleTapBoxChanged,
      ),
    );
  }
}

class TapBoxB extends StatelessWidget {

  TapBoxB({Key key,this.active : false, 
    @required this.onChanged })
  : super(key : key);
  
  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? 'active' : '未选中',
            style: new TextStyle(
              fontSize: 32.0,
              color: Colors.white 
            ),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.lightGreen[600],
        ),
      ),
    );
  }
}

class ParentWidgetC extends StatefulWidget {
  @override
  _ParentWidgetCState createState() => _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC> {

  bool _active = false;
  void _handTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: new TapBoxC(
        active: _active,
        onChanged: _handTapBoxChanged,
      ),
    );
  }
}

class TapBoxC extends StatefulWidget {

  TapBoxC({Key key, this.active : false ,@required this.onChanged}) : super (key : key);

  final bool active;
  final ValueChanged<bool> onChanged;
  @override
  _TapBoxCState createState() => _TapBoxCState();
}

class _TapBoxCState extends State<TapBoxC> {

  bool _highlight = false;
  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  void _handleTapText() {
    widget.onChanged(!widget.active);
  }

  Widget build(BuildContext context) {
    return new GestureDetector (
      // 按下按钮绿色添加边框， 抬起时取消高亮
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap, 
      onTapCancel: _handleTapCancel,
      child: new Container(
      
        child: new Center(
          // child: 
          //   new Text(widget.active ? 'active' : 'Inactive',
          //     style: new TextStyle(fontSize: 32.0, color:Colors.white)
          //   ),
          // child: new  Text("hello world" * 6,
          //   maxLines: 3,
          //   textScaleFactor:2, 
          //   textAlign:  TextAlign.left,
          //   style: TextStyle(
          //     color: Colors.blue,
          //     fontSize: 18.0,
          //     // background:new Paint()..color= Colors.yellow,
          //     decoration: TextDecoration.underline,
          //     decorationStyle: TextDecorationStyle.wavy,
          //   ),
          //   ),

          // child: new Text.rich( TextSpan (
          //   children: [
          //     TextSpan (
          //      text: "home: ",
          //      style: TextStyle(
          //        color: Colors.blue,
          //       fontSize: 18,

          //      ),
          //     ),
          //     TextSpan (text: "https://flutterchina.club",
          //       style: TextStyle(
          //         color: Colors.blue,
          //         fontSize: 18,
          //       ),
          //       recognizer: null
          //     ),
          //   ]
          // )),

          // ),
          // width: 400.0,
          // height: 200.0,
          // decoration: new BoxDecoration(
          //   color:widget.active ? Colors.lightGreen[700] : Colors.lightGreen[600],
          //   border: _highlight ? new Border.all(
          //     color: Colors.teal[700],
          //     width: 10.0,
          //   ) : null,

            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[
            //     Text("hello"),
            //     Text("I am jack"),
            //     Text("Da King",
            //     style: TextStyle(
            //       color: Colors.grey
            //     ),
            //     ),
            //   ],
            // ) ,
          
          // child: FlatButton (
          //   color: Colors.white,
          //   child: Text("Normal"),
          //   onPressed: (){},
          // ),

          child: IconButton(
            icon: Icon(Icons.add),
             onPressed: () {},
             padding: EdgeInsets.all(8.0),
          ),


          ),
        ),
      );
  }
}