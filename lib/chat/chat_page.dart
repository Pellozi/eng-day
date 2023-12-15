import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

enum ChatDataItemType {
  chat,
  interactive
}

class ChatDataItem {
  final ChatDataItemType type;
  final String content;

  ChatDataItem({required this.type, required this.content});
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controllerMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('images/polvo.jpeg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              width: 16,
            ),
            const Text(
              'Polvo',
              style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 8,
            ),
            Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              child: Image.asset('images/robot.png'),
            ),
          ],
        ),
      ),
    );
  }

  List<ChatDataItem> chatData = [];

  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 1), borderRadius: BorderRadius.circular(15)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('images/chat.png'),
                const SizedBox(
                  width: 16,
                ),
                const Text(
                  'Pergunte algo! Eu posso gerar\nrelatórios, posts e até te ensinar\na usar uma funcionalidade\nespecífica.',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Expanded(
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: chatData.length,
            itemBuilder: (context, index) {
              var item = chatData[index];
              if(item.type == ChatDataItemType.chat){

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: chatItem(item.content),
              );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  height: 232,
                    padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(26),
                ),
                child: ChatItemInteractive(),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1), borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _controllerMessage,
                          scrollPadding: EdgeInsets.zero,
                          onChanged: (value) {},
                          autofocus: false,
                          onSaved: (value) {
                            sendChat();
                          },
                          decoration: const InputDecoration(
                            filled: false,
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            hintText: 'Digite sua mensagem',
                            errorStyle: TextStyle(height: 0),
                          ),
                          style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                      ),
                      GestureDetector(
                        onTap: sendChat,
                        child: const Icon(
                          Icons.send,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        )
      ],
    );
  }

  void sendChat(){
    setState(() {
      bool isNotEmpty = _controllerMessage.text.isNotEmpty;
      chatData.add(ChatDataItem(type: isNotEmpty ? ChatDataItemType.chat : ChatDataItemType.interactive, content: _controllerMessage.text));
    });
  }


  Widget chatItem(String message) {
    return GestureDetector(
        onTap: () async {},
        child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),
            )));
  }
}

class ChatItemInteractive extends StatefulWidget {
  const ChatItemInteractive({super.key});

  @override
  State<ChatItemInteractive> createState() => _ChatItemInteractiveState();
}

class _ChatItemInteractiveState extends State<ChatItemInteractive> {
  final Runtime _runtime = Runtime();
  final DynamicContent _data = DynamicContent();

  static const LibraryName coreName = LibraryName(<String>['core', 'widgets']);

  static final RemoteWidgetLibrary _remoteWidgets = parseLibraryFile('''
     import local;
      widget root = ListWidget(
  children: [
    CardUser(
      title: "Lara",
      subtitle: "Perda de Peso: 6 kg",
      trailing: "12%",
      imgUrl: "{url_lara}",
    ),
    CardUser(
      title: "Carlos",
      subtitle: "Perda de Peso: 4 kg",
      trailing: "5%",
      imgUrl: "{url_carlos}",
    ),
    CardUser(
      title: "Camila",
      subtitle: "Perda de Peso: 5 kg",
      trailing: "7%",
      imgUrl: "{url_camila}",
    ),
  ],
);
  ''');
  static const LibraryName mainName = LibraryName(<String>['main']);
  final String urlImage = 'https://professordoiphone.com.br/wp-content/uploads/2019/07/file_0-41.jpg';

  static WidgetLibrary _createLocalWidgets() {
    return LocalWidgetLibrary(<String, LocalWidgetBuilder>{
      'ListWidget': (BuildContext context, DataSource source) {
        return ListView(
          children: source.childList(["children"]),
        );
      },
      'TextWidget': (BuildContext context, DataSource source) {
        return Center(
          child: Text(
            'Hello, ${source.v<String>(<Object>["name"])}!',
            textDirection: TextDirection.ltr,
          ),
        );
      },
      'CardUser': (BuildContext context, DataSource source) {
        var title = source.v<String>(<Object>["title"]);
        var subtitle = source.v<String>(<Object>["subtitle"]);
        var trailing = source.v<String>(<Object>["trailing"]);
        var url = source.v<String>(<Object>["imgUrl"]);

        return Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: url != null ? NetworkImage(url) : null,
              ),
              title: Text(title!),
              subtitle: Text(subtitle!),
              trailing: Text(trailing!),
            ),
          ),
        );
      },
    });
  }
  static const LibraryName localName = LibraryName(<String>['local']);
  @override
  void initState() {
    super.initState();
    // Local widget library:
    _runtime.update(localName, _createLocalWidgets());
    // Remote widget library:
    _runtime.update(mainName, _remoteWidgets);
    // Configuration data:
    _data.update('greet', <String, Object>{'name': 'World'});
  }

  @override
  Widget build(BuildContext context) {
    return

      RemoteWidget(
        runtime: _runtime,
        data: _data,
        widget: const FullyQualifiedWidgetName(mainName, 'root'),
        onEvent: (String name, DynamicMap arguments) {
          // The example above does not have any way to trigger events, but if it
          // did, they would result in this callback being invoked.
          debugPrint('user triggered event "$name" with data: $arguments');
        },
      );
  }
}