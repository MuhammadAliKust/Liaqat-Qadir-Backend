import 'package:flutter/material.dart';
import 'package:liaqat_qadir_backend/models/priority.dart';
import 'package:liaqat_qadir_backend/models/task.dart';
import 'package:liaqat_qadir_backend/service/priority.dart';
import 'package:liaqat_qadir_backend/service/task.dart';
import 'package:liaqat_qadir_backend/views/create_priority.dart';
import 'package:liaqat_qadir_backend/views/create_task.dart';
import 'package:liaqat_qadir_backend/views/get_completed_task.dart';
import 'package:liaqat_qadir_backend/views/get_incompleted_task.dart';
import 'package:liaqat_qadir_backend/views/get_priority_task.dart';
import 'package:liaqat_qadir_backend/views/update_task.dart';
import 'package:provider/provider.dart';

class GetAllPriorityView extends StatelessWidget {
  const GetAllPriorityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get All Priority")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePriorityView()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: PriorityServices().getAllPriorities(),
        initialData: [PriorityModel()],
        builder: (context, child) {
          List<PriorityModel> priorityList = context
              .watch<List<PriorityModel>>();
          return ListView.builder(
            itemCount: priorityList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.category),
                title: Text(priorityList[i].name.toString()),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GetPriorityTaskView(model: priorityList[i]),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
