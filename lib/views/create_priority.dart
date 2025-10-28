import 'package:flutter/material.dart';
import 'package:liaqat_qadir_backend/models/priority.dart';
import 'package:liaqat_qadir_backend/models/task.dart';
import 'package:liaqat_qadir_backend/service/priority.dart';
import 'package:liaqat_qadir_backend/service/task.dart';

class CreatePriorityView extends StatefulWidget {
  CreatePriorityView({super.key});

  @override
  State<CreatePriorityView> createState() => _CreatePriorityViewState();
}

class _CreatePriorityViewState extends State<CreatePriorityView> {
  TextEditingController titleController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Priorit")),
      body: Column(
        children: [
          TextField(controller: titleController),
          SizedBox(height: 20),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Title cannot be empty.")),
                      );
                      return;
                    }
                    try {
                      isLoading = true;
                      setState(() {});
                      PriorityServices()
                          .createPriority(
                            PriorityModel(
                              name: titleController.text,

                              createdAt: DateTime.now().millisecondsSinceEpoch,
                            ),
                          )
                          .then((val) {
                            isLoading = false;
                            setState(() {});
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text(
                                    "Prioirity has been created successfully.",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Okay"),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Create Priority"),
                ),
        ],
      ),
    );
  }
}
