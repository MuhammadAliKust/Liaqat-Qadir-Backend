import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liaqat_qadir_backend/models/task.dart';

class TaskService {
  String taskList = "TasksCollection";

  //create Task
  Future createTask(TaskModel model) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('taskCollection')
        .doc();
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(docRef.id)
        .set(model.toJson(docRef.id));
  }

  //update Task
  Future updateTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({"title": model.title, "description": model.description});
  }

  //delete Task
  Future deleteTask(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .delete();
  }

  //mark As Completed
  Future markAsCompleted(TaskModel model) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(model.docId)
        .update({'isCompleted': true});
  }

  //get All Tasks
  Stream<List<TaskModel>> getAllTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .snapshots()
        .map(
          (list) => list.docs
              .map((taskJson) => TaskModel.fromJson(taskJson.data()))
              .toList(),
        );
  }

  //get Completed Task
  Stream<List<TaskModel>> getCompletedTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: true)
        .snapshots()
        .map(
          (list) => list.docs
              .map((taskJson) => TaskModel.fromJson(taskJson.data()))
              .toList(),
        );
  }

  //get Priority Task
  Stream<List<TaskModel>> getPriorityTask(String priorirtyID) {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('priorityID', isEqualTo: priorirtyID)
        .snapshots()
        .map(
          (list) => list.docs
              .map((taskJson) => TaskModel.fromJson(taskJson.data()))
              .toList(),
        );
  }

  //get InCompleted Task
  Stream<List<TaskModel>> getInCompletedTask() {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('isCompleted', isEqualTo: false)
        .snapshots()
        .map(
          (list) => list.docs
              .map((taskJson) => TaskModel.fromJson(taskJson.data()))
              .toList(),
        );
  }

  ///Add to Favorite
  Future addToFavorite({required String taskID, required String userID}) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .update({
          'favorite': FieldValue.arrayUnion([userID]),
        });
  }

  ///Remove from Favorite
  Future removeFromFavorite({
    required String taskID,
    required String userID,
  }) async {
    return await FirebaseFirestore.instance
        .collection('taskCollection')
        .doc(taskID)
        .update({
          'favorite': FieldValue.arrayRemove([userID]),
        });
  }

  ///Get my Favorite Tasks
  Stream<List<TaskModel>> getMyFavoriteTasks(String userID) {
    return FirebaseFirestore.instance
        .collection('taskCollection')
        .where('favorite', arrayContains: userID)
        .snapshots()
        .map(
          (list) => list.docs
              .map((taskJson) => TaskModel.fromJson(taskJson.data()))
              .toList(),
        );
  }
}
