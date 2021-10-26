import 'package:dentistry_app/resources/images_res.dart';
import 'package:flutter/material.dart';

class MessageNotification extends StatelessWidget {
  final VoidCallback onReplay;
  final String message;

  const MessageNotification({Key? key, required this.onReplay, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
      child: ListTile(
        leading: SizedBox.fromSize(
            size: const Size(40, 40),
            child: ClipOval(child: Image.asset(ImageRes.toothbrush,))),
        title: Text('Lily MacDonald'),
        subtitle: Text('Do you want to see a movie?'),
        trailing: IconButton(
            icon: Icon(Icons.reply),
            onPressed: () {
              if (onReplay != null) onReplay();
            }),
      ),
    );
  }
}