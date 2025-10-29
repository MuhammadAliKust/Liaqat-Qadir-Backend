import 'package:flutter/material.dart';
import 'package:liaqat_qadir_backend/models/task.dart';
import 'package:liaqat_qadir_backend/service/task.dart';
import 'package:provider/provider.dart';

class GetFavoriteTasks extends StatelessWidget {
  const GetFavoriteTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Favorite Task")),
      body: StreamProvider.value(
        value: TaskService().getMyFavoriteTasks('1'),
        
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
