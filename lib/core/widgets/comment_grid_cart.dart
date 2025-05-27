import 'package:flutter/material.dart';

import '../../features/home/data/models/comment.dart';

class CommentGridCart extends StatelessWidget {
  const CommentGridCart({super.key,
    required this.comment,
    required this.onTap,
    required this.onDelete,
    required this.onEdit});

  final Comment comment;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        surfaceTintColor: Colors.lightBlueAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridTile(
            footer: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: onEdit,
                    style:
                    ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightBlue)),
                    child: Text(
                      (comment.id ?? 0).toString(),
                      style: TextStyle(fontSize: 18,color: Colors.black),
                    )
                ),
                IconButton(
                    onPressed: onDelete,
                    icon: Icon(Icons.delete,color: Colors.red,)
                ),
              ],
            ),
            child: SizedBox(
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text("Name : ",
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      ),
                      Flexible(
                        child: Text(comment.name ?? '',maxLines: 1,
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                  Text("Comment : ",
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Flexible(
                    flex: 1,
                    child: Text(comment.body ?? '',maxLines: 2,
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}