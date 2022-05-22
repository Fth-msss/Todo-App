import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/services/category_service.dart';

import '../models/todo.dart';
import '../services/todo_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var todoTitleController=TextEditingController();
  var todoDescriptionController=TextEditingController();
  var todoDateController =TextEditingController();
  var _selectedValue;
  var _categories = <DropdownMenuItem>[];
  var date='err';

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  void initState(){
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1980),
        lastDate: DateTime(2050));
    if (pickedDate != null)
        setState(() {
        currentDate = pickedDate;
        date= DateFormat('yyyy-MM-dd').format(currentDate).toString();
        todoDateController.text=date;

      });
  }

  _showSuccessSnackBar(message){
    var _snackBar =SnackBar(content: message);
    _globalKey.currentState?.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('Create Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: todoTitleController,
              decoration: InputDecoration(
                labelText: 'Title',
                    hintText:'Write Todo Title'
              ),
            ),
            TextField(
              controller: todoDescriptionController,
              decoration: InputDecoration(
                  labelText: 'Description',
                  hintText:'Write Todo Description'
              ),
            ),
            TextField(
              controller: todoDateController,

              decoration: InputDecoration(

                  labelText: 'Date',
                  hintText:'Pick a Date',
                  prefixIcon:InkWell(
                    onTap: (){
                    _selectDate(context);
                    },
                    child:Icon(Icons.calendar_today) ,
                  )
              ),
            ),
            DropdownButtonFormField<dynamic>(
                items: _categories,

                value: _selectedValue,
                onChanged: (value){
                  setState((){
                    _selectedValue=value;
                  });

                }),
            SizedBox(
              height: 20,
            ),
            RaisedButton(onPressed: () async{
              var todoObject = Todo();

              todoObject.title=todoTitleController.text;
              todoObject.description=todoDescriptionController.text;
              todoObject.isFinished=0;
              todoObject.category=_selectedValue.toString();
              todoObject.todoDate=todoDateController.text;

              var _todoService = TodoService();
              var result = await _todoService.saveTodo(todoObject);

              if(result>0){
                _showSuccessSnackBar(Text('Created'));
              }



            },
            color: Colors.blue,
            child: Text('Save',style: TextStyle(color: Colors.white)),)
          ],
        ),
      ),
    );
  }
}
