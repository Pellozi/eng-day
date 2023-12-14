import 'package:flutter/material.dart';

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

  Widget body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
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
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return chatItem('message');
            },
          ),
          Container(
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
                          onSaved: (value) {},
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
                      const Icon(
                        Icons.send,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
              style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),
            )));
  }
}
