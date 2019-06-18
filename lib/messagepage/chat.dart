import 'package:flutter/material.dart';
import 'message_data.dart';

class ChatPage extends StatefulWidget {
  @override
  createState() => new ChatPagestate();
}

const String _name = "倾国倾城的墨菲菲";

class ChatPagestate extends State<ChatPage>
    with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();

  final MessageFrom messagefrom=MessageFrom.MY;

  @override
  void dispose(){
    for(ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }


  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  Widget _buildTextComposer() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              // onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(hintText: "在这里输入..."),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(
                      _textController.text,
                    )),
          )
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("返回"),
        ),
        body: Column(children: <Widget>[
          Flexible(
              child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            reverse: true,
            itemCount: _messages.length,
            itemBuilder: (_, int index) => _messages[index],
          )),
          Divider(
            height: 1.0,
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          )
        ]));
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});
  final AnimationController animationController;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOutExpo),
        axisAlignment: 0.0,
        child: Container(
            padding: EdgeInsets.only(right: 10.0),
            margin: const EdgeInsets.symmetric(vertical: 15.0), //消息框间距
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(_name + " ",
                            style: TextStyle(
                              fontSize: 11,
                            )),
                        Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Colors.indigoAccent,
                                borderRadius: BorderRadius.circular(7)),
                            margin: const EdgeInsets.only(top: 5.0, right: 5.0),
                            child: Text(
                              text,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ))
                      ]),
                  Container(
                    margin: const EdgeInsets.only(right: 0.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('lib/image/girl.jpg'),

                    ),
                  ),
                ])));
  }
}
