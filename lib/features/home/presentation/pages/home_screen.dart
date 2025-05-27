import 'package:api_method/core/network/network_connect.dart';
import 'package:api_method/core/widgets/comment_list_cart.dart';
import 'package:api_method/core/widgets/gridview_of_comments.dart';
import 'package:api_method/core/widgets/listview_of_comments.dart';
import 'package:api_method/features/home/data/models/comment.dart';
import 'package:api_method/features/home/presentation/widgets/detail_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/comment_grid_cart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Comment> commentsAll = [];
  List<Comment> commentsSingleList = [];
  bool isLoading = false;
  int? selectedPostId;
  bool isGridView = true;



  @override
  void initState() {
    super.initState();
    _fetchAllComments();
  }

  Future<void> _fetchAllComments() async {
    commentsAll = await CommentService().getAllComments();
    setState(() {
      isLoading = true;
    });
  }
  

  Future<void> _deleteComment(int commentId,List comments) async {
    bool success = await CommentService().deleteComment(commentId);
    if (success) {
      setState(() {
        comments.removeWhere((comment) => comment.id == commentId);
      });
    }
  }



  void _showCreateCommentDialog() {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController emailCtrl = TextEditingController();
    final TextEditingController bodyCtrl = TextEditingController();

    showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Create Comment"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: bodyCtrl,
                decoration: InputDecoration(labelText: "Body"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final newComment = await CommentService().createComment(
                  nameCtrl.text,
                  emailCtrl.text,
                  bodyCtrl.text,
                );

                if (newComment != null) {
                  setState(() {
                    commentsAll.add(newComment);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text("Submit"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _showEditCommentDialog(Comment comment) {
    final TextEditingController nameCtrl = TextEditingController(text: comment.name);
    final TextEditingController emailCtrl = TextEditingController(text: comment.email);
    final TextEditingController bodyCtrl = TextEditingController(text: comment.body);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Comment"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: bodyCtrl,
                decoration: InputDecoration(labelText: "Body"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                bool success = await CommentService().updateComment(
                  comment.id!,
                  nameCtrl.text,
                  emailCtrl.text,
                  bodyCtrl.text,
                );

                if (success) {
                  setState(() {
                    comment.name = nameCtrl.text;
                    comment.email = emailCtrl.text;
                    comment.body = bodyCtrl.text;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text("Update"),
            ),
            TextButton(
              onPressed: () {Navigator.of(context).pop(); },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final postIds = [1, 2, 3, 4, 5];
    final filteredComments = selectedPostId == null
        ? commentsAll
        : commentsSingleList;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Methods",
          style: TextStyle(color: Colors.black, fontSize: 32),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: RefreshIndicator(
        onRefresh: _fetchAllComments,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  spacing: 8.0,
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      selected: selectedPostId == null,
                      selectedColor: Colors.lightBlue,
                      onSelected: (bool selected) async {
                        commentsAll = await CommentService().getAllComments();
                        setState(() {
                          selectedPostId = null;
                        });
                      },
                    ),
                    ...postIds.map((id) {
                      return FilterChip(
                        label: Text('Post $id'),
                        selected: selectedPostId == id,
                        selectedColor: Colors.lightBlue,
                        onSelected: (bool selected) async {
                          commentsSingleList = await CommentService().getSingleComments(id);
                          setState(() {
                            selectedPostId = selected ? id : null;
                          });
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
            IconButton(
              color: Colors.lightBlue,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
              icon: Icon(isGridView ? Icons.grid_view_rounded: Icons.view_list),
              onPressed: () {
                setState(() {
                  isGridView = !isGridView;
                });
              },
            ),


            Expanded(
              child: isLoading
                  ? isGridView
                  ? GridViewOfComments(
                itemCount: filteredComments.length,
                itemBuilder:(context,index){
                  final comment = filteredComments[index];
                  return CommentGridCart(
                    comment: comment,
                    onTap: () => Navigator.push(context,MaterialPageRoute(
                        builder: (context)=> DetailScreen(comment: comment))),
                    onDelete: () => _deleteComment(comment.id!,filteredComments),
                    onEdit: () => _showEditCommentDialog(comment),
                  );
                },
              )
                  : ListViewOfComments(
                itemCount: filteredComments.length,
                itemBuilder:(context,index){
                  final comment = filteredComments[index];
                  return CommentListCart(
                    comment: comment,
                    onTap: () => Navigator.push(context,MaterialPageRoute(
                        builder: (context)=> DetailScreen(comment: comment))),
                    onDelete: () => _deleteComment(comment.id!,filteredComments),
                    onEdit: () => _showEditCommentDialog(comment),
                  );
                },
              )
                  : const Center(child: CircularProgressIndicator()),
            ),

            // Expanded(
            //   child: isLoading
            //       ? isGridView
            //         ? GridViewOfComments(
            //             itemCount: filteredComments.length,
            //             itemBuilder:(context,index){
            //             final comment = filteredComments[index];
            //             return CommentGridCart(
            //               comment: comment,
            //               onTap: () => Navigator.push(context,MaterialPageRoute(
            //                  builder: (context)=> DetailScreen(comment: comment))),
            //               onDelete: () => _deleteComment(comment.id!,filteredComments),
            //               onEdit: () => _showEditCommentDialog(comment),
            //             );
            //             },
            //       )
            //         : ListViewOfComments(
            //     itemCount: filteredComments.length,
            //     itemBuilder:(context,index){
            //       final comment = filteredComments[index];
            //       return CommentListCart(
            //         comment: comment,
            //         onTap: () => Navigator.push(context,MaterialPageRoute(
            //             builder: (context)=> DetailScreen(comment: comment))),
            //         onDelete: () => _deleteComment(comment.id!,filteredComments),
            //         onEdit: () => _showEditCommentDialog(comment),
            //       );
            //     },
            //   )
            //       : const Center(child: CircularProgressIndicator()),
            // ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateCommentDialog(),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

