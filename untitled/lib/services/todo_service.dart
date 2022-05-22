import 'package:untitled/repositories/repository.dart';
import 'package:untitled/models/todo.dart';

class TodoService{
  Repository? _repository;

  TodoService(){
    _repository=Repository();
  }

  saveTodo(Todo todo)async{
    return await _repository?.insertData('todos', todo.todoMap());
  }

  readTodos()async{
    return await _repository?.readData('todos');
  }

  // read by category
readTodosByCategory(category) async{
    return await _repository?.readDataByColumnName('todos', 'category', category);
}
}