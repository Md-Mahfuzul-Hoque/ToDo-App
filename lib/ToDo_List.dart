import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoItem {
  final String title;
  bool isCompleted;

  TodoItem({required this.title, this.isCompleted = false});

  Map<String, dynamic> toJson() => {
    'title': title,
    'isCompleted': isCompleted,
  };

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TodoItem> _todoList = [];

  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodoList();
  }


  void _loadTodoList() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todoString = prefs.getString('todoList');

    if (todoString != null) {
      final List<dynamic> jsonList = jsonDecode(todoString);
      setState(() {
        _todoList = jsonList.map((item) => TodoItem.fromJson(item)).toList();
      });
    }
  }

  void _saveTodoList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList = _todoList.map((item) => item.toJson()).toList();
    final String todoString = jsonEncode(jsonList);

    prefs.setString('todoList', todoString);
  }


  void _addTask() {
    String task = _taskController.text.trim();
    if (task.isNotEmpty) {
      setState(() {
        _todoList.add(TodoItem(title: task));
      });
      _saveTodoList();
      _taskController.clear();
      Navigator.pop(context);
    }
  }

  void _toggleTodoStatus(int index) {
    setState(() {
      _todoList[index].isCompleted = !_todoList[index].isCompleted;
    });
    _saveTodoList();
  }

  void _deleteTodoItem(int index) {
    setState(() {
      _todoList.removeAt(index);
    });
    _saveTodoList();
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            controller: _taskController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter task details'),
            onSubmitted: (value) => _addTask(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My To-Do List'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: _todoList.isEmpty
          ? const Center(
        child: Text(
          'No tasks yet. Click "+" to add one!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          final todo = _todoList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            elevation: 2,
            child: ListTile(
              leading: Checkbox(
                value: todo.isCompleted,
                onChanged: (bool? checked) {
                  _toggleTodoStatus(index);
                },
                activeColor: Colors.teal,
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  fontSize: 17,
                  decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                  color: todo.isCompleted ? Colors.grey : Colors.black,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _deleteTodoItem(index);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}