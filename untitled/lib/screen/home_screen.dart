import 'package:flutter/material.dart';
import 'package:untitled/helpers/drawer_navigation.dart';
import 'package:untitled/screen/todo_screen.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  TodoService? _todoService;

  List<Todo> _todoList = <Todo>[];

  @override
  initState(){
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
    _todoService =TodoService();
    _todoList =<Todo>[];
    var todos = await _todoService?.readTodos();
    //ages.forEach((int age) => print(age));
    todos.forEach((todo){
      setState((){
        var model=Todo();
        model.id =todo['id'];
        model.title =todo['title'];
        model.description =todo['description'];
        model.category =todo['category'];
        model.todoDate =todo['todoDate'];
        model.isFinished = todo['isFinished'];
        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('grove street,home. at least it was before'),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(itemCount: _todoList.length,itemBuilder:(context,index){
        return Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0)
          ),

          child: ListTile(
            title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(_todoList[index].title ?? 'No Title')
            ],
          ),
        subtitle: Text(_todoList[index].category ?? 'No Category'),
        trailing: Text(_todoList[index].todoDate ?? 'No Date'),
         )
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TodoScreen()));
          },
        child: Icon(Icons.add),
      ),
    );
  }
}
