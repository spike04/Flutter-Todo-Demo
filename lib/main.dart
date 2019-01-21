import 'package:flutter/material.dart';
import 'package:todo_demo/models/TodoItem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TodoItem> todoItems = [];

  TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text('Todo List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear_all),
            tooltip: 'Clear All Todos',
            onPressed: () {
              setState(() {
                todoItems.clear();
              });
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _showTodoItemCount(),
          _buildTodoList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add Todo...',
        onPressed: () {
          _showTodoAlertDialog(context);
        },
      ),
    );
  }

  Widget _showTodoItemCount() {
    return Container(
      width: double.infinity,
      color: Colors.purple[400],
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Total Todo Items: ' + todoItems.length.toString(),
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTodoList() {
    return Column(
      children: todoItems.map((todo) => _buildTodoItem(todo)).toList(),
    );
  }

  Widget _buildTodoItem(TodoItem item) {
    return CheckboxListTile(
      value: item.isDone,
      title: Text(
        item.title,
        style: TextStyle(
          decoration:
              (item.isDone) ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      onChanged: (val) {
        _updateTodoDone(item, val);
      },
    );
  }

  void _showTodoAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Todo'),
          content: TextField(
            autofocus: true,
            controller: todoController,
            decoration: InputDecoration(
              hintText: 'Eg. Go For Shopping',
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Icon(Icons.clear),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Icon(Icons.done),
              onPressed: () {
                _addNewTodo();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _addNewTodo() {
    String todo = todoController.value.text;
    if (todo.length > 0) {
      setState(() {
        todoItems.add(TodoItem(todo, false));
        todoController.clear();
      });
    }
  }

  void _updateTodoDone(TodoItem item, bool val) {
    int index = todoItems.indexOf(item);
    setState(() {
      todoItems[index].isDone = val;
    });
  }
}
