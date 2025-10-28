import 'package:flutter/material.dart';
import 'package:liaqat_qadir_backend/models/priority.dart';
import 'package:liaqat_qadir_backend/models/task.dart';
import 'package:liaqat_qadir_backend/service/task.dart';
import 'package:provider/provider.dart';

class GetPriorityTaskView extends StatelessWidget {
  final PriorityModel model;
  const GetPriorityTaskView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Priority Task")),
      body: StreamProvider.value(
        value: TaskService().getPriorityTask(model.docId.toString()),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[i].title.toString()),
                subtitle: Text(taskList[i].description.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
