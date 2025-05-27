import 'package:api_method/features/home/data/models/comment.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
          "Method",
          style: TextStyle(color: Colors.black, fontSize: 32),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Name : ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Expanded(
                  child: Text(
                    comment.name ?? '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Text('Email : '),
                Text(comment.email ?? '',style: TextStyle(fontSize: 12,color: Colors.grey),),
              ],
            ),
            SizedBox(height: 5,),

            Text('Context : ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text(comment.body ?? '',style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
          ],
        ),
      ),
    );
  }
}
