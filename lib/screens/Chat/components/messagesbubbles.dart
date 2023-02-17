import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.username, this.image, this.isMe, {required this.key});

 final Key key;
 final String message;
 final String username;
 final bool isMe;
 final String image;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe? MainAxisAlignment.end: MainAxisAlignment.start,
      children: <Widget>[
              if(isMe)CircleAvatar(
                backgroundImage: NetworkImage(image),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
                width: 140,
                decoration: BoxDecoration(
                    color: isMe? Colors.grey[300]: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(14),
                      topRight: const Radius.circular(14),
                      bottomLeft: !isMe? const Radius.circular(0): const Radius.circular(14),
                      bottomRight: isMe? const Radius.circular(0):const Radius.circular(14)
                    )
                ),
                child: Column(
                  crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe?Colors.black:Colors.white
                    ),
                  
                    ),
                    Text(message,
                    textAlign: isMe? TextAlign.end:TextAlign.start,
                    style: TextStyle(
                      color: isMe? Colors.black: Colors.white,
                    ),
                    )
                  ],
                ),
              ),
              if(!isMe)CircleAvatar(
                backgroundImage: NetworkImage(image),
              ),


      ],
    );
  }
}