import 'package:flutter/material.dart';
import '../../features/home/data/models/comment.dart';

class CommentListCart extends StatelessWidget {
  const CommentListCart({super.key,
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
    return Card(
      elevation: 2,
      surfaceTintColor: Colors.lightBlueAccent,
      child: ListTile(
        onTap: onTap,
        leading: TextButton(
          onPressed: onEdit,style:
        ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.lightBlue)),
            child: Text((comment.id ?? 0).toString(),
              style: TextStyle(fontSize: 18,color: Colors.black),
            )
        ),
        title: Text(comment.name ?? '',maxLines: 1,
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        subtitle: Text(comment.body ?? '',maxLines: 2,),
        trailing: Column(
          children: [
            IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete,color: Colors.red,)
            ),
          ],
        ),
      ),
    );
  }
}
