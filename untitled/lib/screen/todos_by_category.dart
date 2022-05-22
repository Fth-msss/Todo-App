import 'package:flutter/material.dart';
import 'package:untitled/services/todo_service.dart';
import '../models/todo.dart';

class TodosByCategory extends StatefulWidget {
 final   category;
  TodosByCategory({this.category});

  @override
  State<TodosByCategory> createState() => _TodosByCategoryState();
}

class _TodosByCategoryState extends State<TodosByCategory> {
  List<Todo> _todolist = <Todo>[];
  TodoService _todoService = TodoService();

  @override
  void initState(){
    super.initState();
    getTodosByCategories();
  }

  getTodosByCategories() async{
    var todos= await _todoService.readTodosByCategory(this.widget.category);
    todos.forEach((todo){
      var model = Todo();
      model.title=todo['title'];
      model.description=todo['description'];
      model.todoDate=todo['todoDate'];

      _todolist.add(model);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos by Category'),
      ),
      body: Column(
        children: <Widget>[
         Expanded(child: ListView.builder(
             itemCount:_todolist.length,
             itemBuilder: (context,index){
               return Card(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(0)
                 ),
                 elevation: 8,
                 child: ListTile(
                   title: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Text(_todolist[index].title ?? 'No Title')
                     ],
                   ),
                   subtitle: Text(_todolist[index].description ?? 'No description'),
                   trailing: Text(_todolist[index].todoDate ?? 'No Date'),
                 )
               );
             }))
        ],
      ),
    );
  }
}

