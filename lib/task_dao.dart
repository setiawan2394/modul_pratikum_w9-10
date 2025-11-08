import 'package:floor/floor.dart';
import 'task_entity.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM Task ORDER BY id DESC')
  Future<List<Task>> findAll();

  @insert
  Future<int> insertTask(Task task);

  @update
  Future<int> updateTask(Task task);

  @delete
  Future<int> deleteTask(Task task);
}
