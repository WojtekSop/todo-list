import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // Lista zadań
  List<TodoItem> _tasks = [];

  // Kontroler do TextField
  TextEditingController _controller = TextEditingController();

  // Funkcja dodająca zadanie
  void _addTask(String task) {
    if (task.isEmpty) return;
    setState(() {
      _tasks.add(TodoItem(task: task, isCompleted: false));
    });
    _controller.clear();
  }

  // Funkcja usuwająca zadanie
  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // Funkcja oznaczająca zadanie jako wykonane
  void _toggleCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Pole tekstowe i przycisk do dodawania zadań
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Nowe zadanie'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addTask(_controller.text),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return ListTile(
                    title: Text(
                      task.task,
                      style: TextStyle(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    leading: IconButton(
                      icon: Icon(
                        task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
                      ),
                      onPressed: () => _toggleCompletion(index),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeTask(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model reprezentujący zadanie
class TodoItem {
  String task;
  bool isCompleted;

  TodoItem({required this.task, this.isCompleted = false});
}